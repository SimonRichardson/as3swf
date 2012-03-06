package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSTokenKind {
		
		public static const ASTERISK:JSTokenKind = new JSTokenKind("*");
		public static const AMPERSAND:JSTokenKind = new JSTokenKind("&");
		public static const BACK_SLASH:JSTokenKind = new JSTokenKind("\\");
		public static const COLON:JSTokenKind = new JSTokenKind(":");
		public static const COMMA:JSTokenKind = new JSTokenKind(",");
		public static const DOT:JSTokenKind = new JSTokenKind(".");
		public static const DOUBLE_QUOTE:JSTokenKind = new JSTokenKind("\"");
		public static const EQUALS:JSTokenKind = new JSTokenKind("=");
		public static const EXCLAMATION_MARK:JSTokenKind = new JSTokenKind("!");
		public static const FORWARD_SLASH:JSTokenKind = new JSTokenKind("/");
		public static const LEFT_ANGLE_BRACKET : JSTokenKind = new JSTokenKind("<");
		public static const LEFT_CURLY_BRACKET:JSTokenKind = new JSTokenKind("{");
		public static const LEFT_PARENTHESES:JSTokenKind = new JSTokenKind("(");
		public static const LEFT_SQUARE_BRACKET:JSTokenKind = new JSTokenKind("[");
		public static const PIPE:JSTokenKind = new JSTokenKind("|");
		public static const PLUS_SIGN:JSTokenKind = new JSTokenKind("+");
		public static const MINUS_SIGN:JSTokenKind = new JSTokenKind("-");
		public static const QUESTION_MARK:JSTokenKind = new JSTokenKind("?");
		public static const RIGHT_ANGLE_BRACKET : JSTokenKind = new JSTokenKind(">");
		public static const RIGHT_CURLY_BRACKET:JSTokenKind = new JSTokenKind("}");
		public static const RIGHT_PARENTHESES:JSTokenKind = new JSTokenKind(")");
		public static const RIGHT_SQUARE_BRACKET:JSTokenKind = new JSTokenKind("]");
		public static const SEMI_COLON:JSTokenKind = new JSTokenKind(";");
		public static const SINGLE_QUOTE:JSTokenKind = new JSTokenKind("'");
		public static const SPACE : JSTokenKind = new JSTokenKind(" ");

		private var _type:String;
		
		public function JSTokenKind(type:String) {
			_type = type;
		}
		
		public function write(data:ByteArray):void {
			data.writeUTF(type);
		}
		
		public static function isType(type:String, kind:JSTokenKind):Boolean {
			return kind.type == type;
		}
		
		public function get type():String { return _type; }
	}
}
