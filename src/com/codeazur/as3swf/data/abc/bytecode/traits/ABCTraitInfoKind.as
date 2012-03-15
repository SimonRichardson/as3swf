package com.codeazur.as3swf.data.abc.bytecode.traits
{
	import com.codeazur.as3swf.data.abc.ABC;

	import flash.utils.Dictionary;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCTraitInfoKind {
		
		private static const _types:Dictionary = new Dictionary();
		
		public static const SLOT:ABCTraitInfoKind = new ABCTraitInfoKind(0, SLOT_NAME);
		public static const METHOD:ABCTraitInfoKind = new ABCTraitInfoKind(1, METHOD_NAME);
		public static const GETTER:ABCTraitInfoKind = new ABCTraitInfoKind(2, GETTER_NAME);
		public static const SETTER:ABCTraitInfoKind = new ABCTraitInfoKind(3, SETTER_NAME);
		public static const CLASS:ABCTraitInfoKind = new ABCTraitInfoKind(4, CLASS_NAME);
		public static const FUNCTION:ABCTraitInfoKind = new ABCTraitInfoKind(5, FUNCTION_NAME);
		public static const CONST:ABCTraitInfoKind = new ABCTraitInfoKind(6, CONST_NAME);
		
		private static const SLOT_NAME:String = "Slot";
		private static const METHOD_NAME:String = "Method";
		private static const GETTER_NAME:String = "Getter";
		private static const SETTER_NAME:String = "Setter";
		private static const CLASS_NAME:String = "Class";
		private static const FUNCTION_NAME:String = "Function";
		private static const CONST_NAME:String = "Const";
		
		private var _type:uint;
		private var _name:String;
		
		public function ABCTraitInfoKind(type:uint, name:String) {
			_type = type;
			_name = name;
			_types[_type] = this;
		}

		public static function getType(type:uint):ABCTraitInfoKind {
			return _types[(type & 0xF)];
		}
		
		public static function isType(type:uint, kind:ABCTraitInfoKind):Boolean {
			return (type & 0xF) == kind.type;
		}
		
		public function get type():uint { return _type; }
		public function get name():String { return "ABCTraitInfoKind"; }
		
		public function toString(indent:uint = 0):String {
			return ABC.toStringCommon(name, indent) + 
				"Type: " + type + ", " + 
				"Name: " + _name;
		}
	}
}
