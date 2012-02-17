package com.codeazur.as3swf.data.abc.exporters.builders.js.formatters
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSSourceTokenKind {
		
		public static const END_BLOCK : JSSourceTokenKind = new JSSourceTokenKind(0x0001);
		public static const END_EXPR : JSSourceTokenKind = new JSSourceTokenKind(0x0002);
		public static const EOF : JSSourceTokenKind = new JSSourceTokenKind(0x0003);
		public static const EQUALITY : JSSourceTokenKind = new JSSourceTokenKind(0x0004);
		public static const OPERATOR : JSSourceTokenKind = new JSSourceTokenKind(0x0005);
		public static const SEMI_COLON : JSSourceTokenKind = new JSSourceTokenKind(0x0006);
		public static const START_BLOCK : JSSourceTokenKind = new JSSourceTokenKind(0x0007);
		public static const START_EXPR : JSSourceTokenKind = new JSSourceTokenKind(0x0008);
		public static const STRING : JSSourceTokenKind = new JSSourceTokenKind(0x0009);
		public static const UNKNOWN : JSSourceTokenKind = new JSSourceTokenKind(0x0010);
		public static const WORD : JSSourceTokenKind = new JSSourceTokenKind(0x0011);

		private var _type:uint;

		public function JSSourceTokenKind(type:uint) {
			_type = type;
		}
		
		public function get type():uint { return _type; }
	}
}
