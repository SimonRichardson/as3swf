package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCTraitInfo {

		public function ABCTraitInfo() {}

		public function get name():String { return "ABCTraitInfo"; }
		
		public function toString(indent:uint = 0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
