package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCBuilder;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSReturnBuilder implements IABCBuilder
	{
		
		public var expressions:IABCWriteable;
		
		public function JSReturnBuilder() {
		}
		
		public static function create(expressions:IABCWriteable):JSReturnBuilder {
			const instance:JSReturnBuilder = new JSReturnBuilder();
			instance.expressions = expressions;
			return instance;
		}

		public function write(data : ByteArray) : void {
			JSReservedKind.RETURN.write(data);
			JSTokenKind.SPACE.write(data);
			expressions.write(data);
		}
		
		public function get name():String { return "JSReturnBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
