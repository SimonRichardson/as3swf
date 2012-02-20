package com.codeazur.as3swf.data.abc.exporters.builders
{
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCVariableBuilder extends IABCBuilder {
		
		function get variable():ABCQualifiedName;
		function set variable(value:ABCQualifiedName):void;
		
		function get expression():IABCExpression;
		function set expression(value:IABCExpression):void;
	}
}
