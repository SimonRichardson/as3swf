package com.codeazur.as3swf.data.abc.exporters.js.formatters
{
	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSSourceToken {
		
		public var chars:String;
		public var kind:JSSourceTokenKind;
		
		public function JSSourceToken(){
			
		}
		
		public static function create(chars:String, kind:JSSourceTokenKind):JSSourceToken {
			const token:JSSourceToken = new JSSourceToken();
			token.chars = chars;
			token.kind = kind;
			return token;
		}
		
		public static function isType(type:JSSourceToken, kind:JSSourceTokenKind):Boolean {
			return type.kind == kind;
		}
		
		public function get name():String { return "JSSourceToken"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent); 
		}
	}
}
