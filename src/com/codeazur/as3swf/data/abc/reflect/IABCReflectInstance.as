package com.codeazur.as3swf.data.abc.reflect
{

	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCReflectInstance {
		
		function get kind():ABCReflectKind;
		function get qname():IABCMultiname;
	}
}
