package com.codeazur.as3swf.data.abc.exporters.builders.js.expressions
{

	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSReservedKind;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCExpression;

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
		}
		
		public function get name():String { return "JSVariableBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
