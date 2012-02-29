package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCConsumableBlock;
	import com.codeazur.utils.StringUtils;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSConsumableBlock implements IABCConsumableBlock {
		
		private var _left:IABCWriteable;
		private var _right:IABCWriteable;
		
		public var terminator:Boolean;
		
		public function JSConsumableBlock(){
			terminator = false;
		}

		public static function create(left:IABCWriteable, right:IABCWriteable = null):JSConsumableBlock {
			const block:JSConsumableBlock = new JSConsumableBlock();
			block.left = left;
			block.right = right;
			return block; 
		}
		
		public function write(data:ByteArray):void {
			left.write(data);
			
			if(right) {
				JSTokenKind.DOT.write(data);
				right.write(data);
			}
			
			if(hasTerminator) {
				JSTokenKind.SEMI_COLON.write(data);
			}
		}
		
		protected function get hasTerminator():Boolean { return terminator; }
		
		public function get left() : IABCWriteable { return _left; }
		public function set left(value : IABCWriteable) : void { _left = value; }

		public function get right() : IABCWriteable { return _right; }
		public function set right(value : IABCWriteable) : void { _right = value; }
		
		public function get name():String { return "JSConsumableBlock"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Left:";
			str += "\n" + left.toString(indent + 4);
			
			if(right) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Right:";
				str += "\n" + right.toString(indent + 4);
			}
			
			return str;
		}
	}
}
