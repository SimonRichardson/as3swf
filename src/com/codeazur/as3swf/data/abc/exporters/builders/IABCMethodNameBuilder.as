package com.codeazur.as3swf.data.abc.exporters.builders
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedName;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCMethodNameBuilder extends IABCBuilder {
		
		function get qname():ABCQualifiedName;
		function set qname(value:ABCQualifiedName):void;
	}
}
