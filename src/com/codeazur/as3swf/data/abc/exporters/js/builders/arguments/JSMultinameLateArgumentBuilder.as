package com.codeazur.as3swf.data.abc.exporters.js.builders.arguments
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMultinameLateAttributeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSValueBuilder;
	import com.codeazur.utils.StringUtils;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMultinameLateArgumentBuilder implements IABCMultinameLateAttributeBuilder {
		
		private var _multiname:IABCMultiname;
		private var _argument:ABCParameter;
		
		private var _value:IABCValueBuilder;
		
		public function JSMultinameLateArgumentBuilder() {
			_value = new JSValueBuilder();
		}
		
		public static function create(multiname:IABCMultiname):JSMultinameLateArgumentBuilder {
			const builder:JSMultinameLateArgumentBuilder = new JSMultinameLateArgumentBuilder();
			builder.multiname = multiname;
			builder.argument = ABCParameter.create(multiname);
			return builder;
		}
		
		public function write(data:ByteArray):void {
			JSTokenKind.LEFT_SQUARE_BRACKET.write(data);
			_value.write(data);
			JSTokenKind.RIGHT_SQUARE_BRACKET.write(data);
		}
		
		public function get multiname():IABCMultiname { return _multiname; }
		public function set multiname(value:IABCMultiname):void { _multiname = value; }
		
		public function get argument():ABCParameter { return _argument; }
		public function set argument(value:ABCParameter) : void { 
			_argument = value;
			
			_value.value = _argument.defaultValue;
			_value.qname = _argument.qname;
		}
		
		public function get name():String { return "JSMultinameLateArgumentBuilder"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Argument:";
			str += "\n" + argument.toString(indent + 4);
			
			return str;
		}
	}
}
