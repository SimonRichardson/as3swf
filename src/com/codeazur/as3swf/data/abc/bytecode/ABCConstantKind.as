package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.ABC;

	import flash.utils.Dictionary;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCConstantKind {
		
		private static const _types:Dictionary = new Dictionary();
		
		public static const UNKNOWN:ABCConstantKind = new ABCConstantKind(0x0, UNKNOWN_NAME);
		public static const INT:ABCConstantKind = new ABCConstantKind(0x03, INT_NAME);
		public static const UINT:ABCConstantKind = new ABCConstantKind(0x04, UINT_NAME);
		public static const DOUBLE:ABCConstantKind = new ABCConstantKind(0x06, DOUBLE_NAME);
		public static const UTF8:ABCConstantKind = new ABCConstantKind(0x01, UTF8_NAME);
		public static const TRUE:ABCConstantKind = new ABCConstantKind(0x0B, TRUE_NAME);
		public static const FALSE:ABCConstantKind = new ABCConstantKind(0x0A, FALSE_NAME);
		public static const NULL:ABCConstantKind = new ABCConstantKind(0x0C, NULL_NAME);
		public static const UNDEFINED:ABCConstantKind = new ABCConstantKind(0x00, UNDEFINED_NAME);
		public static const NAMESPACE:ABCConstantKind = new ABCConstantKind(0x08, NAMESPACE_NAME);
		public static const PACKAGE_NAMESPACE:ABCConstantKind = new ABCConstantKind(0x16, PACKAGE_NAMESPACE_NAME);
		public static const PACKAGE_INTERNAL_NAMESPACE:ABCConstantKind = new ABCConstantKind(0x17, PACKAGE_INTERNAL_NAMESPACE_NAME);
		public static const PROTECTED_NAMESPACE:ABCConstantKind = new ABCConstantKind(0x18, PROTECTED_NAMESPACE_NAME);
		public static const EXPLICIT_NAMESPACE:ABCConstantKind = new ABCConstantKind(0x19, EXPLICIT_NAMESPACE_NAME);
		public static const STATIC_PROTECTED_NAMESPACE:ABCConstantKind = new ABCConstantKind(0x1A, STATIC_PROTECTED_NAMESPACE_NAME);
		public static const PRIVATE_NAMESPACE:ABCConstantKind = new ABCConstantKind(0x05, PRIVATE_NAMESPACE_NAME);
		
		private static const UNKNOWN_NAME:String = "UNKNOWN";
		private static const INT_NAME:String = "int";
		private static const UINT_NAME:String = "uint";
		private static const DOUBLE_NAME:String = "double";
		private static const UTF8_NAME:String = "utf8";
		private static const TRUE_NAME:String = "true";
		private static const FALSE_NAME:String = "false";
		private static const NULL_NAME:String = "null";
		private static const UNDEFINED_NAME:String = "undefined";
		private static const NAMESPACE_NAME:String = "Namespace";
		private static const PACKAGE_NAMESPACE_NAME:String = "Package Namespace";
		private static const PACKAGE_INTERNAL_NAMESPACE_NAME:String = "Package Internal Namespace";
		private static const PROTECTED_NAMESPACE_NAME:String = "Protected Namespace";
		private static const EXPLICIT_NAMESPACE_NAME:String = "Explicit Namespace";
		private static const STATIC_PROTECTED_NAMESPACE_NAME:String = "Static Protected Namespace";
		private static const PRIVATE_NAMESPACE_NAME:String = "Private Namespace";
		
		private var _type:uint;
		private var _name:String;
		
		public function ABCConstantKind(type:uint, name:String) {
			_type = type;
			_name = name;
			_types[_type] = this;
		}

		public static function getType(type:uint):ABCConstantKind {
			 return _types[type];
		}
		
		public function get type():uint { return _type; }
		public function get name():String { return "ABCConstantKind"; }
		
		public function toString(indent:uint = 0):String {
			return ABC.toStringCommon(name, indent) + 
				"Type: " + type + ", " + 
				"Name: " + _name;
		}
	}
}
