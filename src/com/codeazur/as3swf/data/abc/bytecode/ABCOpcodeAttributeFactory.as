package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeUnsignedByteAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeInt24Attribute;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeDebugAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeDoubleAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeIntAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeIntegerAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeLookupSwitchAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeMultinameAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeMultinameUIntAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeStringAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeUnsignedIntegerAttribute;
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
				
				default:
					attribute = ABCOpcodeAttribute.create(abcData);
					break;
			}
			
			return attribute;
		}
	}
}
