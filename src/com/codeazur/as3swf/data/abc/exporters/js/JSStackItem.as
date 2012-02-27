package com.codeazur.as3swf.data.abc.exporters.js
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	import com.codeazur.utils.StringUtils;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSStackItem implements IABCWriteable {
		
		public var writeable:IABCWriteable;
		
		public function JSStackItem() {
		}
		
		public static function create(writeable:IABCWriteable):JSStackItem {
			const item:JSStackItem = new JSStackItem();
			item.writeable = writeable;
			return item;
		}
		
		public function write(data:ByteArray):void {
			writeable.write(data);
		}
		
		public function clone():JSStackItem {
			return JSStackItem.create(writeable);
		}
		
		public function get name():String { return "JSStackItem"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			if(writeable) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Writeable:";
				str += "\n" + writeable.toString(indent + 4);
			}
			
			return str;
		}
	}
}
