package com.codeazur.as3swf.data.abc.exporters.js.builders.parameters
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCParameterBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSNullExpression;
	import com.codeazur.utils.StringUtils;
	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSNullParameterBuilder implements IABCParameterBuilder
	{
		public var expression:JSNullExpression;
		
		private var _parameter:ABCParameter;

		public function JSNullParameterBuilder() {
		}
		
		public static function create():JSNullParameterBuilder {
			const builder:JSNullParameterBuilder = new JSNullParameterBuilder();
			builder.expression = JSNullExpression.create();
			return builder;
		}
		
		public function write(data:ByteArray):void {
			expression.write(data);
		}
		
		public function get parameter():ABCParameter { return _parameter; }
		public function set parameter(value:ABCParameter) : void { _parameter = value; }
		
		public function get name():String { return "JSNullParameterBuilder"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			if(parameter) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Parameter:";
				str += "\n" + parameter.toString(indent + 4);
			}
			
			return str;
		}
	}
}
