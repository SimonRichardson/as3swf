package com.codeazur.as3swf.data.abc.bytecode.attributes
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeMultinameAttribute extends ABCOpcodeAttribute {
		
		public var multiname:IABCMultiname;
		
		public function ABCOpcodeMultinameAttribute(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCOpcodeMultinameAttribute {
			return new ABCOpcodeMultinameAttribute(abcData);
		}
		
		override public function read(data:SWFData):void {
			const index:uint = data.readEncodedU30();
			multiname = getMultinameByIndex(index);
		}
		
		override public function write(bytes : SWFData) : void {
			bytes.writeEncodedU32(getMultinameIndex(multiname));
		}
		
		override public function get name():String { return "ABCOpcodeMultinameAttribute"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Multiname: ";
			str += "\n" + multiname.toString(indent + 4);
			
			return str;
		}
	}
}
