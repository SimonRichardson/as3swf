package com.codeazur.as3swf.data.abc.exporters.core
{
	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCExporter {
		
		function write(datA:ByteArray):void;
	}
}
