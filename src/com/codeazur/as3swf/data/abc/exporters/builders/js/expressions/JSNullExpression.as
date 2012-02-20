package com.codeazur.as3swf.data.abc.exporters.builders.js.expressions
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCExpression;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSReservedKind;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSNullExpression implements IABCExpression {

		public function JSNullExpression() {
		}

		public static function create():JSNullExpression {
			return new JSNullExpression();
		}

		public function write(data:ByteArray):void {
			JSReservedKind.NULL.write(data);
		}
		
		public function get name():String { return "JSNullExpression"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
