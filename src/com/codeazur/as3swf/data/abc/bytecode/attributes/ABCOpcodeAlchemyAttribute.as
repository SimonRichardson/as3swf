package com.codeazur.as3swf.data.abc.bytecode.attributes
{

	import com.codeazur.as3swf.data.abc.ABCData;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeAlchemyAttribute extends ABCOpcodeAttribute {
		
		public function ABCOpcodeAlchemyAttribute(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCOpcodeAlchemyAttribute {
			return new ABCOpcodeAlchemyAttribute(abcData);
		}
		
		override public function get name():String { return "ABCOpcodeAlchemyAttribute"; }
	}
}
