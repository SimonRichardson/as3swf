package com.codeazur.as3swf.data.abc.exporters.builders
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCClassStaticBuilder extends IABCBuilder {
		
		function get qname():ABCQualifiedName;
		function set qname(value:ABCQualifiedName):void;
		
		function get traits():Vector.<ABCTraitInfo>;
		function set traits(value:Vector.<ABCTraitInfo>):void;
	}
}
