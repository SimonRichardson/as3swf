package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSOperatorKind {
		
		public static const GREATER_THAN:JSOperatorKind = new JSOperatorKind();
		public static const LOGICAL_AND:JSOperatorKind = new JSOperatorKind();
		public static const LOGICAL_OR:JSOperatorKind = new JSOperatorKind();
		public static const LOGICAL_NOT:JSOperatorKind = new JSOperatorKind();
		public static const STRICT_EQUALITY:JSOperatorKind = new JSOperatorKind();
		public static const STRICT_INEQUALITY:JSOperatorKind = new JSOperatorKind();
				
		public function JSOperatorKind() {}
		
		public function write(data:ByteArray):void {
			switch(this) {
				case GREATER_THAN:
					JSTokenKind.RIGHT_ANGLE_BRACKET.write(data);
					break;
				
				case LOGICAL_AND:
					JSTokenKind.AMPERSAND.write(data);
					JSTokenKind.AMPERSAND.write(data);
					break;
					
				case LOGICAL_OR:
					JSTokenKind.PIPE.write(data);
					JSTokenKind.PIPE.write(data);
					break;
				
				case LOGICAL_NOT:
					JSTokenKind.EXCLAMATION_MARK.write(data);
					break;
					
				case STRICT_EQUALITY:
					JSTokenKind.EQUALS.write(data);
					JSTokenKind.EQUALS.write(data);
					JSTokenKind.EQUALS.write(data);
					break;
				
				case STRICT_INEQUALITY:
					JSTokenKind.EXCLAMATION_MARK.write(data);
					JSTokenKind.EQUALS.write(data);
					JSTokenKind.EQUALS.write(data);
					break;
			}
		}
	}
}
