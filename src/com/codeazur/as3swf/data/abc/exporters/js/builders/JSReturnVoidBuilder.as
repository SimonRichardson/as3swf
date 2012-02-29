package com.codeazur.as3swf.data.abc.exporters.js.builders
{

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSReturnVoidBuilder extends JSReturnBuilder
	{

		public static function create():JSReturnVoidBuilder {
			return new JSReturnVoidBuilder();
		}

		override public function write(data : ByteArray) : void {
			JSReservedKind.RETURN.write(data);
		}

		override public function get name():String { return "JSReturnVoidBuilder"; }
	}
}
