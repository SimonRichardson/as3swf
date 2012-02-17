package com.codeazur.as3swf.data.abc.exporters.builders.js.formatters
{
	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSSourceFormatter {
		
		private var _lexer:JSSourceLexer;
		
		private var _source:String;
		private var _byteArray:ByteArray;
		
		
		public var result:String;
		
		
		public function JSSourceFormatter() {
			
		}

		public function format(byteArray:ByteArray):String {
			_byteArray = byteArray;
			_byteArray.position = 0;
			
			_source = extractUTF(byteArray);
			
			_lexer = new JSSourceLexer(_source);
			
			result = "";
			
			var previous:JSSourceToken;
			
			while(true) {
				const token:JSSourceToken = _lexer.getNextToken();
				if(JSSourceToken.isType(token, JSSourceTokenKind.EOF)) {
					break;
				} else {
					trace(token.chars);
				}
				
				previous = token;
			}
			
			return result;
		}
		
		private function extractUTF(byteArray:ByteArray):String {
			var utf:String = "";
			while(byteArray.position < byteArray.length) {
				utf += byteArray.readUTF();
			}
			return utf;
		}
	}
}
