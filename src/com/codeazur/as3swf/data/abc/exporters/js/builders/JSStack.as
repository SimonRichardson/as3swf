package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSStack extends JSStackItem implements IABCWriteable {
		
		private static const OPTION:JSStackItem = new JSStackItem();
		
		private var _stack:Vector.<JSStackItem>;
				
		public function JSStack() {
			_stack = new Vector.<JSStackItem>();
		}
		
		public function add(item:JSStackItem):void {
			_stack.push(item);
		}
		
		public function addAt(item:JSStackItem, index:uint):void {
			_stack.splice(index, 0, item);
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
		
		override public function write(data:ByteArray):void {
			const total:uint = _stack.length;
			for(var i:uint=0; i<total; i++) {
				_stack[i].write(data);
			}
			
			JSTokenKind.SEMI_COLON.write(data);
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
				item = OPTION;
			} else {
				item = _stack[_stack.length - 1];
			}
			return item;
		}
		
		override public function get name():String { return "JSStack"; }
		
		override public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
