package com.codeazur.as3swf.data.abc.exporters.builders
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCMatcher extends IABCBuilder {
		
		function get value():IABCValueBuilder;
		function set value(data:IABCValueBuilder):void;
		
	}
}
