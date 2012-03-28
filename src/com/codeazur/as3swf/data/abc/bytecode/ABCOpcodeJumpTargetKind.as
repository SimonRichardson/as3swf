package com.codeazur.as3swf.data.abc.bytecode
{
	import flash.utils.Dictionary;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeJumpTargetKind {
		
		private static var _types:Dictionary = new Dictionary();
		
		public static const IF_EQ:ABCOpcodeJumpTargetKind = new ABCOpcodeJumpTargetKind(ABCOpcodeKind.IFEQ);
		public static const IF_GE:ABCOpcodeJumpTargetKind = new ABCOpcodeJumpTargetKind(ABCOpcodeKind.IFGE);
		public static const IF_GT:ABCOpcodeJumpTargetKind = new ABCOpcodeJumpTargetKind(ABCOpcodeKind.IFGT);
		public static const IF_LE:ABCOpcodeJumpTargetKind = new ABCOpcodeJumpTargetKind(ABCOpcodeKind.IFLE);
		public static const IF_LT:ABCOpcodeJumpTargetKind = new ABCOpcodeJumpTargetKind(ABCOpcodeKind.IFLT);
		public static const IF_NE:ABCOpcodeJumpTargetKind = new ABCOpcodeJumpTargetKind(ABCOpcodeKind.IFNE);
		public static const IF_NGE:ABCOpcodeJumpTargetKind = new ABCOpcodeJumpTargetKind(ABCOpcodeKind.IFNGE);
		public static const IF_NGT:ABCOpcodeJumpTargetKind = new ABCOpcodeJumpTargetKind(ABCOpcodeKind.IFNGT);
		public static const IF_NLE:ABCOpcodeJumpTargetKind = new ABCOpcodeJumpTargetKind(ABCOpcodeKind.IFNLE);
		public static const IF_NLT:ABCOpcodeJumpTargetKind = new ABCOpcodeJumpTargetKind(ABCOpcodeKind.IFNLT);
		public static const IF_STRICT_EQ:ABCOpcodeJumpTargetKind = new ABCOpcodeJumpTargetKind(ABCOpcodeKind.IFSTRICTEQ);
		public static const IF_STRICT_NE:ABCOpcodeJumpTargetKind = new ABCOpcodeJumpTargetKind(ABCOpcodeKind.IFSTRICTNE);
		public static const IF_FALSE:ABCOpcodeJumpTargetKind = new ABCOpcodeJumpTargetKind(ABCOpcodeKind.IFFALSE);
		public static const IF_TRUE:ABCOpcodeJumpTargetKind = new ABCOpcodeJumpTargetKind(ABCOpcodeKind.IFTRUE);
		public static const JUMP:ABCOpcodeJumpTargetKind = new ABCOpcodeJumpTargetKind(ABCOpcodeKind.JUMP);
		public static const LOOK_UP_SWITCH:ABCOpcodeJumpTargetKind = new ABCOpcodeJumpTargetKind(ABCOpcodeKind.LOOKUPSWITCH);

		private var _type:ABCOpcodeKind;

		public function ABCOpcodeJumpTargetKind(type:ABCOpcodeKind) {
			_type = type;
			_types[type] = this;
		}
		
		public static function isKind(opcode:ABCOpcode):Boolean {
			return _types[opcode.kind];
		}
		
		public static function isType(target:ABCOpcodeJumpTarget, kind:ABCOpcodeKind):Boolean {
			return target.opcode.kind === kind;
		}
	}
}
