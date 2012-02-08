package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCInstanceInfoSet extends ABCSet {
		
		
		public function ABCInstanceInfoSet(abcData:ABCData) {
			super(abcData);
		}
		
		override public function parse(data : SWFData) : void {
			
		}
		
		override public function get name() : String { return "ABCInstanceInfoSet"; }
		
		override public function toString(indent : uint = 0) : String
		{
			var str:String = super.toString(indent);
			
			return str;
		}
	}
}
