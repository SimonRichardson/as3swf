package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.utils.StringUtils;
	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeJumpTargetPosition {

		public var opcode:ABCOpcode;
		public var start:uint;
		public var finish:uint;

		public function ABCOpcodeJumpTargetPosition() {}
		
		public static function create(opcode:ABCOpcode, start:uint, finish:uint):ABCOpcodeJumpTargetPosition {
			const position:ABCOpcodeJumpTargetPosition = new ABCOpcodeJumpTargetPosition();
			position.opcode = opcode;
			position.start = start;
			position.finish = finish;
			return position;
		}
		
		public function contains(position:uint):Boolean {
			return position >= start && position <= finish;
		}
		
		public function get name():String { return "ABCOpcodeJumpTargetPosition"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Opcode:\n";
			str += opcode.toString(indent + 4) + "\n";
			
			str += StringUtils.repeat(indent + 2) + "Start: " + start + "\n";
			str += StringUtils.repeat(indent + 2) + "Finish: " + finish + "\n";
			
			return str; 
		}

	}
}
