package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCClassInfo {

		public function ABCClassInfo() {
		}
		
		public function get name() : String { return "ABCClassInfo"; }
		
		public function toString(indent : uint = 0) : String {
			return ABC.toStringCommon(name, indent);
		}

	}
}
