package com.codeazur.as3swf.data.abc.bytecode.traits
{
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCTraitConstInfo extends ABCTraitSlotInfo {

		public function ABCTraitConstInfo(abcData : ABCData) {
			super(abcData);
		}
		
		public static function create(data:ABCData, qname:IABCMultiname, kind:uint, kindType:ABCTraitInfoKind, isStatic:Boolean = false):ABCTraitConstInfo {
			const slot:ABCTraitConstInfo = new ABCTraitConstInfo(data);
			slot.multiname = qname;
			slot.kind = kind;
			slot.kindType = kindType;
			slot.isStatic = isStatic;
			return slot;
		}

		override public function get name():String { return "ABCTraitConstInfo"; }
		
		override public function toString(indent : uint = 0) : String {
			return super.toString(indent);
		}
	}
}
