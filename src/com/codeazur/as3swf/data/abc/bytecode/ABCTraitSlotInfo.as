package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
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
			slot.qname = qname;
			slot.kind = kind;
			slot.kindType = kindType;
			slot.isStatic = isStatic;
			return slot;
		}
		
		override public function parse(data : SWFData, scanner:ABCScanner) : void {
			id = data.readEncodedU30();
			
			const typeIndex:uint = data.readEncodedU30();
			typeMultiname = getMultinameByIndex(typeIndex);
			
			valueIndex = data.readEncodedU30();
			if(valueIndex > 0) {
				const kind:uint = data.readUI8();
				valueKind = ABCConstantKind.getType(kind);
				defaultValue = getConstantPoolItemByKindAtIndex(valueKind, valueIndex);
			}
			
			super.parse(data, scanner);
		}
		
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
