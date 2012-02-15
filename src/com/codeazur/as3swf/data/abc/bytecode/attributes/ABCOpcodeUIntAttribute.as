package com.codeazur.as3swf.data.abc.bytecode.attributes
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeUIntAttribute extends ABCOpcodeAttribute {
		
		public var uinsignedInteger:uint;
		
		public function ABCOpcodeUIntAttribute(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCOpcodeUIntAttribute {
			return new ABCOpcodeUIntAttribute(abcData);
		}
		
		override public function read(data:SWFData):void {
			uinsignedInteger = data.readEncodedU30();
		}
		
		override public function get name():String { return "ABCOpcodeUIntAttribute"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "UnsignedInteger: ";
			str += "\n" + StringUtils.repeat(indent + 4) + uinsignedInteger;
			
			return str;
		}
	}
}
