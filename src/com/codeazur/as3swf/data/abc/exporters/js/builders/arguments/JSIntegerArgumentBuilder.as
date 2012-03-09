package com.codeazur.as3swf.data.abc.exporters.js.builders.arguments
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedNameType;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCAttributeBuilder;
	import com.codeazur.utils.StringUtils;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSIntegerArgumentBuilder implements IABCAttributeBuilder
	{
		
		public var integer:int;
		
		private var _argument:ABCParameter;

		public function JSIntegerArgumentBuilder() {
		}
		
		public static function create(integer:int):JSIntegerArgumentBuilder {
			const builder:JSIntegerArgumentBuilder = new JSIntegerArgumentBuilder();
			builder.integer = integer;
			builder.argument = ABCParameter.create(ABCQualifiedNameType.INT.type, "", integer);
			return builder;
		}
		
		public function write(data:ByteArray):void {
			data.writeUTF(integer.toString(10));
		}
		
		public function get argument():ABCParameter { return _argument; }
		public function set argument(value:ABCParameter) : void { _argument = value; }
		
		public function get name():String { return "JSIntegerArgumentBuilder"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Value:";
			str += "\n" + StringUtils.repeat(indent + 5) + integer.toString(10);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Argument:";
			str += "\n" + argument.toString(indent + 4);
			
			return str;
		}
	}
}
