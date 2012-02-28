package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

	import com.codeazur.as3swf.data.abc.exporters.builders.IABCExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSConsumableBlock;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSOperatorKind;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSGreaterThanExpression extends JSConsumableBlock implements IABCExpression {

		public function JSGreaterThanExpression() {
		}

		public static function create(left:IABCWriteable = null, right:IABCWriteable = null):JSGreaterThanExpression {
			const expression:JSGreaterThanExpression = new JSGreaterThanExpression();
			expression.left = left;
			expression.right = right;
			return expression;
		}

		override public function write(data:ByteArray):void {
			left.write(data);
			JSOperatorKind.GREATER_THAN.write(data);
			right.write(data);
		}
		
		override public function get name():String { return "JSGreaterThanExpression"; }
	}
}
