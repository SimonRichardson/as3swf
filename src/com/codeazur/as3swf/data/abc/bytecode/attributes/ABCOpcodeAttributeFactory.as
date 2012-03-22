package com.codeazur.as3swf.data.abc.bytecode.attributes
{

	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeAttributeFactory {
		
		public static function create(abcData:ABCData, kind:ABCOpcodeKind):ABCOpcodeAttribute {
			var attribute:ABCOpcodeAttribute;
			switch(kind) {
				case ABCOpcodeKind.DEBUG:
					attribute = ABCOpcodeDebugAttribute.create(abcData);
					break;
				
				case ABCOpcodeKind.PUSHDECIMAL:
				case ABCOpcodeKind.PUSHDOUBLE:
					attribute = ABCOpcodeDoubleAttribute.create(abcData);
					break;
				
				case ABCOpcodeKind.ADD_P:
				case ABCOpcodeKind.DIVIDE_P:
				case ABCOpcodeKind.MODULO_P:
				case ABCOpcodeKind.MULTIPLY_P:
				case ABCOpcodeKind.SUBTRACT_P:
					attribute = ABCOpcodeParameterAttribute.create(abcData);
					break;
				
				case ABCOpcodeKind.APPLYTYPE:
				case ABCOpcodeKind.CALL:
				case ABCOpcodeKind.CONSTRUCT:
				case ABCOpcodeKind.CONSTRUCTSUPER:
				case ABCOpcodeKind.DEBUGLINE:
				case ABCOpcodeKind.DECLOCAL:
				case ABCOpcodeKind.DECLOCAL_I:
				case ABCOpcodeKind.GETGLOBALSLOT:
				case ABCOpcodeKind.GETLOCAL:
				case ABCOpcodeKind.GETOUTERSCOPE:
				case ABCOpcodeKind.GETSCOPEOBJECT:
				case ABCOpcodeKind.GETSLOT:
				case ABCOpcodeKind.INCLOCAL:
				case ABCOpcodeKind.INCLOCAL_I:
				case ABCOpcodeKind.KILL:
				case ABCOpcodeKind.NEWARRAY:
				case ABCOpcodeKind.NEWCLASS:
				case ABCOpcodeKind.NEWFUNCTION:
				case ABCOpcodeKind.NEWOBJECT:
				case ABCOpcodeKind.SETGLOBALSLOT:
				case ABCOpcodeKind.SETLOCAL:
				case ABCOpcodeKind.SETSLOT:
					attribute = ABCOpcodeIntAttribute.create(abcData);
					break;
				
				case ABCOpcodeKind.BKPTLINE:
				case ABCOpcodeKind.PUSHINT:
					attribute = ABCOpcodeIntegerAttribute.create(abcData);
					break;
				
				case ABCOpcodeKind.HASNEXT2:
					attribute = ABCOpcodeHasNext2Attribute.create(abcData);
					break;
				
				case ABCOpcodeKind.PUSHSHORT:
					attribute = ABCOpcodeShortAttribute.create(abcData);
					break;
					
				case ABCOpcodeKind.LOOKUPSWITCH:
					attribute = ABCOpcodeLookupSwitchAttribute.create(abcData);
					break;
				
				case ABCOpcodeKind.IFEQ:
				case ABCOpcodeKind.IFFALSE:
				case ABCOpcodeKind.IFGE:
				case ABCOpcodeKind.IFGT:
				case ABCOpcodeKind.IFLE:
				case ABCOpcodeKind.IFLT:
				case ABCOpcodeKind.IFNE:
				case ABCOpcodeKind.IFNGE:
				case ABCOpcodeKind.IFNGT:
				case ABCOpcodeKind.IFNLE:
				case ABCOpcodeKind.IFNLT:
				case ABCOpcodeKind.IFSTRICTEQ:
				case ABCOpcodeKind.IFSTRICTNE:
				case ABCOpcodeKind.IFTRUE:
				case ABCOpcodeKind.JUMP:
					attribute = ABCOpcodeInt24Attribute.create(abcData);
					break;
				
				case ABCOpcodeKind.ASTYPE:
				case ABCOpcodeKind.COERCE:
				case ABCOpcodeKind.DELETEPROPERTY:
				case ABCOpcodeKind.FINDDEF:
				case ABCOpcodeKind.FINDPROPERTY:
				case ABCOpcodeKind.FINDPROPGLOBAL:
				case ABCOpcodeKind.FINDPROPGLOBALSTRICT:
				case ABCOpcodeKind.FINDPROPSTRICT:
				case ABCOpcodeKind.GETDESCENDANTS:
				case ABCOpcodeKind.GETLEX:
				case ABCOpcodeKind.GETPROPERTY:
				case ABCOpcodeKind.GETSUPER:
				case ABCOpcodeKind.INITPROPERTY:
				case ABCOpcodeKind.ISTYPE:
				case ABCOpcodeKind.SETPROPERTY:
				case ABCOpcodeKind.SETSUPER:
					attribute = ABCOpcodeMultinameAttribute.create(abcData);
					break;
				
				case ABCOpcodeKind.CALLINTERFACE:
				case ABCOpcodeKind.CALLPROPERTY:
				case ABCOpcodeKind.CALLPROPLEX:
				case ABCOpcodeKind.CALLPROPVOID:
				case ABCOpcodeKind.CALLSUPER:
				case ABCOpcodeKind.CALLSUPERVOID:
				case ABCOpcodeKind.CONSTRUCTPROP:
					attribute = ABCOpcodeMultinameUIntAttribute.create(abcData);
					break;
					
				case ABCOpcodeKind.DEBUGFILE:
				case ABCOpcodeKind.DXNS:
				case ABCOpcodeKind.PUSHCONSTANT:
				case ABCOpcodeKind.PUSHSTRING:
					attribute = ABCOpcodeStringAttribute.create(abcData);
					break;
				
				case ABCOpcodeKind.PUSHBYTE:
					attribute = ABCOpcodeUnsignedByteAttribute.create(abcData);
					break;
				
				case ABCOpcodeKind.PUSHUINT:
					attribute = ABCOpcodeUnsignedIntegerAttribute.create(abcData);
					break;
				
				case ABCOpcodeKind.ADD:
				case ABCOpcodeKind.ADD_D:
				case ABCOpcodeKind.ADD_I:
				case ABCOpcodeKind.ASTYPELATE:
				case ABCOpcodeKind.BITAND:
				case ABCOpcodeKind.BITNOT:
				case ABCOpcodeKind.BITOR:
				case ABCOpcodeKind.BITXOR:
				case ABCOpcodeKind.COERCE:
				case ABCOpcodeKind.COERCE_A:
				case ABCOpcodeKind.COERCE_B:
				case ABCOpcodeKind.COERCE_D:
				case ABCOpcodeKind.COERCE_I:
				case ABCOpcodeKind.COERCE_O:
				case ABCOpcodeKind.COERCE_S:
				case ABCOpcodeKind.COERCE_U:
				case ABCOpcodeKind.CONVERT_B:
				case ABCOpcodeKind.CONVERT_D:
				case ABCOpcodeKind.CONVERT_I:
				case ABCOpcodeKind.CONVERT_O:
				case ABCOpcodeKind.CONVERT_S:
				case ABCOpcodeKind.CONVERT_U:
				case ABCOpcodeKind.DECREMENT:
				case ABCOpcodeKind.DECREMENT_I:
				case ABCOpcodeKind.DIVIDE:
				case ABCOpcodeKind.DUP:	
				case ABCOpcodeKind.EQUALS:	
				case ABCOpcodeKind.GETGLOBALSCOPE:
				case ABCOpcodeKind.GETLOCAL_0:
				case ABCOpcodeKind.GETLOCAL_1:
				case ABCOpcodeKind.GETLOCAL_2:
				case ABCOpcodeKind.GETLOCAL_3:
				case ABCOpcodeKind.GREATEREQUALS:
				case ABCOpcodeKind.GREATERTHAN:
				case ABCOpcodeKind.IN_OP:
				case ABCOpcodeKind.INCREMENT:
				case ABCOpcodeKind.INCREMENT_I:
				case ABCOpcodeKind.ISTYPELATE:
				case ABCOpcodeKind.LABEL:
				case ABCOpcodeKind.LSHIFT:
				case ABCOpcodeKind.LESSEQUALS:
				case ABCOpcodeKind.LESSTHAN:
				case ABCOpcodeKind.MODULO:
				case ABCOpcodeKind.MULTIPLY:
				case ABCOpcodeKind.MULTIPLY_I:
				case ABCOpcodeKind.NEGATE:
				case ABCOpcodeKind.NEGATE_I:
				case ABCOpcodeKind.NEXTVALUE:
				case ABCOpcodeKind.NEWACTIVATION:
				case ABCOpcodeKind.NOP:
				case ABCOpcodeKind.NOT:
				case ABCOpcodeKind.POP:
				case ABCOpcodeKind.POPSCOPE:
				case ABCOpcodeKind.PUSHDNAN:
				case ABCOpcodeKind.PUSHFALSE:
				case ABCOpcodeKind.PUSHNAN:
				case ABCOpcodeKind.PUSHNULL:
				case ABCOpcodeKind.PUSHSCOPE:
				case ABCOpcodeKind.PUSHTRUE:
				case ABCOpcodeKind.RETURNVALUE:
				case ABCOpcodeKind.RETURNVOID:
				case ABCOpcodeKind.RSHIFT:
				case ABCOpcodeKind.SETLOCAL_0:
				case ABCOpcodeKind.SETLOCAL_1:
				case ABCOpcodeKind.SETLOCAL_2:
				case ABCOpcodeKind.SETLOCAL_3:
				case ABCOpcodeKind.STRICTEQUALS:
				case ABCOpcodeKind.SUBTRACT:
				case ABCOpcodeKind.SUBTRACT_I:
				case ABCOpcodeKind.THROW_OP:
					attribute = ABCOpcodeAttribute.create(abcData);
					break;
				
				default:
					throw new Error('Invalid opcode kind (recieved=' + kind + ')');
					break;
			}
			
			return attribute;
		}
	}
}
