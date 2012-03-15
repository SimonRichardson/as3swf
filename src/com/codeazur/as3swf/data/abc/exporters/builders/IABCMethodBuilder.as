package com.codeazur.as3swf.data.abc.exporters.builders
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCMethodBuilder extends IABCBuilder {
		
		function get methodInfo():ABCMethodInfo;
		function set methodInfo(value:ABCMethodInfo):void;
		
		function get traits():Vector.<ABCTraitInfo>;
		function set traits(value:Vector.<ABCTraitInfo>):void;
	}
}
