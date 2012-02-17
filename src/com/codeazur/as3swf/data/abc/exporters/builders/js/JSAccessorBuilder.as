package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCAccessorBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSAccessorBuilder implements IABCAccessorBuilder
	{

		public var object : IABCValueBuilder;
		public var property : IABCValueBuilder;

		public function JSAccessorBuilder() {
		}
		
		public static function create(object:IABCValueBuilder, property:IABCValueBuilder):JSAccessorBuilder {
			const builder:JSAccessorBuilder = new JSAccessorBuilder();
			builder.object = object;
			builder.property = property;
			return builder;
		}

		public function write(data : ByteArray) : void
		{
			data.writeUTF(object.value);
			JSTokenKind.DOT.write(data);
			data.writeUTF(property.value);
		}
		
		public function get name():String { return "JSClassBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
