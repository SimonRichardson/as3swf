package com.codeazur.as3swf.data.abc.bytecode.attributes
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeUnsignedByteAttribute extends ABCOpcodeAttribute implements IABCOpcodeUnsignedIntegerAttribute {
		
		private var _unsignedInteger:uint;
		
		public function ABCOpcodeUnsignedByteAttribute(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCOpcodeUnsignedByteAttribute {
			return new ABCOpcodeUnsignedByteAttribute(abcData);
		}
		
		override public function read(data:SWFData):void {
			_unsignedInteger = data.readUnsignedByte();
		}
		
		override public function write(bytes : SWFData) : void {
			bytes.writeByte(unsignedInteger);
		}
		
		public function get unsignedInteger():uint { return _unsignedInteger; }
		
		override public function get value():* { return _unsignedInteger; }
		override public function get name():String { return "ABCOpcodeUnsignedByteAttribute"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "UnsignedInteger: ";
			str += "\n" + StringUtils.repeat(indent + 4) + unsignedInteger;
			
			return str;
		}
	}
}
