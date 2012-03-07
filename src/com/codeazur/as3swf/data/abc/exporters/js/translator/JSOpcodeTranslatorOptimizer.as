package com.codeazur.as3swf.data.abc.exporters.js.translator
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.exporters.translator.ABCOpcodeTranslateData;
	import com.codeazur.as3swf.data.abc.exporters.translator.ABCOpcodeTranslatorOptimizer;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSOpcodeTranslatorOptimizer extends ABCOpcodeTranslatorOptimizer {
		
		public function JSOpcodeTranslatorOptimizer() {
		}
		
		public static function create():JSOpcodeTranslatorOptimizer {
			return new JSOpcodeTranslatorOptimizer();
		}
		
		override public function optimize(data:ABCOpcodeTranslateData):void {
			// Strips out unwanted kinds.
			const total:uint = data.length;
			for(var i:uint=0; i<total; i++) {
				const block:Vector.<ABCOpcode> = data.getAt(i);
				var index:uint = block.length;
				while(--index > -1) {
					const opcode:ABCOpcode = block[index];
					const kind:ABCOpcodeKind = opcode.kind;
					
					switch(kind) {
						case ABCOpcodeKind.COERCE:
						case ABCOpcodeKind.COERCE_A:
						case ABCOpcodeKind.COERCE_B:
						case ABCOpcodeKind.COERCE_D:
						case ABCOpcodeKind.COERCE_I:
						case ABCOpcodeKind.COERCE_O:
						case ABCOpcodeKind.COERCE_S:
						case ABCOpcodeKind.COERCE_U:
						case ABCOpcodeKind.CONVERT_B:
						case ABCOpcodeKind.CONVERT_D:
						case ABCOpcodeKind.CONVERT_I:
						case ABCOpcodeKind.CONVERT_O:
						case ABCOpcodeKind.CONVERT_S:
						case ABCOpcodeKind.CONVERT_U:
						case ABCOpcodeKind.DUP:
						case ABCOpcodeKind.FINDPROPSTRICT:
							block.splice(index, 1);
							break;
					}
				}
			}
			
			// TODO: remove debug lines and fix jumptargets where required.
		}
		
		override public function get name():String { return "JSOpcodeTranslatorOptimizer"; }
	}
}
