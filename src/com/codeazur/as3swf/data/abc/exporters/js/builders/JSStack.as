package com.codeazur.as3swf.data.abc.exporters.js.builders
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	import com.codeazur.utils.StringUtils;
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;


	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSStack implements IABCWriteable {
		
		private static const OPTION:JSConsumableBlock = new JSConsumableBlock();
		
		private var _stack:Vector.<JSConsumableBlock>;
				
		public function JSStack() {
			_stack = new Vector.<JSConsumableBlock>();
		}
		
		public static function create():JSStack {
			return new JSStack();
		}
		
		public function add(left:IABCWriteable, right:IABCWriteable=null):JSConsumableBlock {
			return addAt(left, right, length);
		}
		
		public function addAt(left:IABCWriteable, right:IABCWriteable=null, index:int=int.MAX_VALUE):JSConsumableBlock {
			const stackItem:JSConsumableBlock = JSConsumableBlock.create(left, right);
			
			if(index == _stack.length || index == int.MAX_VALUE) {
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
		
		public function getAt(index:uint):JSConsumableBlock {
			return _stack[index];
		}
		
		public function removeAt(index:uint):JSConsumableBlock {
			const items:Vector.<JSConsumableBlock> = _stack.splice(index, 1);
			return items[0];
		}
		
		public function pop():JSConsumableBlock {
			return _stack.pop();
		}
		
		public function write(data:ByteArray):void {
			const total:uint = _stack.length;
			for(var i:uint=0; i<total; i++) {
				const item:JSConsumableBlock = _stack[i];	
				item.write(data);
			}
		}
				
		public function get length():uint {
			return _stack.length;
		}
		
		public function get tail():JSConsumableBlock {
			var item:JSConsumableBlock;
			if(_stack.length < 1) {
				item = OPTION;
			} else {
				item = _stack[_stack.length - 1];
			}
			return item;
		}
		
		public function get name():String { return "JSStack"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			if(_stack.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Stack:";
				for(var i:uint=0; i<_stack.length; i++) {
					str += "\n" + _stack[i].toString(indent + 4);
				}
			}
			
			return str;
		}
	}
}
