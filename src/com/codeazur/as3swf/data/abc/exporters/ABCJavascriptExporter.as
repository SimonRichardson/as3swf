package com.codeazur.as3swf.data.abc.exporters
{
	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSMethodBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodBuilder;
	import com.codeazur.utils.StringUtils;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.ABCClassInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSClassBuilder;
	import com.codeazur.as3swf.data.abc.exporters.core.IABCExporter;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCJavascriptExporter implements IABCExporter {
		
		public static const PRE_FIX:String = "__as3_";
		
		public var abcData:ABCData;
		
		public function ABCJavascriptExporter(data:ABCData) {
			abcData = data;
		}
		
		public function write(data:ByteArray) : void {
			const classInfoTotal:uint = abcData.classInfoSet.length;
			for(var i:uint=0; i<classInfoTotal; i++) {
				const classInfo:ABCClassInfo = abcData.classInfoSet.getAt(i);
				const instanceInfo:ABCInstanceInfo = abcData.instanceInfoSet.getAt(i);
				
				const classQName:ABCQualifiedName = classInfo.qname.toQualifiedName();
				const classBuilder:IABCClassBuilder = JSClassBuilder.create(classQName);
				classBuilder.classInfo = classInfo;
				classBuilder.instanceInfo = instanceInfo;
				classBuilder.write(data);
			}
			
			const methodInfoSet:uint = abcData.methodInfoSet.length;
			for(var j:uint=0; j<methodInfoSet; j++) {
				const methodInfo:ABCMethodInfo = abcData.methodInfoSet.getAt(j);
				if(!StringUtils.isEmpty(methodInfo.methodName) && !methodInfo.isConstructor) {
					const methodBuilder:IABCMethodBuilder = JSMethodBuilder.create(methodInfo);
					methodBuilder.write(data);
					
					if(j > 2) {
						break;
					}
				}
			}
		}
		
		public function get name():String { return "ABCJavascriptExporter"; }
		
		public function toString(indent:uint):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
