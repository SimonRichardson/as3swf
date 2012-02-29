package com.codeazur.as3swf.data.abc.exporters.builders
{
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCConsumableBlock extends IABCWriteable {
		
		function get left():IABCWriteable;
		function set left(value:IABCWriteable):void;
		
		function get right():IABCWriteable;
		function set right(value:IABCWriteable):void;
	}
}
