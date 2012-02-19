package com.codeazur.as3swf.data.abc.exporters.builders
{
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCDebugBuilder extends IABCBuilder {
		
		function get attribute():ABCOpcodeAttribute;
		function set attribute(value:ABCOpcodeAttribute):void;
	}
}
