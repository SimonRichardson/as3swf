package com.codeazur.as3swf.data.abc.exporters.builders
{
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCMultinameAttributeBuilder extends IABCAttributeBuilder
	{
		function get multiname():IABCMultiname;
		function set multiname(value:IABCMultiname):void;
	}
}
