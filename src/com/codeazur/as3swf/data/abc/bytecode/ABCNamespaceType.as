package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCNamespaceType {

		private static const _types : Object = new Object();
		
		public static const UNKNOWN:ABCNamespaceType = new ABCNamespaceType(0x0);
		public static const NAMESPACE:ABCNamespaceType = new ABCNamespaceType(0x08);
		public static const PACKAGE_NAMESPACE:ABCNamespaceType = new ABCNamespaceType(0x16);
		public static const PACKAGE_INTERNAL_NAMESPACE:ABCNamespaceType = new ABCNamespaceType(0x17);
		public static const PROTECTED_NAMESPACE:ABCNamespaceType = new ABCNamespaceType(0x18);
		public static const EXPLICIT_NAMESPACE:ABCNamespaceType = new ABCNamespaceType(0x19);
		public static const STATIC_PROTECTED_NAMESPACE:ABCNamespaceType = new ABCNamespaceType(0x1A);
		public static const PRIVATE_NAMESPACE:ABCNamespaceType = new ABCNamespaceType(0x05);

		private var _type:uint;
		
		public function ABCNamespaceType(type:uint) {
			_type = type;
			_types[_type] = this;
		}

		public static function getType(type:uint) : ABCNamespaceType {
			 return _types[type];
		}
		
		public function get type():uint { return _type; }
		public function get name():String { return "ABCNamespaceType"; }
		
		public function toString(indent:uint = 0) : String {
			return ABC.toStringCommon(name, indent) + 
				"Type:" + type;
		}
		
	}
}
