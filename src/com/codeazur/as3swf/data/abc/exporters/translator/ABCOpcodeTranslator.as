package com.codeazur.as3swf.data.abc.exporters.translator
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBody;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeTranslator {
		
		public var methodInfo:ABCMethodInfo;
		
		private var _opcodes:Vector.<ABCOpcode>;
		
		public function ABCOpcodeTranslator() {
			_opcodes = new Vector.<ABCOpcode>();
		}
		
		public static function create(methodInfo:ABCMethodInfo):ABCOpcodeTranslator {
			const translator:ABCOpcodeTranslator = new ABCOpcodeTranslator();
			translator.methodInfo = methodInfo;
			return translator;
		}
		
		public function translate(data:ABCOpcodeTranslateData):void {
			_opcodes.length = 0;
			
			const methodBody:ABCMethodBody = methodInfo.methodBody;
			const opcodes:ABCOpcodeSet = methodBody.opcode;
			const total:uint = opcodes.length;
			
			for(var i:uint=0; i<total; i++) {
				const opcode:ABCOpcode = opcodes.getAt(i);
				const kind:ABCOpcodeKind = opcode.kind;
				
				switch(kind) {
					case ABCOpcodeKind.CALLPROPERTY:
					case ABCOpcodeKind.DUP:
					case ABCOpcodeKind.GETLOCAL_0:
					case ABCOpcodeKind.GETLOCAL_1:
					case ABCOpcodeKind.GETLOCAL_2:
					case ABCOpcodeKind.GETLOCAL_3:
					case ABCOpcodeKind.PUSHBYTE:
					case ABCOpcodeKind.PUSHFALSE:
					case ABCOpcodeKind.PUSHTRUE:
						_opcodes.push(opcode);
						break;
					
					case ABCOpcodeKind.CONSTRUCTSUPER:
					case ABCOpcodeKind.IFEQ:
					case ABCOpcodeKind.IFFALSE:
					case ABCOpcodeKind.IFGE:
					case ABCOpcodeKind.IFGT:
					case ABCOpcodeKind.IFLE:
					case ABCOpcodeKind.IFLT:
					case ABCOpcodeKind.IFNE:
					case ABCOpcodeKind.IFNGE:
					case ABCOpcodeKind.IFNGT:
					case ABCOpcodeKind.IFNLE:
					case ABCOpcodeKind.IFNLT:
					case ABCOpcodeKind.IFSTRICTEQ:
					case ABCOpcodeKind.IFSTRICTNE:
					case ABCOpcodeKind.IFTRUE:
						data.add(consume(opcode));
						break;
						
					case ABCOpcodeKind.POP:
					case ABCOpcodeKind.PUSHSCOPE:
						data.add(consume());
						break;
						
					case ABCOpcodeKind.DEBUG:
					case ABCOpcodeKind.DEBUGFILE:
					case ABCOpcodeKind.DEBUGLINE:
						data.add(consume(opcode));
						break;
					
					case ABCOpcodeKind.RETURNVOID:
						data.add(new <ABCOpcode>[opcode]);
						break;
						
					case ABCOpcodeKind.FINDPROPSTRICT:
					case ABCOpcodeKind.POP:
						// Do nothing here
						break;
						
					default:
						trace(kind);
						break;
				}
			}
		}
		
		private function consume(opcode:ABCOpcode=null):Vector.<ABCOpcode> {
			const result:Vector.<ABCOpcode> = _opcodes.slice();
			if(opcode) {
				result.push(opcode);
			}
			
			_opcodes.length = 0;
			
			return result;
		}
	}
}
