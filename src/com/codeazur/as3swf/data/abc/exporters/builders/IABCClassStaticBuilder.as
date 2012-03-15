package com.codeazur.as3swf.data.abc.exporters.builders
{

	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCClassStaticBuilder extends IABCBuilder {
		
		function get traits():Vector.<ABCTraitInfo>;
		function set traits(value:Vector.<ABCTraitInfo>):void;
	}
}
