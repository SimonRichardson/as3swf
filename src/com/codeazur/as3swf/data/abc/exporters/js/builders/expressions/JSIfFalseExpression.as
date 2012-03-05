package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

	import com.codeazur.as3swf.data.abc.exporters.builders.ABCIfStatementType;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSIfFalseExpression extends JSIfExpression {

		public function JSIfFalseExpression() {
		}
		
		public static function create():JSIfFalseExpression {
			const instance:JSIfFalseExpression = new JSIfFalseExpression();
			return instance;
		}

		override public function write(data : ByteArray) : void {
			JSTokenKind.LEFT_PARENTHESES.write(data);
			
			statement.write(data);
			
			JSTokenKind.RIGHT_PARENTHESES.write(data);
		}

		override public function get name() : String { return "JSIfFalseExpression"; }
		override public function get type():ABCIfStatementType { return ABCIfStatementType.FALSE; }
	}
}
