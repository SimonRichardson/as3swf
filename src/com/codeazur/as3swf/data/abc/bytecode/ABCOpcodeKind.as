package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.ABC;

	import flash.utils.Dictionary;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeKind {
		
		private static const _types:Dictionary = new Dictionary();
		
		public static const EOB:ABCOpcodeKind = new ABCOpcodeKind(0x00, "eob");
		public static const ADD:ABCOpcodeKind = new ABCOpcodeKind(0xa0, "add");
		public static const ADD_D:ABCOpcodeKind = new ABCOpcodeKind(0x9B, "add_d");
		public static const ADD_I:ABCOpcodeKind = new ABCOpcodeKind(0xC5, "add_i");
		public static const APPLYTYPE:ABCOpcodeKind = new ABCOpcodeKind(0x53, "applytype");
		public static const ASTYPE:ABCOpcodeKind = new ABCOpcodeKind(0x86, "astype");
		public static const ASTYPELATE:ABCOpcodeKind = new ABCOpcodeKind(0x87, "astypelate");
		public static const BITAND:ABCOpcodeKind = new ABCOpcodeKind(0xa8, "bitand");
		public static const BITNOT:ABCOpcodeKind = new ABCOpcodeKind(0x97, "bitnot");
		public static const BITOR:ABCOpcodeKind = new ABCOpcodeKind(0xa9, "bitor");
		public static const BITXOR:ABCOpcodeKind = new ABCOpcodeKind(0xAA, "bitxor");
		public static const BKPT:ABCOpcodeKind = new ABCOpcodeKind(0x01, "bkpt");
		public static const BKPTLINE:ABCOpcodeKind = new ABCOpcodeKind(0xF2, "bkptline");
		public static const CALL:ABCOpcodeKind = new ABCOpcodeKind(0x41, "call");
		public static const CALLINTERFACE:ABCOpcodeKind = new ABCOpcodeKind(0x4D, "callinterface");
		public static const CALLMETHOD:ABCOpcodeKind = new ABCOpcodeKind(0x43, "callmethod");
		public static const CALLPROPERTY:ABCOpcodeKind = new ABCOpcodeKind(0x46, "callproperty");
		public static const CALLPROPLEX:ABCOpcodeKind = new ABCOpcodeKind(0x4C, "callproplex");
		public static const CALLPROPVOID:ABCOpcodeKind = new ABCOpcodeKind(0x4f, "callpropvoid");
		public static const CALLSTATIC:ABCOpcodeKind = new ABCOpcodeKind(0x44, "callstatic");
		public static const CALLSUPER:ABCOpcodeKind = new ABCOpcodeKind(0x45, "callsuper");
		public static const CALLSUPERID:ABCOpcodeKind = new ABCOpcodeKind(0x4B, "callsuperid");
		public static const CALLSUPERVOID:ABCOpcodeKind = new ABCOpcodeKind(0x4e, "callsupervoid");
		public static const CHECKFILTER:ABCOpcodeKind = new ABCOpcodeKind(0x78, "checkfilter");
		public static const COERCE:ABCOpcodeKind = new ABCOpcodeKind(0x80, "coerce");
		public static const COERCE_A:ABCOpcodeKind = new ABCOpcodeKind(0x82, "coerce_a");
		public static const COERCE_B:ABCOpcodeKind = new ABCOpcodeKind(0x81, "coerce_b");
		public static const COERCE_D:ABCOpcodeKind = new ABCOpcodeKind(0x84, "coerce_d");
		public static const COERCE_I:ABCOpcodeKind = new ABCOpcodeKind(0x83, "coerce_i");
		public static const COERCE_O:ABCOpcodeKind = new ABCOpcodeKind(0x89, "coerce_o");
		public static const COERCE_S:ABCOpcodeKind = new ABCOpcodeKind(0x85, "coerce_s");
		public static const COERCE_U:ABCOpcodeKind = new ABCOpcodeKind(0x88, "coerce_u");
		public static const CONCAT:ABCOpcodeKind = new ABCOpcodeKind(0x9A, "concat");
		public static const CONSTRUCT:ABCOpcodeKind = new ABCOpcodeKind(0x42, "construct");
		public static const CONSTRUCTPROP:ABCOpcodeKind = new ABCOpcodeKind(0x4a, "constructprop");
		public static const CONSTRUCTSUPER:ABCOpcodeKind = new ABCOpcodeKind(0x49, "constructsuper");
		public static const CONVERT_B:ABCOpcodeKind = new ABCOpcodeKind(0x76, "convert_b");
		public static const CONVERT_D:ABCOpcodeKind = new ABCOpcodeKind(0x75, "convert_d");
		public static const CONVERT_I:ABCOpcodeKind = new ABCOpcodeKind(0x73, "convert_i");
		public static const CONVERT_O:ABCOpcodeKind = new ABCOpcodeKind(0x77, "convert_o");
		public static const CONVERT_S:ABCOpcodeKind = new ABCOpcodeKind(0x70, "convert_s");
		public static const CONVERT_U:ABCOpcodeKind = new ABCOpcodeKind(0x74, "convert_u");
		public static const DEBUG:ABCOpcodeKind = new ABCOpcodeKind(0xEF, "debug");
		public static const DEBUGFILE:ABCOpcodeKind = new ABCOpcodeKind(0xF1, "debugfile");
		public static const DEBUGLINE:ABCOpcodeKind = new ABCOpcodeKind(0xF0, "debugline");
		public static const DECLOCAL:ABCOpcodeKind = new ABCOpcodeKind(0x94, "declocal");
		public static const DECLOCAL_I:ABCOpcodeKind = new ABCOpcodeKind(0xC3, "declocal_i");
		public static const DECREMENT:ABCOpcodeKind = new ABCOpcodeKind(0x93, "decrement");
		public static const DECREMENT_I:ABCOpcodeKind = new ABCOpcodeKind(0xc1, "decrement_i");
		public static const DELETEPROPERTY:ABCOpcodeKind = new ABCOpcodeKind(0x6a, "deleteproperty");
		public static const DELETEPROPERTYLATE:ABCOpcodeKind = new ABCOpcodeKind(0x6B, "deletepropertylate");
		public static const DIVIDE:ABCOpcodeKind = new ABCOpcodeKind(0xa3, "divide");
		public static const DUP:ABCOpcodeKind = new ABCOpcodeKind(0x2a, "dup");
		public static const DXNS:ABCOpcodeKind = new ABCOpcodeKind(0x06, "dxns");
		public static const DXNSLATE:ABCOpcodeKind = new ABCOpcodeKind(0x07, "dxnslate");
		public static const EQUALS:ABCOpcodeKind = new ABCOpcodeKind(0xab, "equals");
		public static const ESC_XATTR:ABCOpcodeKind = new ABCOpcodeKind(0x72, "esc_xattr");
		public static const ESC_XELEM:ABCOpcodeKind = new ABCOpcodeKind(0x71, "esc_xelem");
		public static const FINDDEF:ABCOpcodeKind = new ABCOpcodeKind(0x5F, "finddef");
		public static const FINDPROPERTY:ABCOpcodeKind = new ABCOpcodeKind(0x5e, "findproperty");
		public static const FINDPROPGLOBAL:ABCOpcodeKind = new ABCOpcodeKind(0x5c, "findpropglobal");
		public static const FINDPROPGLOBALSTRICT:ABCOpcodeKind = new ABCOpcodeKind(0x5b, "findpropglobalstrict");
		public static const FINDPROPSTRICT:ABCOpcodeKind = new ABCOpcodeKind(0x5d, "findpropstrict");
		public static const GETDESCENDANTS:ABCOpcodeKind = new ABCOpcodeKind(0x59, "getdescendants");
		public static const GETGLOBALSCOPE:ABCOpcodeKind = new ABCOpcodeKind(0x64, "getglobalscope");
		public static const GETGLOBALSLOT:ABCOpcodeKind = new ABCOpcodeKind(0x6E, "getglobalslot");
		public static const GETLEX:ABCOpcodeKind = new ABCOpcodeKind(0x60, "getlex");
		public static const GETLOCAL:ABCOpcodeKind = new ABCOpcodeKind(0x62, "getlocal");
		public static const GETLOCAL_0:ABCOpcodeKind = new ABCOpcodeKind(0xd0, "getlocal_0");
		public static const GETLOCAL_1:ABCOpcodeKind = new ABCOpcodeKind(0xd1, "getlocal_1");
		public static const GETLOCAL_2:ABCOpcodeKind = new ABCOpcodeKind(0xd2, "getlocal_2");
		public static const GETLOCAL_3:ABCOpcodeKind = new ABCOpcodeKind(0xd3, "getlocal_3");
		public static const GETOUTERSCOPE:ABCOpcodeKind = new ABCOpcodeKind(0x67, "getouterscope");
		public static const GETPROPERTY:ABCOpcodeKind = new ABCOpcodeKind(0x66, "getproperty");
		public static const GETSCOPEOBJECT:ABCOpcodeKind = new ABCOpcodeKind(0x65, "getscopeobject");
		public static const GETSLOT:ABCOpcodeKind = new ABCOpcodeKind(0x6c, "getslot");
		public static const GETSUPER:ABCOpcodeKind = new ABCOpcodeKind(0x04, "getsuper");
		public static const GREATEREQUALS:ABCOpcodeKind = new ABCOpcodeKind(0xb0, "greaterequals");
		public static const GREATERTHAN:ABCOpcodeKind = new ABCOpcodeKind(0xaf, "greaterthan");
		public static const HASNEXT2:ABCOpcodeKind = new ABCOpcodeKind(0x32, "hasnext2");
		public static const HASNEXT:ABCOpcodeKind = new ABCOpcodeKind(0x1F, "hasnext");
		public static const IFEQ:ABCOpcodeKind = new ABCOpcodeKind(0x13, "ifeq");
		public static const IFFALSE:ABCOpcodeKind = new ABCOpcodeKind(0x12, "iffalse");
		public static const IFGE:ABCOpcodeKind = new ABCOpcodeKind(0x18, "ifge");
		public static const IFGT:ABCOpcodeKind = new ABCOpcodeKind(0x17, "ifgt");
		public static const IFLE:ABCOpcodeKind = new ABCOpcodeKind(0x16, "ifle");
		public static const IFLT:ABCOpcodeKind = new ABCOpcodeKind(0x15, "iflt");
		public static const IFNE:ABCOpcodeKind = new ABCOpcodeKind(0x14, "ifne");
		public static const IFNGE:ABCOpcodeKind = new ABCOpcodeKind(0x0f, "ifnge");
		public static const IFNGT:ABCOpcodeKind = new ABCOpcodeKind(0x0e, "ifngt");
		public static const IFNLE:ABCOpcodeKind = new ABCOpcodeKind(0x0d, "ifnle");
		public static const IFNLT:ABCOpcodeKind = new ABCOpcodeKind(0x0c, "ifnlt");
		public static const IFSTRICTEQ:ABCOpcodeKind = new ABCOpcodeKind(0x19, "ifstricteq");
		public static const IFSTRICTNE:ABCOpcodeKind = new ABCOpcodeKind(0x1a, "ifstrictne");
		public static const IFTRUE:ABCOpcodeKind = new ABCOpcodeKind(0x11, "iftrue");
		public static const IN_OP:ABCOpcodeKind = new ABCOpcodeKind(0xb4, "in");
		public static const INCLOCAL:ABCOpcodeKind = new ABCOpcodeKind(0x92, "inclocal");
		public static const INCLOCAL_I:ABCOpcodeKind = new ABCOpcodeKind(0xc2, "inclocal_i");
		public static const INCREMENT:ABCOpcodeKind = new ABCOpcodeKind(0x91, "increment");
		public static const INCREMENT_I:ABCOpcodeKind = new ABCOpcodeKind(0xc0, "increment_i");
		public static const INITPROPERTY:ABCOpcodeKind = new ABCOpcodeKind(0x68, "initproperty");
		public static const INSTANCE_OF:ABCOpcodeKind = new ABCOpcodeKind(0xB1, "instance_of");
		public static const ISTYPE:ABCOpcodeKind = new ABCOpcodeKind(0xB2, "istype");
		public static const ISTYPELATE:ABCOpcodeKind = new ABCOpcodeKind(0xb3, "istypelate");
		public static const JUMP:ABCOpcodeKind = new ABCOpcodeKind(0x10, "jump");
		public static const KILL:ABCOpcodeKind = new ABCOpcodeKind(0x08, "kill");
		public static const LABEL:ABCOpcodeKind = new ABCOpcodeKind(0x09, "label");
		public static const LESSEQUALS:ABCOpcodeKind = new ABCOpcodeKind(0xae, "lessequals");
		public static const LESSTHAN:ABCOpcodeKind = new ABCOpcodeKind(0xad, "lessthan");
		public static const LOOKUPSWITCH:ABCOpcodeKind = new ABCOpcodeKind(0x1b, "lookupswitch");
		public static const LSHIFT:ABCOpcodeKind = new ABCOpcodeKind(0xa5, "lshift");
		public static const MODULO:ABCOpcodeKind = new ABCOpcodeKind(0xa4, "modulo");
		public static const MULTIPLY:ABCOpcodeKind = new ABCOpcodeKind(0xa2, "multiply");
		public static const MULTIPLY_I:ABCOpcodeKind = new ABCOpcodeKind(0xC7, "multiply_i");
		public static const NEGATE:ABCOpcodeKind = new ABCOpcodeKind(0x90, "negate");
		public static const NEGATE_I:ABCOpcodeKind = new ABCOpcodeKind(0xC4, "negate_i");
		public static const NEWACTIVATION:ABCOpcodeKind = new ABCOpcodeKind(0x57, "newactivation");
		public static const NEWARRAY:ABCOpcodeKind = new ABCOpcodeKind(0x56, "newarray");
		public static const NEWCATCH:ABCOpcodeKind = new ABCOpcodeKind(0x5a, "newcatch");
		public static const NEWCLASS:ABCOpcodeKind = new ABCOpcodeKind(0x58, "newclass");
		public static const NEWFUNCTION:ABCOpcodeKind = new ABCOpcodeKind(0x40, "newfunction");
		public static const NEWOBJECT:ABCOpcodeKind = new ABCOpcodeKind(0x55, "newobject");
		public static const NEXTNAME:ABCOpcodeKind = new ABCOpcodeKind(0x1e, "nextname");
		public static const NEXTVALUE:ABCOpcodeKind = new ABCOpcodeKind(0x23, "nextvalue");
		public static const NOP:ABCOpcodeKind = new ABCOpcodeKind(0x02, "nop");
		public static const NOT:ABCOpcodeKind = new ABCOpcodeKind(0x96, "not");
		public static const POP:ABCOpcodeKind = new ABCOpcodeKind(0x29, "pop");
		public static const POPSCOPE:ABCOpcodeKind = new ABCOpcodeKind(0x1d, "popscope");
		public static const PUSHBYTE:ABCOpcodeKind = new ABCOpcodeKind(0x24, "pushbyte");
		public static const PUSHCONSTANT:ABCOpcodeKind = new ABCOpcodeKind(0x22, "pushconstant");
		public static const PUSHDECIMAL:ABCOpcodeKind = new ABCOpcodeKind(0x33, "pushdecimal");
		public static const PUSHDNAN:ABCOpcodeKind = new ABCOpcodeKind(0x34, "pushdnan");
		public static const PUSHDOUBLE:ABCOpcodeKind = new ABCOpcodeKind(0x2f, "pushdouble");
		public static const PUSHFALSE:ABCOpcodeKind = new ABCOpcodeKind(0x27, "pushfalse");
		public static const PUSHINT:ABCOpcodeKind = new ABCOpcodeKind(0x2d, "pushint");
		public static const PUSHNAMESPACE:ABCOpcodeKind = new ABCOpcodeKind(0x31, "pushnamespace");
		public static const PUSHNAN:ABCOpcodeKind = new ABCOpcodeKind(0x28, "pushnan");
		public static const PUSHNULL:ABCOpcodeKind = new ABCOpcodeKind(0x20, "pushnull");
		public static const PUSHSCOPE:ABCOpcodeKind = new ABCOpcodeKind(0x30, "pushscope");
		public static const PUSHSHORT:ABCOpcodeKind = new ABCOpcodeKind(0x25, "pushshort");
		public static const PUSHSTRING:ABCOpcodeKind = new ABCOpcodeKind(0x2c, "pushstring");
		public static const PUSHTRUE:ABCOpcodeKind = new ABCOpcodeKind(0x26, "pushtrue");
		public static const PUSHUINT:ABCOpcodeKind = new ABCOpcodeKind(0x2E, "pushuint");
		public static const PUSHUNDEFINED:ABCOpcodeKind = new ABCOpcodeKind(0x21, "pushundefined");
		public static const PUSHWITH:ABCOpcodeKind = new ABCOpcodeKind(0x1c, "pushwith");
		public static const RETURNVALUE:ABCOpcodeKind = new ABCOpcodeKind(0x48, "returnvalue");
		public static const RETURNVOID:ABCOpcodeKind = new ABCOpcodeKind(0x47, "returnvoid");
		public static const RSHIFT:ABCOpcodeKind = new ABCOpcodeKind(0xa6, "rshift");
		public static const SETGLOBALSLOT:ABCOpcodeKind = new ABCOpcodeKind(0x6F, "setglobalslot");
		public static const SETLOCAL:ABCOpcodeKind = new ABCOpcodeKind(0x63, "setlocal");
		public static const SETLOCAL_0:ABCOpcodeKind = new ABCOpcodeKind(0xD4, "setlocal_0");
		public static const SETLOCAL_1:ABCOpcodeKind = new ABCOpcodeKind(0xD5, "setlocal_1");
		public static const SETLOCAL_2:ABCOpcodeKind = new ABCOpcodeKind(0xD6, "setlocal_2");
		public static const SETLOCAL_3:ABCOpcodeKind = new ABCOpcodeKind(0xD7, "setlocal_3");
		public static const SETPROPERTY:ABCOpcodeKind = new ABCOpcodeKind(0x61, "setproperty");
		public static const SETPROPERTYLATE:ABCOpcodeKind = new ABCOpcodeKind(0x69, "setpropertylate");
		public static const SETSLOT:ABCOpcodeKind = new ABCOpcodeKind(0x6d, "setslot");
		public static const SETSUPER:ABCOpcodeKind = new ABCOpcodeKind(0x05, "setsuper");
		public static const STRICTEQUALS:ABCOpcodeKind = new ABCOpcodeKind(0xac, "strictequals");
		public static const SUBTRACT:ABCOpcodeKind = new ABCOpcodeKind(0xa1, "subtract");
		public static const SUBTRACT_I:ABCOpcodeKind = new ABCOpcodeKind(0xC6, "subtract_i");
		public static const SWAP:ABCOpcodeKind = new ABCOpcodeKind(0x2b, "swap");
		public static const THROW_OP:ABCOpcodeKind = new ABCOpcodeKind(0x03, "throw");
		public static const TYPEOF_OP:ABCOpcodeKind = new ABCOpcodeKind(0x95, "typeof");
		public static const URSHIFT:ABCOpcodeKind = new ABCOpcodeKind(0xa7, "urshift");
		
		private var _type:uint;
		private var _name:String;
		
		public function ABCOpcodeKind(type:uint, name:String) {
			_type = type;
			_name = name;
			_types[_type] = this;
		}

		public static function getType(type:uint):ABCOpcodeKind {
			 return _types[type];
		}
		
		public static function isType(type:ABCOpcodeKind, kind:ABCOpcodeKind):Boolean {
			return type.type == kind.type;
		}
		
		public static function isDebug(kind:ABCOpcodeKind):Boolean {
			var result:Boolean;
			switch(kind) {
				case DEBUG:
				case DEBUGFILE:
				case DEBUGLINE:
					result = true;
					break;
					
				default:
					result = false;
					break;
			}
			return result;
		}
		
		public static function isIfType(kind:ABCOpcodeKind):Boolean {
			var result:Boolean;
			switch(kind) {
				case IFEQ:
				case IFFALSE:
				case IFGE:
				case IFGT:
				case IFLE:
				case IFLT:
				case IFNE:
				case IFNGE:
				case IFNGT:
				case IFNLE:
				case IFNLT:
				case IFSTRICTEQ:
				case IFSTRICTNE:
				case IFTRUE:
					result = true;
					break;
					
				default:
					result = false;
					break;
			}
			return result;
		}
		
		public static function isComparisonType(kind:ABCOpcodeKind):Boolean {
			var result:Boolean;
			switch(kind) {
				case EQUALS:
				case GREATEREQUALS:
				case GREATERTHAN:
				case LESSEQUALS:
				case LESSTHAN:
				case STRICTEQUALS:
					result = true;
					break;
					
				default:
					result = false;
					break;
			}
			return result;
		}
				
		public function get type():uint { return _type; }
		public function get name():String { return "ABCOpcodeKind"; }
		
		public function toString(indent:uint = 0):String {
			return ABC.toStringCommon(name, indent) + 
				"Type: " + type.toString(16) + ", " + 
				"Name: " + _name;
		}
	}
}
