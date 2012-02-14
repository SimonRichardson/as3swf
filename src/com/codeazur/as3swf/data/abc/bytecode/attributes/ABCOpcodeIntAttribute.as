package com.codeazur.as3swf.data.abc.bytecode.attributes
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeIntAttribute extends ABCOpcodeAttribute {
		
		public var integer:int;
		
		public function ABCOpcodeIntAttribute(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCOpcodeIntAttribute {
			return new ABCOpcodeIntAttribute(abcData);
		}
		
		override public function parse(data:SWFData):void {
			integer = data.readEncodedU30();
		}
		
		override public function get name():String { return "ABCOpcodeIntAttribute"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Integer: ";
			str += "\n" + StringUtils.repeat(indent + 4) + integer;
			
			return str;
		}
	}
}
