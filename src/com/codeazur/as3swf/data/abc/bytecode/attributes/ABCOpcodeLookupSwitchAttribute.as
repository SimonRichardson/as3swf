package com.codeazur.as3swf.data.abc.bytecode.attributes
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeLookupSwitchAttribute extends ABCOpcodeAttribute {
		
		public var defaultOffset:int;
		public var offsets:Vector.<int>;
		
		public function ABCOpcodeLookupSwitchAttribute(abcData:ABCData) {
			super(abcData);
			
			offsets = new Vector.<int>();
		}
		
		public static function create(abcData:ABCData):ABCOpcodeLookupSwitchAttribute {
			return new ABCOpcodeLookupSwitchAttribute(abcData);
		}
		
		override public function read(data:SWFData):void {
			defaultOffset = data.readSI24();
			
			const total:uint = data.readEncodedU30();
			for(var i:uint=0; i<total; i++) {
				offsets.push(data.readSI24());
			}
		}
		
		override public function write(bytes : SWFData) : void {
			bytes.writeSI24(defaultOffset);
			
			const total:uint = offsets.length;
			for(var i:uint=0; i<total; i++) {
				bytes.writeSI24(offsets[i]);
			}
		}
		
		override public function get value():* { return defaultOffset; }
		override public function get name():String { return "ABCOpcodeLookupSwitchAttribute"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "DefaultOffset: ";
			str += "\n" + StringUtils.repeat(indent + 4) + defaultOffset;
			str += "\n" + StringUtils.repeat(indent + 2) + "Offsets: ";
			str += "\n" + StringUtils.repeat(indent + 4) + offsets;
			
			return str;
		}
	}
}
