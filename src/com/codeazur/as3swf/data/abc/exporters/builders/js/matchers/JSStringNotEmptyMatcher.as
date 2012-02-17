package com.codeazur.as3swf.data.abc.exporters.builders.js.matchers
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedNameType;
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCAccessorBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMatcher;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSAccessorBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSOperatorKind;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSReservedKind;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSTokenKind;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSValueBuilder;

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
			const builder:IABCAccessorBuilder = JSAccessorBuilder.create(value, length);
			builder.write(data);
			
			JSOperatorKind.GREATER_THAN.write(data);
			
			data.writeUTF('0');
		}

		public function get value():IABCValueBuilder { return _value; }
		public function set value(data:IABCValueBuilder):void { _value = data; }
		
		public function get name():String { return "JSStringNotEmptyMatcher"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
