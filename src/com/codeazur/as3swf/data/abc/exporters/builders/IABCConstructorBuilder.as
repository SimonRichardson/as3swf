package com.codeazur.as3swf.data.abc.exporters.builders
{
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCConstructorBuilder extends IABCBuilder	{
		
		function get constructorMethod():IABCApplyTypeBuilder;
		function set constructorMethod(value:IABCApplyTypeBuilder):void;
		
		function get args():Vector.<IABCWriteable>;
		function set args(value:Vector.<IABCWriteable>):void;
	}
}
