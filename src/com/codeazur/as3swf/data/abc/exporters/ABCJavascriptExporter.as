package com.codeazur.as3swf.data.abc.exporters
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.ABCClassInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassStaticBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSClassBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSClassStaticBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;

	import flash.utils.ByteArray;


	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCJavascriptExporter implements IABCExporter {
		
		public static const PREFIX:String = "__flash__";
		
		public static const LOCAL_PREFIX:String = "__local__";
		
		public var abcData:ABCData;
		
		public function ABCJavascriptExporter(data:ABCData) {
			abcData = data;
		}
		
		public function write(data:ByteArray) : void {
			const classInfoTotal:uint = abcData.classInfoSet.length;
			for(var i:uint=0; i<classInfoTotal; i++) {
				
				const classInfo:ABCClassInfo = abcData.classInfoSet.getAt(i);
				const instanceInfo:ABCInstanceInfo = abcData.instanceInfoSet.getAt(i);
				
				// constructor
				const classQName:ABCQualifiedName = classInfo.qname.toQualifiedName();
				const classBuilder:IABCClassBuilder = JSClassBuilder.create(classQName);
				classBuilder.classInfo = classInfo;
				classBuilder.instanceInfo = instanceInfo;
				classBuilder.write(data);
				
				// methods
				// TODO : Make sure we only output the right methods for the class
//				const methodInfoSet:uint = abcData.methodInfoSet.length;
//				for(var j:uint=0; j<methodInfoSet; j++) {
//					const methodInfo:ABCMethodInfo = abcData.methodInfoSet.getAt(j);
//					if(!StringUtils.isEmpty(methodInfo.methodName) && !methodInfo.isConstructor) {
//						const methodBuilder:IABCMethodBuilder = JSMethodBuilder.create(methodInfo);
//						methodBuilder.write(data);
//					}
//				}

				// statics
				if(classInfo.traits.length > 0) {
					
					JSTokenKind.RIGHT_CURLY_BRACKET.write(data);
					JSTokenKind.COMMA.write(data);
					
					const staticBuilder:IABCClassStaticBuilder = JSClassStaticBuilder.create();
					staticBuilder.traits = classInfo.traits;
					staticBuilder.write(data);
				}
				
				JSTokenKind.RIGHT_CURLY_BRACKET.write(data);
				JSTokenKind.RIGHT_PARENTHESES.write(data);
				JSTokenKind.SEMI_COLON.write(data);
			}
		}
		
		public function get name():String { return "ABCJavascriptExporter"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
