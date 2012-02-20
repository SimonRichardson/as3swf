package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCDebugBuilder;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSStack implements IABCWriteable {
		
		private var _stack:Vector.<JSStackItem>;
				
		public function JSStack() {
			_stack = new Vector.<JSStackItem>();
		}
		
		public function add(writeable:IABCWriteable, debug:IABCDebugBuilder = null):void {
			_stack.push(JSStackItem.create(writeable, debug));
		}
		
		public function getAt(index:uint):JSStackItem {
			return _stack[index];
		}
		
		public function pop():void {
			_stack.pop();
		}
		
		public function write(data:ByteArray):void {
			const total:uint = _stack.length;
			for(var i:uint=0; i<total; i++) {
				_stack[i].write(data);
			}
		}
		
		public function get length():uint {
			return _stack.length;
		}
		
		public function get tail():JSStackItem {
			return _stack[_stack.length - 1];
		}
		
		public function get name():String { return "JSStack"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
