package com.codeazur.as3swf.data.abc.exporters.builders.js.matchers
{

	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSReservedKind;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSTokenKind;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMatcher;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSNotNullMatcher implements IABCMatcher {

		private var _value:IABCValueBuilder;

		public function JSNotNullMatcher() {
		}
		
		public static function create(value:IABCValueBuilder):JSNotNullMatcher {
			const matcher:JSNotNullMatcher = new JSNotNullMatcher();
			matcher.value = value;
			return matcher;
		}

		public function write(data:ByteArray):void {
			value.write(data);
			
			JSTokenKind.EXCLAMATION_MARK.write(data);
			JSTokenKind.EQUALS.write(data);
			
			JSReservedKind.NULL.write(data);
		}

		public function get value():IABCValueBuilder { return _value; }
		public function set value(data:IABCValueBuilder):void { _value = data; }
		
		public function get name():String { return "JSNotNullMatcher"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
