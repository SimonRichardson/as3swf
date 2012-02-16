package com.codeazur.as3swf.data.abc.exporters.builders
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedName;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCValueBuilder extends IABCBuilder {
		
		function get value():*;
		function set value(data:*):void;
		
		function get qname():ABCQualifiedName;
		function set qname(value:ABCQualifiedName):void;
	}
}
