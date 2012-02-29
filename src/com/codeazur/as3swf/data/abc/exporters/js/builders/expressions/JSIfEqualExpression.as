package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

	import com.codeazur.as3swf.data.abc.exporters.builders.ABCIfStatementType;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;

	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSIfEqualExpression extends JSIfExpression {

		public static function create():JSIfEqualExpression {
			return new JSIfEqualExpression();
		}

		override public function write(data : ByteArray) : void {
			JSTokenKind.LEFT_PARENTHESES.write(data);
			
			statement.write(data);
			
			JSTokenKind.RIGHT_PARENTHESES.write(data);
		}

		override public function get name() : String { return "JSIfEqualExpression"; }
		override public function get type():ABCIfStatementType { return ABCIfStatementType.EQUAL; }
	}
}
