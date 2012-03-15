package com.codeazur.as3swf.data.abc.bytecode.attributes
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeDoubleAttribute extends ABCOpcodeAttribute {
		
		public var double:Number;
		
		public function ABCOpcodeDoubleAttribute(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCOpcodeDoubleAttribute {
			return new ABCOpcodeDoubleAttribute(abcData);
		}
		
		override public function read(data:SWFData):void {
			const index:uint = data.readEncodedU30();
			double = getDoubleByIndex(index);
		}
		
		override public function write(bytes : SWFData) : void {
			bytes.writeEncodedU32(getDoubleIndex(double));
		}
		
		override public function get name():String { return "ABCOpcodeDoubleAttribute"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Double: ";
			str += "\n" + StringUtils.repeat(indent + 4) + double;
			
			return str;
		}
	}
}
