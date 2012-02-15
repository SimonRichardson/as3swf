package com.codeazur.as3swf.data.abc.exporters.builders
{
	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCBuilder {
		
		
		function write(data:ByteArray):void;
	}
}
