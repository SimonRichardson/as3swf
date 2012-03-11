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
	public class JSNumberArgumentBuilder implements IABCAttributeBuilder
	{
		
		public var float:Number;
		
		private var _argument:ABCParameter;

		public function JSNumberArgumentBuilder() {
		}
		
		public static function create(float:Number):JSNumberArgumentBuilder {
			const builder:JSNumberArgumentBuilder = new JSNumberArgumentBuilder();
			builder.float = float;
			builder.argument = ABCParameter.create(ABCMultinameBuiltin.NUMBER, "", float);
			return builder;
		}
		
		public function write(data:ByteArray):void {
			data.writeUTF(float.toString(10));
		}
		
		public function get argument():ABCParameter { return _argument; }
		public function set argument(value:ABCParameter) : void { _argument = value; }
		
		public function get name():String { return "JSNumberArgumentBuilder"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Argument:";
			str += "\n" + argument.toString(indent + 4);
			
			return str;
		}
	}
}
