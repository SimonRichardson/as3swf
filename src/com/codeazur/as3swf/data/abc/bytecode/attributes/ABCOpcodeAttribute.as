package com.codeazur.as3swf.data.abc.bytecode.attributes
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeAttribute extends ABCSet {
		
		public function ABCOpcodeAttribute(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCOpcodeAttribute {
			return new ABCOpcodeAttribute(abcData);
		}
		
		public function parse(data:SWFData):void {
			
		}
		
		override public function get name():String { return "ABCOpcodeAttribute"; }
		
		override public function toString(indent:uint=0):String {
			return super.toString(indent);
		}
	}
}
