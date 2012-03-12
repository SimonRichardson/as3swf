package com.codeazur.as3swf.data.abc.exporters.js.builders.arguments
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCAttributeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSNullExpression;
	import com.codeazur.utils.StringUtils;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSNullArgumentBuilder implements IABCAttributeBuilder {
		
		public var expression:JSNullExpression;
		
		private var _argument:ABCParameter;

		public function JSNullArgumentBuilder() {
		}
		
		public static function create():JSNullArgumentBuilder {
			const builder:JSNullArgumentBuilder = new JSNullArgumentBuilder();
			builder.expression = JSNullExpression.create();
			return builder;
		}
		
		public function write(data:ByteArray):void {
			expression.write(data);
		}
		
		public function get argument():ABCParameter { return _argument; }
		public function set argument(value:ABCParameter) : void { _argument = value; }
		
		public function get name():String { return "JSNullArgumentBuilder"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			if(argument) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Argument:";
				str += "\n" + argument.toString(indent + 4);
			}
			
			return str;
		}
	}
}
