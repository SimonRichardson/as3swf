package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSOpcodeTerminatorKind {

		public function JSOpcodeTerminatorKind() {
		}

		public static function isType(kind:ABCOpcodeKind):Boolean {
			var result:Boolean = false;
			
			switch(kind) {
				case ABCOpcodeKind.CONSTRUCTSUPER:
				case ABCOpcodeKind.DEBUG:
				case ABCOpcodeKind.DEBUGFILE:
				case ABCOpcodeKind.DEBUGLINE:
				case ABCOpcodeKind.POP:
				case ABCOpcodeKind.POPSCOPE:
				case ABCOpcodeKind.PUSHSCOPE:
				case ABCOpcodeKind.RETURNVOID:
					result = true;
					break;
			}
			
			return result;
		}
		
		
	}
}
