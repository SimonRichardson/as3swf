package com.codeazur.as3swf.data.abc.exporters.builders.js.formatters
{
	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSReservedKind;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSSourceLexer {
		
		public var whitespace:Vector.<uint> = new <uint>[10, 11, 13];
		
		private var _source:String;
		private var _sourceLength:uint;
		
		private var _position:uint;

		public function JSSourceLexer(source:String) {
			_source = source;
			_sourceLength = source.length;
			
			_position = 0;
		}
		
		public function getNextToken():JSSourceToken {
			var token:JSSourceToken;
			
			var char:String = _source.charAt(_position);
			var code:uint = _source.charCodeAt(_position);
			
			_position++;
			
			var word:String = "";
			
			while(contains(whitespace, code)) {
				if(_position > _sourceLength) {
					return JSSourceToken.create(char, JSSourceTokenKind.EOF);
				}
				
				char = _source.charAt(_position);
				code = _source.charCodeAt(_position);
				
				_position++;
			}
			
			if(_position > _sourceLength) {
				token = JSSourceToken.create(char, JSSourceTokenKind.EOF);
			} else if(isWordChar(code)) {
				while(isWordChar(code)) {
					word += char;
					
					char = _source.charAt(_position);
					code = _source.charCodeAt(_position);
					
					_position++;
					
					if(!isWordChar(code)) {
						_position--;
						break;
					}
				}
								
				if(JSReservedKind.isType(word, JSReservedKind.IN)) {
					token = JSSourceToken.create(word, JSSourceTokenKind.OPERATOR);
				} else {
					token = JSSourceToken.create(word, JSSourceTokenKind.WORD);
				}
			} else if(code == 40 || code == 91) {
				token = JSSourceToken.create(char, JSSourceTokenKind.START_EXPR);
			} else if(code == 41 || code == 93) {
				token = JSSourceToken.create(char, JSSourceTokenKind.END_EXPR);
			} else if(code == 123) {
				token = JSSourceToken.create(char, JSSourceTokenKind.START_BLOCK);
			} else if(code == 125) {
				token = JSSourceToken.create(char, JSSourceTokenKind.END_BLOCK);
			} else if(code == 59) {
				token = JSSourceToken.create(char, JSSourceTokenKind.SEMI_COLON);
			} else if(code == 34 || code == 39) {
				const identifier:uint = code;
				
				word += char;
				
				char = _source.charAt(_position);
				code = _source.charCodeAt(_position);
				
				_position++;
				
				var escape:Boolean = false;
				while(escape || identifier != code) {
					word += char;
					
					char = _source.charAt(_position);
					code = _source.charCodeAt(_position);
					
					_position++;
					
					if(!escape) {
						escape = code == 92;
					} else {
						escape = false;
					}
				}
				
				word += char;
				
				token = JSSourceToken.create(word, JSSourceTokenKind.STRING);
			} else if(JSSourceOperatorToken.isKind(char)) {
				while(JSSourceOperatorToken.isKind(char)) {
					word += char;
					
					char = _source.charAt(_position);
					code = _source.charCodeAt(_position);
					
					_position++;
					
					if(!JSSourceOperatorToken.isKind(char)) {
						_position--;
						break;
					}
				}
				
				if(JSSourceOperatorToken.isType(word, JSSourceOperatorToken.EQUALS)) {
					token = JSSourceToken.create(word, JSSourceTokenKind.EQUALITY);
				}
				else token = JSSourceToken.create(word, JSSourceTokenKind.OPERATOR);
			} 
						
			return token || JSSourceToken.create(char, JSSourceTokenKind.UNKNOWN);
		}
		
		private function contains(haystack:Vector.<uint>, needle:uint):Boolean {
			const total:uint = haystack.length;
			for(var i:uint=0; i<total; i++) {
				if(haystack[i] == needle) {
					return true;
				}
			}
			return false;
		}
		
		private function isWordChar(char:uint):Boolean {
			return 	char == 36 || 
					char == 95 || 
					(char >= 48 && char <= 57) || 
					(char >= 65 && char <= 90) || 
					(char >= 97 && char <= 122);
		}

	}
}
