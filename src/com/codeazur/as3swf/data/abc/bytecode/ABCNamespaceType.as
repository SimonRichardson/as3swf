package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.ABC;

	import flash.utils.Dictionary;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCNamespaceType {
		
		private static const _types:Dictionary = new Dictionary();
		
		public static const ASTERISK:ABCNamespaceType = new ABCNamespaceType(new ABCNamespace(ABCNamespaceKind.NAMESPACE, "*"));
		public static const SUPER:ABCNamespaceType = new ABCNamespaceType(new ABCNamespace(ABCNamespaceKind.NAMESPACE));

		private var _ns:ABCNamespace;

		public function ABCNamespaceType(ns:ABCNamespace) {
			_ns = ns;
			_types[this] = ns;
		}
		
		public static function getType(type:ABCNamespaceType):ABCNamespace {
			return _types[type]; 
		}
		
		public static function isType(type:ABCNamespaceType, kind:ABCNamespaceType):Boolean {
			return type.ns.kind == kind.ns.kind && type.ns.value == kind.ns.value;
		}
		
		public static function isTypeByValue(value:String, kind:ABCNamespaceType):Boolean {
			return kind.ns.value == value;
		}
		
		public function get ns():ABCNamespace { return _ns; }
		public function get name():String { return "ABCNamespaceType"; }
		
		public function toString(indent:uint = 0) : String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
