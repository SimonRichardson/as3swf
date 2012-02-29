package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCPrimaryExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSReservedKind;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSTrueExpression implements IABCPrimaryExpression {

		public function JSTrueExpression() {
		}

		public static function create():JSTrueExpression {
			return new JSTrueExpression();
		}

		public function write(data:ByteArray):void {
			JSReservedKind.TRUE.write(data);
		}
		
		public function get name():String { return "JSTrueExpression"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
