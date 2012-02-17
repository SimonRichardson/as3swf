package com.codeazur.as3swf.data.abc.exporters.builders.js.matchers
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMatcher;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSReservedKind;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSTokenKind;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSNullMatcher implements IABCMatcher {

		private var _value:IABCValueBuilder;

		public function JSNullMatcher() {
		}
		
		public static function create(value:IABCValueBuilder):JSNullMatcher {
			const matcher:JSNullMatcher = new JSNullMatcher();
			matcher.value = value;
			return matcher;
		}

		public function write(data:ByteArray):void {
			value.write(data);
			
			JSTokenKind.EQUALS.write(data);
			JSTokenKind.EQUALS.write(data);
			
			JSReservedKind.NULL.write(data);
		}

		public function get value():IABCValueBuilder { return _value; }
		public function set value(data:IABCValueBuilder):void { _value = data; }
		
		public function get name():String { return "JSNullMatcher"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}