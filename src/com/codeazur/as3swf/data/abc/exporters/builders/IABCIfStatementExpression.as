package com.codeazur.as3swf.data.abc.exporters.builders
{
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCIfStatementExpression extends IABCWriteable
	{
		
		function get statement():IABCWriteable;
		function set statement(value:IABCWriteable):void;
		
		function get type():ABCIfStatementType;
	}
}
