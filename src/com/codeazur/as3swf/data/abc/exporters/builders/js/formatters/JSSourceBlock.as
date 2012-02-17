package com.codeazur.as3swf.data.abc.exporters.builders.js.formatters
{
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSSourceBlock {
	
		private static const SOME:JSSourceBlock = new JSSourceBlock("");
		
		private var _tokens:Vector.<JSSourceBlock>;
		
		public var value:String;
		public var indent:uint;
		public var parent:JSSourceBlock;
		
		public function JSSourceBlock(value:String)
		{
			this.value = value;
		}
		
		public function add(value:String, indent:uint=0):JSSourceBlock {
			const block:JSSourceBlock = new JSSourceBlock(value);
			block.indent = indent;
			
			if(null == _tokens) {
				_tokens = new Vector.<JSSourceBlock>();
			}
			
			_tokens.push(block);
			
			return block;
		}
		
		public function pop():void {
			if(null != _tokens) _tokens.pop();
		}
		
		public function get tail():JSSourceBlock {
			if(null == _tokens || _tokens.length == 0) return SOME;
			else return _tokens[_tokens.length - 1];
		}
	
		public function toString():String {
			var result:String = "";
			
			result += value;
			result += StringUtils.repeat(indent);
			
			if(null != _tokens) {
				const total:uint = _tokens.length;
				for(var i:uint=0; i<total; i++) {
					const token:JSSourceBlock = _tokens[i];
					result += token.toString();
				}
			}
			
			return result;
		}
	}
}
