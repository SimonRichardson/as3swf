package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcode extends ABCSet {

		public var kind:ABCOpcodeKind;

		public function ABCOpcode(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData, kind:ABCOpcodeKind):ABCOpcode {
			const opcode:ABCOpcode = new ABCOpcode(abcData);
			opcode.kind = kind;
			return opcode;
		}
		
		override public function get name():String { return "ABCOpcode"; }
		
		override public function toString(indent:uint=0) : String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
