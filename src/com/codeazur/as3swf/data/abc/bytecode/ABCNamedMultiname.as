package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCNamedMultiname extends ABCBaseMultiname {
		
		public var label:String;

		public function ABCNamedMultiname() {}
		
		override public function get name():String { return "ABCNamedMultiname"; }
				
		override public function toString(indent:uint = 0):String {
			return ABC.toStringCommon(name, indent);
		}

	}
}
