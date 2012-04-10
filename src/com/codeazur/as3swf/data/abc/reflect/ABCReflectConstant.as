package com.codeazur.as3swf.data.abc.reflect
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitConstInfo;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectConstant implements IABCReflectObject {
		
		private var _constInfo:ABCTraitConstInfo;		
		
		public function ABCReflectConstant(constInfo:ABCTraitConstInfo) {
			_constInfo = constInfo;
		}
		
		public static function create(constInfo:ABCTraitConstInfo):ABCReflectConstant {
			return new ABCReflectConstant(constInfo);
		}
		
		public function get multiname():IABCMultiname { return _constInfo.multiname; }
		
		public function get isFinal():Boolean { return _constInfo.isFinal; }
		public function get isStatic():Boolean { return _constInfo.isStatic; }
		public function get typeMultiname():IABCMultiname { return _constInfo.typeMultiname; }
		public function get hasDefaultValue():Boolean { return _constInfo.hasDefaultValue; }
		public function get defaultValue():* { return _constInfo.defaultValue; }
		
		public function get name():String { return "ABCReflectConstant"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Multiname:";
			str += "\n" + StringUtils.repeat(indent + 4) + multiname.fullPath;
			
			return str;
		}
	}
}
