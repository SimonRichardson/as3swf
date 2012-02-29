package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSIfNotEqualExpression extends JSIfExpression {

		public function JSIfNotEqualExpression() {
		}
		
		public static function create():JSIfNotEqualExpression {
			const instance:JSIfNotEqualExpression = new JSIfNotEqualExpression();
			return instance;
		}

		override public function write(data : ByteArray) : void {
		}

		override public function get name() : String { return "JSIfNotEqualExpression"; }
	}
}
