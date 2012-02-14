package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeJumpTargetPosition {

		public var start:uint;
		public var finish:uint;

		public function ABCOpcodeJumpTargetPosition() {}
		
		public static function create(start:uint, finish:uint):ABCOpcodeJumpTargetPosition {
			const position:ABCOpcodeJumpTargetPosition = new ABCOpcodeJumpTargetPosition();
			position.start = start;
			position.finish = finish;
			return position;
		}
		
		public function get name():String { return "ABCOpcodeJumpTargetPosition"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			str += "Start: " + start + ", Finish: " + finish;
			return str; 
		}

	}
}
