package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.data.abc.ABC;

	import flash.utils.Dictionary;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCMultinameKind {
		
		private static const _types:Dictionary = new Dictionary();
		
		public static const QNAME:ABCMultinameKind = new ABCMultinameKind(0x07, QNAME_NAME);
		public static const QNAME_A:ABCMultinameKind = new ABCMultinameKind(0x0D, QNAME_A_NAME);
		public static const RUNTIME_QNAME:ABCMultinameKind = new ABCMultinameKind(0x0F, RUNTIME_QNAME_NAME);
		public static const RUNTIME_QNAME_A:ABCMultinameKind = new ABCMultinameKind(0x10, RUNTIME_QNAME_A_NAME);
		public static const RUNTIME_QNAME_LATE:ABCMultinameKind = new ABCMultinameKind(0x11, RUNTIME_QNAME_LATE_NAME);
		public static const RUNTIME_QNAME_LATE_A:ABCMultinameKind = new ABCMultinameKind(0x12, RUNTIME_QNAME_LATE_A_NAME);
		public static const MULTINAME:ABCMultinameKind = new ABCMultinameKind(0x09, MULTINAME_NAME);
		public static const MULTINAME_A:ABCMultinameKind = new ABCMultinameKind(0x0E, MULTINAME_A_NAME);
		public static const MULTINAME_LATE:ABCMultinameKind = new ABCMultinameKind(0x1B, MULTINAME_LATE_NAME);
		public static const MULTINAME_LATE_A:ABCMultinameKind = new ABCMultinameKind(0x1C, MULTINAME_LATE_A_NAME);
		public static const GENERIC:ABCMultinameKind = new ABCMultinameKind(0x1D, GENERIC_NAME);
		
		private static const QNAME_NAME:String = "Qualified Name";
		private static const QNAME_A_NAME:String = "Qualified Name A";
		private static const RUNTIME_QNAME_NAME:String = "Runtime Qualified Name";
		private static const RUNTIME_QNAME_A_NAME:String = "Runtime Qualified Name A";
		private static const RUNTIME_QNAME_LATE_NAME:String = "Runtime Qualified Name Late";
		private static const RUNTIME_QNAME_LATE_A_NAME:String = "Runtime Qualified Name Late A";
		private static const MULTINAME_NAME:String = "Multiname";
		private static const MULTINAME_A_NAME:String = "Multiname A";
		private static const MULTINAME_LATE_NAME:String = "Multiname Late";
		private static const MULTINAME_LATE_A_NAME:String = "Multiname Late A";
		private static const GENERIC_NAME:String = "Generic";
		
		private var _type:uint;
		private var _name:String;
		
		public function ABCMultinameKind(type:uint, name:String) {
			_type = type;
			_name = name;
			_types[_type] = this;
		}

		public static function getType(type:uint):ABCMultinameKind {
			 return _types[type];
		}
		
		public function get type():uint { return _type; }
		public function get name():String { return "ABCMultinameKind"; }
		
		public function toString(indent:uint = 0) : String {
			return ABC.toStringCommon(name, indent) + 
				"Type: " + type + ", " + 
				"Name: " + _name;
		}
		
	}
}
