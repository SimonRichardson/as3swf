package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSReservedKind;
	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSThisExpression implements IABCExpression {

		public function JSThisExpression() {
		}

		public static function create():JSThisExpression {
			return new JSThisExpression();
		}

		public function write(data:ByteArray):void {
			JSReservedKind.THIS.write(data);
			JSTokenKind.DOT.write(data);
		}
		
		public function get name():String { return "JSThisExpression"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
