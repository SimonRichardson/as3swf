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
	public class JSDecrementExpression extends JSConsumableBlock implements IABCOperatorExpression
	{

		public function JSDecrementExpression()
		{
		}

		public static function create(left:IABCWriteable = null):JSDecrementExpression {
			const expression:JSDecrementExpression = new JSDecrementExpression();
			expression.left = left;
			return expression;
		}

		override public function write(data:ByteArray):void {
			left.write(data);
			JSOperatorKind.SUBTRACTION.write(data);
			data.writeUTF(int(1).toString(10));
		}
		
		override public function get name():String { return "JSDecrementExpression"; }
	}
}
