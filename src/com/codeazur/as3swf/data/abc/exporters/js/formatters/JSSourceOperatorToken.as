package com.codeazur.as3swf.data.abc.exporters.js.formatters
{
	import flash.utils.Dictionary;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSSourceOperatorToken {
		
		private static const _types:Dictionary = new Dictionary();
		
		public static const ADDITION:JSSourceOperatorToken = new JSSourceOperatorToken("+");
		public static const ADDITION_ASSIGNMENT:JSSourceOperatorToken = new JSSourceOperatorToken("+="); 
		public static const BITWISE_AND:JSSourceOperatorToken = new JSSourceOperatorToken("&"); 
		public static const BITWISE_AND_ASSIGNMENT:JSSourceOperatorToken = new JSSourceOperatorToken("&="); 
		public static const BITWISE_LEFT_SHIFT:JSSourceOperatorToken = new JSSourceOperatorToken("<<"); 
		public static const BITWISE_LEFT_SHIFT_ASSIGNMENT:JSSourceOperatorToken = new JSSourceOperatorToken("<<="); 
		public static const BITWISE_OR:JSSourceOperatorToken = new JSSourceOperatorToken("|"); 
		public static const BITWISE_OR_ASSIGNMENT:JSSourceOperatorToken = new JSSourceOperatorToken("|=");
		public static const BITWISE_RIGHT_SHIFT:JSSourceOperatorToken = new JSSourceOperatorToken(">>"); 
		public static const BITWISE_RIGHT_SHIFT_ASSIGNMENT:JSSourceOperatorToken = new JSSourceOperatorToken(">>="); 
		public static const BITWISE_UNSIGNED_RIGHT_SHIFT:JSSourceOperatorToken = new JSSourceOperatorToken(">>>"); 
		public static const BITWISE_UNSIGNED_RIGHT_SHIFT_ASSIGNMENT:JSSourceOperatorToken = new JSSourceOperatorToken(">>>="); 
		public static const BITWISE_XOR:JSSourceOperatorToken = new JSSourceOperatorToken("^"); 
		public static const BITWISE_XOR_ASSIGNMENT:JSSourceOperatorToken = new JSSourceOperatorToken("^="); 
		public static const COMMA:JSSourceOperatorToken = new JSSourceOperatorToken(","); 
		public static const DECREMENT:JSSourceOperatorToken = new JSSourceOperatorToken("--"); 
		public static const DIVISION:JSSourceOperatorToken = new JSSourceOperatorToken("/"); 
		public static const DIVISION_ASSIGNMENT:JSSourceOperatorToken = new JSSourceOperatorToken("/="); 
		public static const EQUALITY:JSSourceOperatorToken = new JSSourceOperatorToken("=="); 
		public static const EQUALS:JSSourceOperatorToken = new JSSourceOperatorToken("="); 
		public static const GREATER_THAN:JSSourceOperatorToken = new JSSourceOperatorToken(">"); 
		public static const GREATER_THAN_OR_EQUAL_TO:JSSourceOperatorToken = new JSSourceOperatorToken(">="); 
		public static const INCREMENT:JSSourceOperatorToken = new JSSourceOperatorToken("++"); 
		public static const INEQUALITY:JSSourceOperatorToken = new JSSourceOperatorToken("!="); 
		public static const LESS_THAN:JSSourceOperatorToken = new JSSourceOperatorToken("<"); 
		public static const LESS_THAN_OR_EQUAL_TO:JSSourceOperatorToken = new JSSourceOperatorToken("<="); 
		public static const LOGICAL_AND:JSSourceOperatorToken = new JSSourceOperatorToken("&&"); 
		public static const LOGICAL_OR:JSSourceOperatorToken = new JSSourceOperatorToken("||"); 
		public static const LOGICAL_NOT:JSSourceOperatorToken = new JSSourceOperatorToken("!"); 
		public static const MODULO:JSSourceOperatorToken = new JSSourceOperatorToken("%"); 
		public static const MODULO_ASSIGNMENT:JSSourceOperatorToken = new JSSourceOperatorToken("%="); 
		public static const MULTIPLICATION:JSSourceOperatorToken = new JSSourceOperatorToken("*"); 
		public static const MULITPLICATION_ASSIGNMENT:JSSourceOperatorToken = new JSSourceOperatorToken("*="); 
		public static const QUESTION_MARK:JSSourceOperatorToken = new JSSourceOperatorToken("?"); 
		public static const STRICT_EQUALITY:JSSourceOperatorToken = new JSSourceOperatorToken("==="); 
		public static const STRICT_INEQUALITY:JSSourceOperatorToken = new JSSourceOperatorToken("!=="); 
		public static const SUBTRACTION:JSSourceOperatorToken = new JSSourceOperatorToken("-"); 
		public static const SUBTRACTION_ASSIGNMENT:JSSourceOperatorToken = new JSSourceOperatorToken("-="); 
		public static const TYPE:JSSourceOperatorToken = new JSSourceOperatorToken(":"); 
		
		private var _type:String;
		
		public function JSSourceOperatorToken(type:String) {
			_type = type;
			_types[type] = this;
		}
		
		public static function isKind(char:String):Boolean {
			return _types[char] != null;
		}
		
		public static function isType(char:String, type:JSSourceOperatorToken):Boolean {
			return _types[char] == type;
		}

		public function get type():String { return _type; }
	}
}
