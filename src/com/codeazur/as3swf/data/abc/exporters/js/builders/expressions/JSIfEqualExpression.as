package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSIfEqualExpression extends JSIfExpression {

		public function JSIfEqualExpression() {
		}
		
		public static function create():JSIfEqualExpression {
			const instance:JSIfEqualExpression = new JSIfEqualExpression();
			return instance;
		}

		override public function write(data : ByteArray) : void {
		}

		override public function get name() : String { return "JSIfEqualExpression"; }
	}
}
