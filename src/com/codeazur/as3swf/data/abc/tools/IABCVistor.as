package com.codeazur.as3swf.data.abc.tools
{
	import com.codeazur.as3swf.data.abc.ABCData;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCVistor
	{
		
		function visit(value:ABCData):void;
	}
}
