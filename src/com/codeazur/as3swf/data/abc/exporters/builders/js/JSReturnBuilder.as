package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCBuilder;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSReturnBuilder implements IABCBuilder
	{
		public var useSpace:Boolean;
		
		public function JSReturnBuilder() {
			useSpace = true;
		}
		
		public static function create():JSReturnBuilder {
			return new JSReturnBuilder();
		}

		public function write(data : ByteArray) : void {
			JSReservedKind.RETURN.write(data);
			
			if(useSpace) {
				JSTokenKind.SPACE.write(data);
			}
		}
		
		public function get name():String { return "JSReturnBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
