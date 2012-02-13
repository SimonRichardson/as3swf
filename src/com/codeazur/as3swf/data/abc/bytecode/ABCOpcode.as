package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	import com.codeazur.utils.StringUtils;
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
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Kind:";
				
			if(kind) {
				str += "\n" + kind.toString(indent + 4);
			}
			
			return str;
		}
	}
}
