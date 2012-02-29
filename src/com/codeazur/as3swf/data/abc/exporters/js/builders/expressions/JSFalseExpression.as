package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCPrimaryExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSReservedKind;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSFalseExpression implements IABCPrimaryExpression {

		public function JSFalseExpression() {
		}

		public static function create():JSFalseExpression {
			return new JSFalseExpression();
		}

		public function write(data:ByteArray):void {
			JSReservedKind.FALSE.write(data);
		}
		
		public function get name():String { return "JSFalseExpression"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
