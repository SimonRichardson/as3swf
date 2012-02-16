package com.codeazur.as3swf.data.abc.exporters.builders.js
{

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSReservedKind {
		
		public static const FUNCTION:JSReservedKind = new JSReservedKind(FUNCTION_NAME);
		public static const NULL:JSReservedKind = new JSReservedKind(NULL_NAME);
		public static const THIS:JSReservedKind = new JSReservedKind(THIS_NAME);
		public static const VAR:JSReservedKind = new JSReservedKind(VAR_NAME);
		
		private static const FUNCTION_NAME:String = "function";
		private static const NULL_NAME:String = "null";
		private static const THIS_NAME:String = "this";
		private static const VAR_NAME:String = "var";
		
		private var _type:String;
		
		public function JSReservedKind(type:String) {
			_type = type;
		}
		
		public function write(data:ByteArray):void {
			data.writeUTF(type);
		}
		
		public function get type():String { return _type; }
	}
}
