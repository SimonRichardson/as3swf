package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSStack implements IABCWriteable {
		
		private static const EMPTY:JSStackItem = new JSStackItem();
		
		private var _stack:Vector.<JSStackItem>;
				
		public function JSStack() {
			_stack = new Vector.<JSStackItem>();
		}
		
		public function add(writeable:IABCWriteable, terminator:Boolean = false):JSStackItem {
			const item:JSStackItem = JSStackItem.create(writeable, terminator);
			
			_stack.push(item);
			
			return item;
		}
		
		public function getAt(index:uint):JSStackItem {
			return _stack[index];
		}
		
		public function removeAt(index:uint):JSStackItem {
			const items:Vector.<JSStackItem> = _stack.splice(index, 1);
			return items[0];
		}
		
		public function pop():JSStackItem {
			return _stack.pop();
		}
		
		public function write(data:ByteArray):void {
			const total:uint = _stack.length;
			for(var i:uint=0; i<total; i++) {
				_stack[i].write(data);
			}
		}
		
		public function describe():String {
			var result:String = "";
			const total:uint = _stack.length;
			for(var i:uint=0; i<total; i++) {
				result += _stack[i].writeable.name;
				if(i < total - 1) {
					result += ", ";
				}
			}
			return result;
		}
		
		public function get length():uint {
			return _stack.length;
		}
		
		public function get tail():JSStackItem {
			var item:JSStackItem;
			if(_stack.length < 1) {
				item = EMPTY;
			} else {
				item = _stack[_stack.length - 1];
			}
			return item;
		}
		
		public function get name():String { return "JSStack"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
