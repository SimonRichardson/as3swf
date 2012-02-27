package com.codeazur.as3swf.data.abc.exporters.js.builders.arguments
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedNameType;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;
	import com.codeazur.utils.StringUtils;
	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSStringArgumentBuilder implements IABCArgumentBuilder
	{
		
		public var string:String;
		
		private var _argument:ABCParameter;

		public function JSStringArgumentBuilder() {
		}
		
		public static function create(string:String):JSStringArgumentBuilder {
			const builder:JSStringArgumentBuilder = new JSStringArgumentBuilder();
			builder.string = string;
			builder.argument = ABCParameter.create(ABCQualifiedNameType.STRING.type, "", string);
			return builder;
		}
		
		public function write(data:ByteArray):void {
			JSTokenKind.DOUBLE_QUOTE.write(data);
			data.writeUTF(string);
			JSTokenKind.DOUBLE_QUOTE.write(data);
		}
		
		public function get argument():ABCParameter { return _argument; }
		public function set argument(value:ABCParameter) : void { _argument = value; }
		
		public function get name():String { return "JSStringArgumentBuilder"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Argument:";
			str += "\n" + argument.toString(indent + 4);
			
			return str;
		}
	}
}
