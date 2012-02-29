package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

	import com.codeazur.as3swf.data.abc.exporters.builders.ABCIfStatementType;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSOperatorKind;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSIfNotEqualExpression extends JSIfExpression {

		public static function create():JSIfNotEqualExpression {
			return new JSIfNotEqualExpression();
		}

		override public function write(data : ByteArray) : void {
			JSOperatorKind.LOGICAL_NOT.write(data);
			JSTokenKind.LEFT_PARENTHESES.write(data);
			
			statement.write(data);
			
			JSTokenKind.RIGHT_PARENTHESES.write(data);
		}

		override public function get name() : String { return "JSIfNotEqualExpression"; }
		override public function get type():ABCIfStatementType { return ABCIfStatementType.NOT_EQUAL; }
	}
}
