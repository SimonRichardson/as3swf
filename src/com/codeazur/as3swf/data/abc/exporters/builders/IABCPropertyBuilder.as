package com.codeazur.as3swf.data.abc.exporters.builders
{
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCPropertyBuilder extends IABCExpression
	{
		
		function get propertyName():IABCAttributeBuilder;
		function set propertyName(value:IABCAttributeBuilder):void;
		
		function get expressions():Vector.<IABCWriteable>;
		function set expressions(value:Vector.<IABCWriteable>):void;
	}
}
