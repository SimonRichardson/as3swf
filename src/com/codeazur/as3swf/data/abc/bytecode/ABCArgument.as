package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCArgument {

		public var qname:IABCMultiname;

		public function ABCArgument() {}
		
		public static function create(qname:IABCMultiname):ABCArgument {
			const argument:ABCArgument = new ABCArgument();
			argument.qname = qname;
			return argument;
		}
		
		public function get name():String { return "ABCMethodInfo"; }
		
		public function toString(indent:uint = 0) : String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
