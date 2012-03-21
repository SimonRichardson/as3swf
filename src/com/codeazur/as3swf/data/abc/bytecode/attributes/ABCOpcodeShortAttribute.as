package com.codeazur.as3swf.data.abc.bytecode.attributes
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeShortAttribute extends ABCOpcodeAttribute implements IABCOpcodeIntegerAttribute {
		
		private var _integer:int;
		
		public function ABCOpcodeShortAttribute(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCOpcodeIntegerAttribute {
			return new ABCOpcodeIntegerAttribute(abcData);
		}
		
		override public function read(data:SWFData):void {
			_integer = data.readEncodedU30();
		}
		
		override public function write(bytes : SWFData) : void {
			bytes.writeEncodedU32(uint(integer));
		}
		
		public function get integer():int { return _integer; }
		override public function get name():String { return "ABCOpcodeShortAttribute"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Integer: ";
			str += "\n" + StringUtils.repeat(indent + 4) + integer;
			
			return str;
		}
	}
}
