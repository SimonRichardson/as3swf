package com.codeazur.as3swf.data.abc.exporters.builders.js.formatters
{
	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSReservedKind;
	import flash.utils.Dictionary;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSSourceNewLineType {
		
		private static const _types : Dictionary = new Dictionary();
		private static const _nameTypes : Dictionary = new Dictionary();
		
		public static const BREAK:JSSourceNewLineType = new JSSourceNewLineType(JSReservedKind.BREAK);
		public static const CASE:JSSourceNewLineType = new JSSourceNewLineType(JSReservedKind.CASE);
		public static const CONTINUE:JSSourceNewLineType = new JSSourceNewLineType(JSReservedKind.CONTINUE);
		public static const DEFAULT:JSSourceNewLineType = new JSSourceNewLineType(JSReservedKind.DEFAULT);
		public static const FOR:JSSourceNewLineType = new JSSourceNewLineType(JSReservedKind.FOR);
		public static const IF:JSSourceNewLineType = new JSSourceNewLineType(JSReservedKind.IF);
		public static const RETURN:JSSourceNewLineType = new JSSourceNewLineType(JSReservedKind.RETURN);
		public static const SWITCH:JSSourceNewLineType = new JSSourceNewLineType(JSReservedKind.SWITCH);
		public static const THROW:JSSourceNewLineType = new JSSourceNewLineType(JSReservedKind.THROW);
		public static const TRY:JSSourceNewLineType = new JSSourceNewLineType(JSReservedKind.TRY);
		public static const VAR:JSSourceNewLineType = new JSSourceNewLineType(JSReservedKind.VAR);
		public static const WHILE:JSSourceNewLineType = new JSSourceNewLineType(JSReservedKind.WHILE);

		private var _kind:JSReservedKind;
		
		public function JSSourceNewLineType(kind:JSReservedKind) {
			_kind = kind;
			_types[kind] = this;
			_nameTypes[kind.type] = this;
		}
		
		public static function isType(kind:JSReservedKind, type:JSSourceNewLineType):Boolean {
			return _types[kind] == type;
		}
		
		public static function isKind(name:String):Boolean {
			return (name != "toString") ? _nameTypes[name] : false;
		}
		
		public function get kind():JSReservedKind { return _kind; }
	}
}
