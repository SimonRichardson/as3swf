package com.codeazur.as3swf.data.abc.exporters.js.builders.matchers
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMatcher;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSReservedKind;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;
	import com.codeazur.utils.StringUtils;

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
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Value:";
			str += "\n" + value.toString(indent + 4);
						
			return str;
		}
	}
}
