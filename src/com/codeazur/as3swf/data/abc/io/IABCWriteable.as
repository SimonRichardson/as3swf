package com.codeazur.as3swf.data.abc.io
{
	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCWriteable
	{
		
		function write(data:ByteArray):void;
		
		function toString(indent:uint=0):String;
		
		function get name():String;
	}
}
