package com.codeazur.as3swf.data.abc.exporters.translator
{

	import com.codeazur.utils.StringUtils;
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
			if(items && items.length > 0) {
				_items.push(items);
			}
		}
		
		public function getAt(index:uint):Vector.<ABCOpcode> {
			return _items[index];
		}
		
		public function pop() : Vector.<ABCOpcode> {
			return _items.pop();
		}
		
		public function get tail():Vector.<ABCOpcode> { return _items.length > 0 ? _items[_items.length - 1] : null; }
		public function get length():uint { return _items.length; }
		
		public function get name():String { return "ABCOpcodeTranslateData"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Data:";
			for(var i:uint=0; i<_items.length; i++) {
				str += "\n" + StringUtils.repeat(indent + 4) + "Block:";
				for(var j:uint=0; j<_items[i].length; j++) {
					str += "\n" + _items[i][j].kind.toString(indent + 6);
				}
			}
			
			return str;
		}
	}
}
