package com.codeazur.as3swf.data.abc.bytecode.attributes
{

	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeHasNext2Attribute extends ABCOpcodeAttribute {
		
		private var _integer0:int;
		private var _integer1:int;
		
		public function ABCOpcodeHasNext2Attribute(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCOpcodeHasNext2Attribute {
			return new ABCOpcodeHasNext2Attribute(abcData);
		}
		
		override public function read(data:SWFData):void {
			_integer0 = data.readEncodedU30();
			_integer1 = data.readEncodedU30();
		}
		
		override public function write(bytes : SWFData) : void {
			bytes.writeEncodedU32(integer0);
			bytes.writeEncodedU32(integer1);
		}
		
		public function get integer0():int { return _integer0; }
		public function get integer1():int { return _integer1; }
		
		override public function get value():* { return _integer0; }
		override public function get name():String { return "ABCOpcodeIntegerAttribute"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Integer0: ";
			str += "\n" + StringUtils.repeat(indent + 4) + integer0;
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Integer1: ";
			str += "\n" + StringUtils.repeat(indent + 4) + integer1;
			
			return str;
		}
	}
}
