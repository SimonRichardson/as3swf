package com.codeazur.as3swf.data.abc.exporters.js.builders.matchers
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCNameBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMatcher;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSNameBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSOperatorKind;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSReservedKind;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSValueBuilder;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	import com.codeazur.utils.StringUtils;

	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSStringNotEmptyMatcher implements IABCMatcher {

		private var _value:IABCValueBuilder;

		public function JSStringNotEmptyMatcher() {
		}
		
		public static function create(value:IABCValueBuilder):JSStringNotEmptyMatcher {
			const matcher:JSStringNotEmptyMatcher = new JSStringNotEmptyMatcher();
			matcher.value = value;
			return matcher;
		}

		public function write(data:ByteArray):void {
			// value != null
			value.write(data);
			
			JSTokenKind.EXCLAMATION_MARK.write(data);
			JSTokenKind.EQUALS.write(data);
			
			JSReservedKind.NULL.write(data);
			
			// &&
			JSOperatorKind.LOGICAL_AND.write(data);
			
			// value.length > 0
			const length:IABCValueBuilder = JSValueBuilder.create('length');
			const stack:Vector.<IABCWriteable> = new <IABCWriteable>[value, length];
			const builder:IABCNameBuilder = JSNameBuilder.create(stack);
			builder.write(data);
			
			JSOperatorKind.GREATER_THAN.write(data);
			
			data.writeUTF('0');
		}

		public function get value():IABCValueBuilder { return _value; }
		public function set value(data:IABCValueBuilder):void { _value = data; }
		
		public function get name():String { return "JSStringNotEmptyMatcher"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Value:";
			str += "\n" + value.toString(indent + 4);
						
			return str;
		}
	}
}
