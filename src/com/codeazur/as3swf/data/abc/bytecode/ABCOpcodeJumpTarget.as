package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeJumpTarget {
		
		public var opcode:ABCOpcode;
		public var targetOpcode:ABCOpcode;
		public var optionalTargetOpcodes:Vector.<ABCOpcode>;

		public function ABCOpcodeJumpTarget() {
			optionalTargetOpcodes = new Vector.<ABCOpcode>();
		}
		
		public static function create(opcode:ABCOpcode):ABCOpcodeJumpTarget {
			const jumpTarget:ABCOpcodeJumpTarget = new ABCOpcodeJumpTarget();
			jumpTarget.opcode = opcode;
			return jumpTarget;
		}
		
		public function get name():String { return "ABCOpcodeJumpTarget"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Opcode:";
			str += "\n" + opcode.toString(indent + 4);
			
			if(targetOpcode) {
				str += "\n" + StringUtils.repeat(indent + 2) + "TargetOpcode:";
				str += "\n" + targetOpcode.toString(indent + 4);
			}
			
			if(optionalTargetOpcodes.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "OptionalTargetOpcode:";
				str += "\n" + StringUtils.repeat(indent + 4) + optionalTargetOpcodes;
			}
			
			return str;
		}
	}
}
