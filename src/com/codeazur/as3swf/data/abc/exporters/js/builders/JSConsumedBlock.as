package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSConsumedBlock implements IABCWriteable {
		
		public var left:IABCWriteable;
		public var right:IABCWriteable;
		
		public var terminator:Boolean;
		
		public function JSConsumedBlock(){
			terminator = true;
		}

		public static function create(left:IABCWriteable, right:IABCWriteable = null):JSConsumedBlock {
			const block:JSConsumedBlock = new JSConsumedBlock();
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
		
		protected function get hasTerminator():Boolean {
			terminator = !(right is JSConsumedBlock && JSConsumedBlock(right).terminator);
			return terminator;
		}
		
		public function get name():String { return "JSConsumedBlock"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
