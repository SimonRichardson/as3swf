package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCBuilder;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSReturnVoidBuilder implements IABCBuilder
	{

		public function JSReturnVoidBuilder() {
		}
		
		public static function create():JSReturnVoidBuilder {
			return new JSReturnVoidBuilder();
		}

		public function write(data : ByteArray) : void {
			JSReservedKind.RETURN.write(data);
		 	JSTokenKind.SEMI_COLON.write(data);
		}
		
		public function get name():String { return "JSReturnVoidBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
