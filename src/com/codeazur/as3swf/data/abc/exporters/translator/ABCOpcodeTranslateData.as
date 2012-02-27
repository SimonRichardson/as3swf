package com.codeazur.as3swf.data.abc.exporters.translator
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeTranslateData {
		
		private var _items:Vector.<Vector.<ABCOpcode>>;
		
		public function ABCOpcodeTranslateData() {
			_items = new Vector.<Vector.<ABCOpcode>>();
		}
		
		public static function create():ABCOpcodeTranslateData {
			const instance:ABCOpcodeTranslateData = new ABCOpcodeTranslateData();
			return instance;
		}
		
		public function add(items:Vector.<ABCOpcode>):void {
			_items.push(items);
		}
		
		public function getAt(index:uint):Vector.<ABCOpcode> {
			return _items[index];
		}
		
		public function pop() : Vector.<ABCOpcode> {
			return _items.pop();
		}
		
		public function get length():uint {
			return _items.length;
		}
		
		public function get name():String { return "ABCOpcodeTranslateData"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
