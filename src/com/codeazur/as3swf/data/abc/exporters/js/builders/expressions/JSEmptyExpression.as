package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCExpression;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSEmptyExpression implements IABCExpression {

		public function JSEmptyExpression() {
		}

		public static function create():JSEmptyExpression {
			return new JSEmptyExpression();
		}

		public function write(data:ByteArray):void {
		}
		
		public function get name():String { return "JSEmptyExpression"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
