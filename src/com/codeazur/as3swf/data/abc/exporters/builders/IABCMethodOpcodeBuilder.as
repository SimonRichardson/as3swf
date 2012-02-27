package com.codeazur.as3swf.data.abc.exporters.builders
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.exporters.translator.ABCOpcodeTranslateData;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCMethodOpcodeBuilder extends IABCBuilder {
		
		function get methodInfo():ABCMethodInfo;
		function set methodInfo(value:ABCMethodInfo):void;
		
		function get translateData():ABCOpcodeTranslateData;
		function set translateData(value:ABCOpcodeTranslateData):void;
	}
}
