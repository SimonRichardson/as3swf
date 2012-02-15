package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCJavascriptLiteralKind {
		
		public static const FUNCTION:ABCJavascriptLiteralKind = new ABCJavascriptLiteralKind();
		public static const OBJECT:ABCJavascriptLiteralKind = new ABCJavascriptLiteralKind();
				
		public function ABCJavascriptLiteralKind() {}
		
		public function write(data:ByteArray):void {
			switch(this) {
				case FUNCTION:
					data.writeUTF("function");
					ABCJavascriptTokenKind.LEFT_PARENTHESES.write(data);
					ABCJavascriptTokenKind.RIGHT_PARENTHESES.write(data);
					ABCJavascriptTokenKind.LEFT_CURLY_BRACKET.write(data);
					ABCJavascriptTokenKind.RIGHT_CURLY_BRACKET.write(data);
					break;
				case OBJECT:
					ABCJavascriptTokenKind.LEFT_CURLY_BRACKET.write(data);
					ABCJavascriptTokenKind.RIGHT_CURLY_BRACKET.write(data);
					break;
			}
		}
	}
}
