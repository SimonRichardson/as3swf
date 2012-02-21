package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCAccessorBuilder;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSAccessorBuilder implements IABCAccessorBuilder
	{

		public var expressions:Vector.<IABCWriteable>;

		public function JSAccessorBuilder() {
		}
		
		public static function create(expressions:Vector.<IABCWriteable>):JSAccessorBuilder {
			const builder:JSAccessorBuilder = new JSAccessorBuilder();
			builder.expressions = expressions;
			return builder;
		}

		public function write(data : ByteArray) : void {
			const total:uint = expressions.length;
			for(var i:uint=0; i<total; i++){
				expressions[i].write(data);
				
				if(i < total - 1) {
					JSTokenKind.DOT.write(data);
				}
			}
		}
		
		public function get name():String { return "JSAccessorBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
