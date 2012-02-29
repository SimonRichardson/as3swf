package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

	import com.codeazur.as3swf.data.abc.exporters.builders.ABCIfStatementType;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSIfNotGreaterThanExpression extends JSIfExpression {

		public function JSIfNotGreaterThanExpression() {
		}
		
		public static function create():JSIfNotGreaterThanExpression {
			const instance:JSIfNotGreaterThanExpression = new JSIfNotGreaterThanExpression();
			return instance;
		}

		override public function write(data : ByteArray) : void {
		}

		override public function get name() : String { return "JSIfNotGreaterThanExpression"; }
		override public function get type():ABCIfStatementType { return ABCIfStatementType.NOT_GREATER_THAN; }
	}
}
