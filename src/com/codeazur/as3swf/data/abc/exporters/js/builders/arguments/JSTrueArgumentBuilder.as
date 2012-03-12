package com.codeazur.as3swf.data.abc.exporters.js.builders.arguments
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCAttributeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSTrueExpression;
	import com.codeazur.utils.StringUtils;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSTrueArgumentBuilder implements IABCAttributeBuilder {
		
		public var expression:JSTrueExpression;
		
		private var _argument:ABCParameter;

		public function JSTrueArgumentBuilder() {
		}
		
		public static function create():JSTrueArgumentBuilder {
			const builder:JSTrueArgumentBuilder = new JSTrueArgumentBuilder();
			builder.expression = JSTrueExpression.create();
			return builder;
		}
		
		public function write(data:ByteArray):void {
			expression.write(data);
		}
		
		public function get argument():ABCParameter { return _argument; }
		public function set argument(value:ABCParameter) : void { _argument = value; }
		
		public function get name():String { return "JSTrueArgumentBuilder"; }
		
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
