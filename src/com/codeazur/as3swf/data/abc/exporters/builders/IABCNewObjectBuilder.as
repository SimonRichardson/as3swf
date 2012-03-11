package com.codeazur.as3swf.data.abc.exporters.builders
{
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCNewObjectBuilder extends IABCBuilder {
		
		function get args():Vector.<IABCWriteable>;
		function set args(value:Vector.<IABCWriteable>):void;
	}
}
