package com.codeazur.as3swf.data.abc.exporters.builders
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitInfo;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
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
