package com.codeazur.as3swf.data.abc.bytecode.traits
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.ABCConstantKind;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.io.ABCScanner;
	import com.codeazur.utils.StringUtils;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCTraitSlotInfo extends ABCTraitInfo {

		public var id:uint;
		public var isStatic:Boolean;
		public var typeMultiname:IABCMultiname;
		
		public var valueIndex:uint;
		public var valueKind:ABCConstantKind;

		public var defaultValue : *;

		public function ABCTraitSlotInfo(abcData : ABCData) {
			super(abcData);
		}
		
		public static function create(data:ABCData, qname:IABCMultiname, kind:uint, kindType:ABCTraitInfoKind, isStatic:Boolean = false):ABCTraitSlotInfo {
			const slot:ABCTraitSlotInfo = new ABCTraitSlotInfo(data);
			slot.multiname = qname;
			slot.kind = kind;
			slot.kindType = kindType;
			slot.isStatic = isStatic;
			return slot;
		}
		
		override public function read(data : SWFData, scanner:ABCScanner) : void {
			id = data.readEncodedU30();
			
			const typeIndex:uint = data.readEncodedU30();
			typeMultiname = getMultinameByIndex(typeIndex);
			
			valueIndex = data.readEncodedU30();
			if(valueIndex > 0) {
				const kind:uint = data.readUI8();
				valueKind = ABCConstantKind.getType(kind);
				defaultValue = getConstantPoolItemByKindAtIndex(valueKind, valueIndex);
			}
			
			super.read(data, scanner);
		}
		
		override public function write(bytes : SWFData) : void {			
			bytes.writeEncodedU32(id);
			bytes.writeEncodedU32(getMultinameIndex(typeMultiname));
			bytes.writeEncodedU32(valueIndex);
			
			if(valueKind) {
				bytes.writeUI8(valueKind.type);
			}
			
			super.write(bytes);
		}
			
		override public function set abcData(value : ABCData) : void {
			super.abcData = value;
			
			if(valueKind) {
				valueIndex = getConstantPoolIndexByKindWithValue(valueKind, defaultValue);
			}
		}
		
		public function get hasDefaultValue():Boolean { return valueIndex > 0; }
		
		override public function get name():String { return "ABCTraitSlotInfo"; }
		
		override public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "ID: " + id;
			
			if(typeMultiname) {
				str += "\n" + StringUtils.repeat(indent + 2) + "TypeMultiname: ";
				str += "\n" + typeMultiname.toString(indent + 4);
			}
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Static: " + isStatic;
			
			if(valueIndex > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "DefaultValue: ";
				str += "\n" + StringUtils.repeat(indent + 4) + defaultValue;
			}
			
			return str;
		}
	}
}
