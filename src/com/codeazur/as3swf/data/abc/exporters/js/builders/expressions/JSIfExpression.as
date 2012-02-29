package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

	import com.codeazur.as3swf.data.abc.exporters.builders.ABCIfStatementType;
	import com.codeazur.utils.StringUtils;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCIfStatementExpression;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSIfExpression implements IABCIfStatementExpression {

		private var _statement:IABCWriteable;

		public function JSIfExpression(){
		}

		public function write(data:ByteArray):void {
		}

		public function get statement():IABCWriteable { return _statement; }
		public function set statement(value:IABCWriteable):void { _statement = value; }
		
		public function get type():ABCIfStatementType { return null; }
		
		public function get name():String { return "JSIfExpression"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Statement:";
			str += "\n" + statement.toString(indent + 4);
			
			return str;
		}
	}
}
