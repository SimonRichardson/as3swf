package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

	import com.codeazur.as3swf.data.abc.exporters.builders.IABCOperatorExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSConsumableBlock;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSOperatorKind;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMultiplyExpression extends JSConsumableBlock implements IABCOperatorExpression {

		public function JSMultiplyExpression() {
		}

		public static function create(left:IABCWriteable = null, right:IABCWriteable = null):JSMultiplyExpression {
			const expression:JSMultiplyExpression = new JSMultiplyExpression();
			expression.left = left;
			expression.right = right;
			return expression;
		}

		override public function write(data:ByteArray):void {
			left.write(data);
			JSOperatorKind.MULTIPLICATION.write(data);
			right.write(data);			
		}
		
		override public function get name():String { return "JSMultiplyExpression"; }
	}
}
