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
		
		public function JSSourceFormatter() {
			
		}

		public function format(byteArray:ByteArray):String {
			_byteArray = byteArray;
			_byteArray.position = 0;
			
			_source = extractUTF(byteArray);
			
			_lexer = new JSSourceLexer(_source);
			
			var root:JSSourceBlock = new JSSourceBlock("");
			var block:JSSourceBlock = root;
			var parent:JSSourceBlock = root;
			var indent:uint = 0;
			
			var previous:JSSourceToken;
			
			while(true) {
				const token:JSSourceToken = _lexer.getNextToken();
				if(JSSourceToken.isType(token, JSSourceTokenKind.EOF)) {
					break;
				} else {
					switch(token.kind) {
						case JSSourceTokenKind.SEMI_COLON:
							block.add(token.chars);
							block.add("\n", indent);
							break;
						
						case JSSourceTokenKind.WORD:
							if(JSSourceNewLineType.isKind(token.chars) && (block.tail.value != "\n" && block.tail.value != " = ")) {
								block.add("\n", indent);
							}
							block.add(token.chars);
							break;
							
						case JSSourceTokenKind.START_BLOCK:
							parent = block;
							block = block.add(token.chars, indent);
							block.parent = parent;
							
							indent += 4;
							break;
							
						case JSSourceTokenKind.END_BLOCK:
							parent = block.parent;
							if(block.tail.value == "\n") {
								block.tail.indent -= 4;
							}
							
							indent -= 4;
							
							block.add(token.chars, indent);
							block = parent;
							break;
						
						case JSSourceTokenKind.EQUALITY:
						case JSSourceTokenKind.OPERATOR:
							block.add(" " + token.chars + " ");
							break;
						
						default:
							block.add(token.chars);
							break;
					}
				}
				
				previous = token;
			}
			
			return root.toString();
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
