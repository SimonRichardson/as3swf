package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSReservedKind {
		
		private static const _types : Dictionary = new Dictionary();
		
		public static const BREAK:JSReservedKind = new JSReservedKind("break");
		public static const CASE:JSReservedKind = new JSReservedKind("case");
		public static const CONTINUE:JSReservedKind = new JSReservedKind("continue");
		public static const DEFAULT:JSReservedKind = new JSReservedKind("default");
		public static const FOR:JSReservedKind = new JSReservedKind("for");
		public static const FUNCTION:JSReservedKind = new JSReservedKind("function");
		public static const IF:JSReservedKind = new JSReservedKind("if");
		public static const IN:JSReservedKind = new JSReservedKind("in");
		public static const NULL:JSReservedKind = new JSReservedKind("null");
		public static const RETURN:JSReservedKind = new JSReservedKind("return");
		public static const SWITCH:JSReservedKind = new JSReservedKind("switch");
		public static const THIS:JSReservedKind = new JSReservedKind("this");
		public static const THROW:JSReservedKind = new JSReservedKind("throw");
		public static const TRY:JSReservedKind = new JSReservedKind("try");
		public static const VAR:JSReservedKind = new JSReservedKind("var");
		public static const WHILE:JSReservedKind = new JSReservedKind("while");
		
		private var _type:String;
		
		public function JSReservedKind(type:String) {
			_type = type;
			_types[type] = this;
		}
		
		public static function isType(name:String, type:JSReservedKind):Boolean {
			return _types[name] == type;
		}
		
		public function write(data:ByteArray):void {
			data.writeUTF(type);
		}
		
		public function get type():String { return _type; }
	}
}