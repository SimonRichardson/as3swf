package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.ABCData;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCTraitConstInfo extends ABCTraitSlotInfo {

		public function ABCTraitConstInfo(abcData : ABCData) {
			super(abcData);
		}
		
		public static function create(data:ABCData, qname:IABCMultiname, kind:ABCTraitInfoKind, isStatic:Boolean = false):ABCTraitConstInfo {
			const slot:ABCTraitConstInfo = new ABCTraitConstInfo(data);
			slot.qname = qname;
			slot.kind = kind;
			slot.isStatic = isStatic;
			return slot;
		}

		override public function get name():String { return "ABCTraitConstInfo"; }
		
		override public function toString(indent : uint = 0) : String {
			return super.toString(indent);
		}
	}
}
