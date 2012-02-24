package com.codeazur.as3swf.data.abc.exporters.builders
{
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCVariableBuilder extends IABCBuilder {
		
		function get variable():ABCQualifiedName;
		function set variable(value:ABCQualifiedName):void;
		
		function get expression():IABCWriteable;
		function set expression(value:IABCWriteable):void;
		
		function get includeKeyword():Boolean;
		function set includeKeyword(value:Boolean):void;
	}
}
