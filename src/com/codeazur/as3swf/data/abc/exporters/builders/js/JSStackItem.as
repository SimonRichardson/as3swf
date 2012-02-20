package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCDebugBuilder;
	import flash.utils.ByteArray;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSStackItem implements IABCWriteable {
		
		public var writeable:IABCWriteable;
		public var debug:IABCDebugBuilder;
		public var terminator:Boolean;
		
		public function JSStackItem() {
			terminator = false;
		}
		
		public static function create(writeable:IABCWriteable, debug:IABCDebugBuilder = null):JSStackItem {
			const item:JSStackItem = new JSStackItem();
			item.writeable = writeable;
			item.debug = debug;
			return item;
		}
		
		public function write(data:ByteArray):void {
			writeable.write(data);
			
			if(terminator) {
				JSTokenKind.SEMI_COLON.write(data);
			}
			
			if(debug) {
				debug.write(data);
			}
		}
		
		public function get hasDebug():Boolean { return debug != null; }
		public function get name():String { return "JSStackItem"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
