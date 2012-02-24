package com.codeazur.as3swf.data.abc.exporters.js
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.errors.IllegalOperationError;
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
		
		public static function create():JSStack {
			return new JSStack();
		}
		
		public function add(item:IABCWriteable):JSStackItem {
			return addAt(item, length);
		}
		
		public function addAt(item:IABCWriteable, index:uint):JSStackItem {
			const stackItem:JSStackItem = JSStackItem.create(item);
			
			if(index == _stack.length) {
				_stack.push(stackItem);
			} else if(index < _stack.length){
				_stack.splice(index, 0, stackItem);
			} else if(index < 0 || index > _stack.length) {
				throw new ArgumentError("Index is out of bounds (index:" + index + ")");
			} else {
				throw new IllegalOperationError();
			}
			
			return stackItem;
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
				const item:JSStackItem = _stack[i];	
				item.write(data);
			}
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
