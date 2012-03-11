package com.codeazur.as3swf.data.abc.exporters.js.builders.arguments
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCMultinameBuiltin;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCAttributeBuilder;
	import com.codeazur.utils.StringUtils;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSUnsignedIntegerArgumentBuilder implements IABCAttributeBuilder
	{
		
		public var unsignedInteger:uint;
		
		private var _argument:ABCParameter;

		public function JSUnsignedIntegerArgumentBuilder() {
		}
		
		public static function create(unsignedInteger:uint):JSUnsignedIntegerArgumentBuilder {
			const builder:JSUnsignedIntegerArgumentBuilder = new JSUnsignedIntegerArgumentBuilder();
			builder.unsignedInteger = unsignedInteger;
			builder.argument = ABCParameter.create(ABCMultinameBuiltin.UINT, "", unsignedInteger);
			return builder;
		}
		
		public function write(data:ByteArray):void {
			data.writeUTF(unsignedInteger.toString(10));
		}
		
		public function get argument():ABCParameter { return _argument; }
		public function set argument(value:ABCParameter) : void { _argument = value; }
		
		public function get name():String { return "JSUnsignedIntegerArgumentBuilder"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Value:";
			str += "\n" + StringUtils.repeat(indent + 5) + unsignedInteger.toString(10);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Argument:";
			str += "\n" + argument.toString(indent + 4);
			
			return str;
		}
	}
}
