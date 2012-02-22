package com.codeazur.as3swf.data.abc.bytecode.attributes
{

	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeInt24Attribute extends ABCOpcodeAttribute implements IABCOpcodeIntegerAttribute {
		
		private var _integer:int;
		
		public function ABCOpcodeInt24Attribute(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCOpcodeInt24Attribute {
			return new ABCOpcodeInt24Attribute(abcData);
		}
		
		override public function read(data:SWFData):void {
			_integer = data.readSI24();
		}
		
		public function get integer():int { return _integer; }
		override public function get name():String { return "ABCOpcodeInt24Attribute"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Integer: ";
			str += "\n" + StringUtils.repeat(indent + 4) + integer;
			
			return str;
		}
	}
}
