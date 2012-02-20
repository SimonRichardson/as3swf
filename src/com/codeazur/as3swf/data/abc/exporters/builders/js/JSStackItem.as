package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCDebugBuilder;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSStackItem implements IABCWriteable {
		
		public var writeable:IABCWriteable;
		public var terminator:Boolean;
		
		public function JSStackItem() {
			terminator = false;
		}
		
		public static function create(writeable:IABCWriteable, terminator:Boolean = false):JSStackItem {
			const item:JSStackItem = new JSStackItem();
			item.writeable = writeable;
			item.terminator = terminator;
			return item;
		}
		
		public function write(data:ByteArray):void {
			writeable.write(data);
			
			if(terminator && !(writeable is IABCDebugBuilder)) {
				JSTokenKind.SEMI_COLON.write(data);
			}
		}
		
		public function get name():String { return "JSStackItem"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
