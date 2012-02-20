package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSScope {
		
		private var _scope:Vector.<JSStackItem>;
		private var _expressions:Vector.<IABCWriteable>;
				
		public function JSScope() {
			_scope = new Vector.<JSStackItem>();
			_expressions = new Vector.<IABCWriteable>();
		}
		
		public function add(item:JSStackItem):void {
			_scope.push(item);
			_expressions.push(item.writeable);
		}
		
		public function reset():void {
			_scope.length = 0;
			_expressions.length = 0;
		}
		
		public function get expressions():Vector.<IABCWriteable> {
			return _expressions;
		}
		
		public function get length():uint {
			return _scope.length;
		}
		
		public function get tail():JSStackItem {
			return _scope[_scope.length - 1];
		}
		
		public function get name():String { return "JSScope"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
