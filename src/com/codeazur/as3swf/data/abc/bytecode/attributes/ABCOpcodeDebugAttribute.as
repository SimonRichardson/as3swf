package com.codeazur.as3swf.data.abc.bytecode.attributes
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeDebugAttribute extends ABCOpcodeAttribute {
		
		public var attributes:Vector.<uint>;
		
		public function ABCOpcodeDebugAttribute(abcData:ABCData) {
			super(abcData);
			
			attributes = new Vector.<uint>();
		}
		
		public static function create(abcData:ABCData):ABCOpcodeDebugAttribute {
			return new ABCOpcodeDebugAttribute(abcData);
		}
		
		override public function read(data:SWFData):void {
			attributes.push(data.readUI8());
			attributes.push(data.readEncodedU30());
			attributes.push(data.readUI8());
			attributes.push(data.readEncodedU30());
		}
		
		override public function write(bytes : SWFData) : void {
			bytes.writeUI8(attributes[0]);
			bytes.writeEncodedU32(attributes[1]);
			bytes.writeUI8(attributes[2]);
			bytes.writeEncodedU32(attributes[3]);
		}
		
		override public function get value():* { return attributes; }
		override public function get name():String { return "ABCOpcodeDebugAttribute"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Attributes: ";
			str += "\n" + StringUtils.repeat(indent + 4) + attributes;
			
			return str;
		}
	}
}
