package com.codeazur.as3swf.data.abc.exporters.builders.js.parameters
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedNameType;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCParameterBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSTokenKind;
	import com.codeazur.utils.StringUtils;
	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSStringParameterBuilder implements IABCParameterBuilder
	{
		
		public var string:String;
		
		private var _parameter:ABCParameter;

		public function JSStringParameterBuilder() {
		}
		
		public static function create(string:String):JSStringParameterBuilder {
			const builder:JSStringParameterBuilder = new JSStringParameterBuilder();
			builder.string = string;
			builder.parameter = ABCParameter.create(ABCQualifiedNameType.STRING.type, string);
			return builder;
		}
		
		public function write(data:ByteArray):void {
			JSTokenKind.DOUBLE_QUOTE.write(data);
			data.writeUTF(string);
			JSTokenKind.DOUBLE_QUOTE.write(data);
		}
		
		public function get parameter():ABCParameter { return _parameter; }
		public function set parameter(value:ABCParameter) : void { _parameter = value; }
		
		public function get name():String { return "JSStringParameterBuilder"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Parameter:";
			str += "\n" + parameter.toString(indent + 4);
			
			return str;
		}
	}
}
