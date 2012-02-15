package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCJavascriptTokenKind {
		
		public static const COLON:ABCJavascriptTokenKind = new ABCJavascriptTokenKind(":");
		public static const EQUALS:ABCJavascriptTokenKind = new ABCJavascriptTokenKind("=");
		public static const LEFT_CURLY_BRACKET:ABCJavascriptTokenKind = new ABCJavascriptTokenKind("{");
		public static const LEFT_PARENTHESES:ABCJavascriptTokenKind = new ABCJavascriptTokenKind("(");
		public static const LEFT_SQUARE_BRACKET:ABCJavascriptTokenKind = new ABCJavascriptTokenKind("[");
		public static const PIPE:ABCJavascriptTokenKind = new ABCJavascriptTokenKind("|");
		public static const RIGHT_CURLY_BRACKET:ABCJavascriptTokenKind = new ABCJavascriptTokenKind("}");
		public static const RIGHT_PARENTHESES:ABCJavascriptTokenKind = new ABCJavascriptTokenKind(")");
		public static const RIGHT_SQUARE_BRACKET:ABCJavascriptTokenKind = new ABCJavascriptTokenKind("]");
		public static const SEMI_COLON:ABCJavascriptTokenKind = new ABCJavascriptTokenKind(";");
		
		private var _type:String;
		
		public function ABCJavascriptTokenKind(type:String) {
			_type = type;
		}
		
		public function write(data:ByteArray):void {
			data.writeUTF(type);
		}
		
		public function get type():String { return _type; }
	}
}
