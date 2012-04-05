package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.utils.getExplicitNamespaceIndentifier;

	import flash.utils.Dictionary;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCNamespaceKind {

		private static const _types:Dictionary = new Dictionary();
		
		public static const UNKNOWN:ABCNamespaceKind = new ABCNamespaceKind(0x0, UNKNOWN_NAME);
		public static const NAMESPACE:ABCNamespaceKind = new ABCNamespaceKind(0x08, NAMESPACE_NAME);
		public static const PACKAGE_NAMESPACE:ABCNamespaceKind = new ABCNamespaceKind(0x16, PACKAGE_NAMESPACE_NAME);
		public static const PACKAGE_INTERNAL_NAMESPACE:ABCNamespaceKind = new ABCNamespaceKind(0x17, PACKAGE_INTERNAL_NAMESPACE_NAME);
		public static const PROTECTED_NAMESPACE:ABCNamespaceKind = new ABCNamespaceKind(0x18, PROTECTED_NAMESPACE_NAME);
		public static const EXPLICIT_NAMESPACE:ABCNamespaceKind = new ABCNamespaceKind(0x19, EXPLICIT_NAMESPACE_NAME);
		public static const STATIC_PROTECTED_NAMESPACE:ABCNamespaceKind = new ABCNamespaceKind(0x1A, STATIC_PROTECTED_NAMESPACE_NAME);
		public static const PRIVATE_NAMESPACE:ABCNamespaceKind = new ABCNamespaceKind(0x05, PRIVATE_NAMESPACE_NAME);

		private static const UNKNOWN_NAME:String = "UNKNOWN";
		private static const NAMESPACE_NAME:String = "Namespace";
		private static const PACKAGE_NAMESPACE_NAME:String = "Package Namespace";
		private static const PACKAGE_INTERNAL_NAMESPACE_NAME:String = "Package Internal Namespace";
		private static const PROTECTED_NAMESPACE_NAME:String = "Protected Namespace";
		private static const EXPLICIT_NAMESPACE_NAME:String = "Explicit Namespace";
		private static const STATIC_PROTECTED_NAMESPACE_NAME:String = "Static Protected Namespace";
		private static const PRIVATE_NAMESPACE_NAME:String = "Private Namespace";

		private var _type:uint;
		private var _name:String;
		
		public function ABCNamespaceKind(type:uint, name:String) {
			_type = type;
			_name = name;
			_types[_type] = this;
		}

		public static function getType(type:uint):ABCNamespaceKind {
			 return _types[type];
		}
		
		public static function isType(type:ABCNamespaceKind, kind:ABCNamespaceKind):Boolean {
			 return type.equals(kind);
		}
		
		public static function getName(kind:ABCNamespaceKind):String {
			var result:String;
			switch(kind) {
				case PACKAGE_NAMESPACE:
					result = "public";
					break;
				case PACKAGE_INTERNAL_NAMESPACE:
					result = "public";
					break;
				case PRIVATE_NAMESPACE:
					result = "private";
					break;
				case PROTECTED_NAMESPACE:
					result = "protected";
					break;
				case EXPLICIT_NAMESPACE:
					result = getExplicitNamespaceIndentifier();
					break;
				default:
					throw new Error("Unknown namespace kind (kind: " + kind + ")");
			}
			return result;
		}
		
		public function equals(kind:ABCNamespaceKind):Boolean {
			return kind && kind._type == _type && kind._name == _name;
		}
		
		public function get type():uint { return _type; }
		public function get label():String { return _name; }
		
		public function get name():String { return "ABCNamespaceKind"; }
		
		public function toString(indent:uint = 0):String {
			return ABC.toStringCommon(name, indent) + 
				"Type: " + type + ", " + 
				"Name: " + _name;
		}
		
	}
}
