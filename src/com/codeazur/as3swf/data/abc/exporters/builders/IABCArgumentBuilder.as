package com.codeazur.as3swf.data.abc.exporters.builders
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCArgumentBuilder extends IABCBuilder
	{
		
		function get argument():ABCParameter;
		function set argument(value:ABCParameter):void;
	}
}
