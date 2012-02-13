package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCMethodBodyOpcode extends ABCSet {
		
		public var opcodes:Vector.<ABCOpcode>;
		
		public function ABCMethodBodyOpcode(abcData:ABCData) {
			super(abcData);
			
			opcodes = new Vector.<ABCOpcode>();
		}
		
		public static function create(abcData:ABCData):ABCMethodBodyOpcode {
			return new ABCMethodBodyOpcode(abcData);
		}
		
		public function parse(data:SWFData):void {
			const total:uint = data.readEncodedU30();
			for(var i:uint=0; i<total; i++) {
				const opcodeKind:uint = data.readUI8();
				const opcode:ABCOpcode = ABCOpcodeFactory.create(abcData, opcodeKind);
			}
		}
		
		override public function get name():String { return "ABCMethodBodyOpcode"; }
		
		override public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
						
			return str;
		}
	}
}
