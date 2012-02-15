package com.codeazur.as3swf.data.abc.exporters
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.ABCClassInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.ABCJavascriptClassBuilder;
	import com.codeazur.as3swf.data.abc.exporters.core.IABCExporter;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCJavascriptExporter implements IABCExporter {
		
		public var abcData:ABCData;
		
		public function ABCJavascriptExporter(data:ABCData) {
			abcData = data;
		}
		
		public function write(data:ByteArray) : void {
			const total:uint = abcData.classInfoSet.length;
			for(var i:uint=0; i<total; i++) {
				const classInfo:ABCClassInfo = abcData.classInfoSet.getAt(i);
				
				const classQName:ABCQualifiedName = classInfo.qname.toQualifiedName();
				const classBuilder:IABCClassBuilder = ABCJavascriptClassBuilder.create(classQName);
				
				classBuilder.write(data);
			}
		}
		
		public function get name():String { return "ABCJavascriptExporter"; }
		
		public function toString(indent:uint):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
