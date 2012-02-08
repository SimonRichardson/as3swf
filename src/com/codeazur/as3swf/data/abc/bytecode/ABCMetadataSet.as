package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCMetadataSet extends ABCSet {

		public function ABCMetadataSet(abcData : ABCData) {
			super(abcData);
		}
		
		override public function parse(data : SWFData) : void {
			
		}
		
		override public function get name():String { return "ABCMetadataSet"; }
		
		public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
			return str;
		}
	}
}
