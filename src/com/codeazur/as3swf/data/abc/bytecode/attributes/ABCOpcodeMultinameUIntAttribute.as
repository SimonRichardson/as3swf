package com.codeazur.as3swf.data.abc.bytecode.attributes
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeMultinameUIntAttribute extends ABCOpcodeAttribute {
		
		public var multiname:IABCMultiname;
		public var numArguments:uint;
		
		public function ABCOpcodeMultinameUIntAttribute(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCOpcodeMultinameUIntAttribute {
			return new ABCOpcodeMultinameUIntAttribute(abcData);
		}
		
		override public function read(data:SWFData):void {
			const index:uint = data.readEncodedU30();
			multiname = getMultinameByIndex(index);
			numArguments = data.readEncodedU30();
		}
		
		override public function write(bytes : SWFData) : void {
			bytes.writeEncodedU32(getMultinameIndex(multiname));
			bytes.writeEncodedU32(numArguments);
		}
		
		override public function get value():* { return multiname; }
		override public function get name():String { return "ABCOpcodeMultinameUIntAttribute"; }
		
		override public function toString(indent:uint=0):String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Multiname: ";
			str += "\n" + multiname.toString(indent + 4);
			str += "\n" + StringUtils.repeat(indent + 2) + "NumArguments: " + numArguments;
			
			return str;
		}
	}
}
