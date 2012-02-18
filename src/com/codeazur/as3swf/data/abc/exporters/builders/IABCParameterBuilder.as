package com.codeazur.as3swf.data.abc.exporters.builders
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCParameterBuilder extends IABCBuilder
	{
		
		function get parameter():ABCParameter;
		function set parameter(value:ABCParameter):void;
	}
}
