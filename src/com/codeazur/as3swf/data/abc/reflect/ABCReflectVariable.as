package com.codeazur.as3swf.data.abc.reflect
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitSlotInfo;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectVariable implements IABCReflectObject {
		
		private var _slotInfo:ABCTraitSlotInfo;		
		
		public function ABCReflectVariable(slotInfo:ABCTraitSlotInfo) {
			_slotInfo = slotInfo;
		}
		
		public static function create(slotInfo:ABCTraitSlotInfo):ABCReflectVariable {
			return new ABCReflectVariable(slotInfo);
		}
		
		public function get multiname():IABCMultiname { return _slotInfo.multiname; }
		
		public function get isFinal():Boolean { return _slotInfo.isFinal; }
		public function get isStatic():Boolean { return _slotInfo.isStatic; }
		public function get typeMultiname():IABCMultiname { return _slotInfo.typeMultiname; }
		public function get hasDefaultValue():Boolean { return _slotInfo.hasDefaultValue; }
		public function get defaultValue():* { return _slotInfo.defaultValue; }
		
		public function get name():String { return "ABCReflectVariable"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Multiname:";
			str += "\n" + StringUtils.repeat(indent + 4) + multiname.fullPath;
			
			return str;
		}
	}
}
