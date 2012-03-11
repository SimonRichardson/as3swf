package com.codeazur.as3swf.data.abc.exporters.js
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitInfo;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.ABCClassInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespaceType;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.IABCExporter;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassStaticBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSClassBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSClassStaticBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSMethodBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCJavascriptExporter implements IABCExporter {
		
		public static const PREFIX:String = "__flash__";
		
		public static const LOCAL_PREFIX:String = "__local__";
		
		public static const PACKAGE_PREFIX:String = "";
		public static const PRIVATE_PREFIX:String = "_";
		public static const PROTECTED_PREFIX:String = "_";
		
		public static const FLASH_OBJECT_NAME:String = "FlashObject";
		
		public var abcData:ABCData;
		
		public function ABCJavascriptExporter(data:ABCData) {
			abcData = data;
		}
		
		public function write(data:ByteArray) : void {
			var methodOffset:int = 0;
			
			const classInfoTotal:uint = abcData.classInfoSet.length;
			for(var i:uint=0; i<classInfoTotal; i++) {
				const classInfo:ABCClassInfo = abcData.classInfoSet.getAt(i);
				const instanceInfo:ABCInstanceInfo = abcData.instanceInfoSet.getAt(i);
				const traits:Vector.<ABCTraitInfo> = instanceInfo.traits;
				
				// constructor
				const classQName:ABCQualifiedName = classInfo.qname.toQualifiedName();
				const classBuilder:IABCClassBuilder = JSClassBuilder.create(classQName);
				classBuilder.classInfo = classInfo;
				classBuilder.instanceInfo = instanceInfo;
				classBuilder.write(data);
				
				return;
				
				// methods
				const methodTotal:uint = instanceInfo.numMethodTraits;
				for(var j:uint=0; j<methodTotal; j++) {
					const methodInfoOffset:int = methodOffset + j + 2;
					const methodInfo:ABCMethodInfo = abcData.methodInfoSet.getAt(methodInfoOffset);

					if(	!(StringUtils.isEmpty(methodInfo.methodName) || 
						  ABCNamespaceType.isTypeByValue(methodInfo.methodName, ABCNamespaceType.ASTERISK)) && 
						  !methodInfo.isConstructor) {
						
						JSTokenKind.COMMA.write(data);
												
						const methodBuilder:IABCMethodBuilder = JSMethodBuilder.create(methodInfo, traits);
						methodBuilder.write(data);
					}
				}
				methodOffset += 3 + methodTotal;
				
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
