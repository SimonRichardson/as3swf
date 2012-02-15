package com.codeazur.as3swf.data.abc.exporters.builders
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedName;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCClassConstructorBuilder extends IABCBuilder {
		
		function get qname():ABCQualifiedName;
		function set qname(value:ABCQualifiedName):void;
		
		function get instanceInfo():ABCInstanceInfo;
		function set instanceInfo(value:ABCInstanceInfo):void;
	}
}
