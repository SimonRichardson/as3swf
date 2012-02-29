package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

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
		}

		override public function get name() : String { return "JSIfFalseExpression"; }
	}
}
