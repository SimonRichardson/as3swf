package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCIfStatementBuilder;
	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSIfStatementBuilder implements IABCIfStatementBuilder {

		public var writeable:IABCWriteable;

		public function JSIfStatementBuilder() {
		}
		
		public static function create(writeable:IABCWriteable):JSIfStatementBuilder {
			const builder:JSIfStatementBuilder = new JSIfStatementBuilder();
			builder.writeable = writeable;
			return builder;
		}

		public function write(data : ByteArray) : void {
			JSReservedKind.IF.write(data);
			JSTokenKind.LEFT_PARENTHESES.write(data);
			
			writeable.write(data);
			
			JSTokenKind.RIGHT_PARENTHESES.write(data);
			JSTokenKind.LEFT_CURLY_BRACKET.write(data);
		}

		public function get name() : String { return "JSIfStatementBuilder"; }
		
		public function toString(indent : uint = 0) : String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
