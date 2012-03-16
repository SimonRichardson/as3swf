package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.utils.getClassFromInstance;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcode extends ABCSet {

		public var kind:ABCOpcodeKind;
		public var attribute:ABCOpcodeAttribute;

		public function ABCOpcode(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData, kind:ABCOpcodeKind, attribute:ABCOpcodeAttribute):ABCOpcode {
			const opcode:ABCOpcode = new ABCOpcode(abcData);
			opcode.kind = kind;
			opcode.attribute = attribute;
			return opcode;
		}
		
		public function read(data:SWFData):void {
			attribute.read(data);
		}
		
		public function write(bytes:SWFData):void {
			attribute.write(bytes);
		}
		
		override public function get name():String { return "ABCOpcode"; }
		
		override public function toString(indent:uint=0) : String {
			var str:String = ABC.toStringCommon(name, indent);
			
			if(kind) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Kind:";
				str += "\n" + kind.toString(indent + 4);
			}
			
			if(attribute && getClassFromInstance(attribute) != ABCOpcodeAttribute) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Attribute:";
				str += "\n" + attribute.toString(indent + 4);
			}
			
			return str;
		}
	}
}
