package com.codeazur.as3swf.data.abc.bytecode.attributes
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeStringAttribute extends ABCOpcodeAttribute {
		
		public var string:String;
		
		public function ABCOpcodeStringAttribute(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCOpcodeStringAttribute {
			return new ABCOpcodeStringAttribute(abcData);
		}
		
		override public function read(data:SWFData):void {
			const index:uint = data.readEncodedU30();
			string = getStringByIndex(index);
		}
		
		override public function get name():String { return "ABCOpcodeStringAttribute"; }
		
		override public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "String: ";
			str += "\n" + StringUtils.repeat(indent + 4) + string;
			
			return str;
		}
	}
}
