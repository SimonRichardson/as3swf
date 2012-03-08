package com.codeazur.as3swf.data.abc.exporters.builders
{
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCPropertyBuilder extends IABCExpression
	{
		
		function get qname():ABCQualifiedName;
		function set qname(value:ABCQualifiedName):void;
		
		function get expressions():Vector.<IABCWriteable>;
		function set expressions(value:Vector.<IABCWriteable>):void;
	}
}
