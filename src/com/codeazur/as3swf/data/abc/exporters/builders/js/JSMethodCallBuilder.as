package com.codeazur.as3swf.data.abc.exporters.builders.js
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodCallBuilder;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMethodCallBuilder implements IABCMethodCallBuilder {
		
		public var expressions:Vector.<IABCWriteable>;
		public var method:IABCWriteable;
		public var parameters:Vector.<JSParameterBuilder>;
		
		public function JSMethodCallBuilder() {
		}
		
		public static function create(expressions:Vector.<IABCWriteable>, method:IABCWriteable, parameters:Vector.<JSParameterBuilder> = null):JSMethodCallBuilder {
			const builder:JSMethodCallBuilder = new JSMethodCallBuilder();
			builder.expressions = expressions;
			builder.method = method;
			builder.parameters = parameters;
			return builder;
		}

		public function write(data : ByteArray) : void {
			if(expressions.length > 0) {
				JSAccessorBuilder.create(expressions).write(data);
				JSTokenKind.DOT.write(data);
			}
			
			method.write(data);
			
			JSTokenKind.LEFT_PARENTHESES.write(data);
			if(null != parameters) {
				const total:uint = parameters.length;
				for(var i:uint=0; i<total; i++) {
					const parameter:JSParameterBuilder = parameters[i];
					parameter.write(data);
					
					if(i < total - 1) {
						JSTokenKind.COMMA.write(data);
					}
				}
			}
			JSTokenKind.RIGHT_PARENTHESES.write(data);
		}
		
		public function get name():String { return "JSMethodCallBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
