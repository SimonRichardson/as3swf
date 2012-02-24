package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSConsumableBlock;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSEqualityExpression extends JSConsumableBlock implements IABCExpression {

		public function JSEqualityExpression() {
		}

		public static function create(left:IABCWriteable = null, right:IABCWriteable = null):JSEqualityExpression {
			const expression:JSEqualityExpression = new JSEqualityExpression();
			expression.left = left;
			expression.right = right;
			return expression;
		}

		override public function write(data:ByteArray):void {
			if(!right) {
				left.write(data);
			} else {
				left.write(data);
				
				JSTokenKind.EQUALS.write(data);
				JSTokenKind.EQUALS.write(data);
				JSTokenKind.EQUALS.write(data);
			
				right.write(data);
			}
		}
		
		override public function get name():String { return "JSEqualityExpression"; }
		
		override public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
