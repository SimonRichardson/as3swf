package com.codeazur.as3swf.data.abc.exporters.builders
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCBuilder;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCMethodParameterBuilder extends IABCBuilder	{
		
		function get parameters():Vector.<ABCParameter>;
		function set parameters(value:Vector.<ABCParameter>):void;
	}
}
