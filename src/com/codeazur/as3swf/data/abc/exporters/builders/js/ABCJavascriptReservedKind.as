package com.codeazur.as3swf.data.abc.exporters.builders.js
{

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCJavascriptReservedKind {
		
		public static const FUNCTION:ABCJavascriptReservedKind = new ABCJavascriptReservedKind(FUNCTION_NAME);
		
		private static const FUNCTION_NAME:String = "function";
		
		private var _type:String;
		
		public function ABCJavascriptReservedKind(type:String) {
			_type = type;
		}
		
		public function write(data:ByteArray):void {
			data.writeUTF(type);
		}
		
		public function get type():String { return _type; }
	}
}
