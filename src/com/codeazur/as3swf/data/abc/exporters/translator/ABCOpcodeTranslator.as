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
					case ABCOpcodeKind.EQUALS:
					case ABCOpcodeKind.GETLOCAL_0:
					case ABCOpcodeKind.GETLOCAL_1:
					case ABCOpcodeKind.GETLOCAL_2:
					case ABCOpcodeKind.GETLOCAL_3:
					case ABCOpcodeKind.GETSUPER:
					case ABCOpcodeKind.PUSHBYTE:
					case ABCOpcodeKind.PUSHFALSE:
					case ABCOpcodeKind.PUSHSTRING:
					case ABCOpcodeKind.PUSHTRUE:
						_opcodes.push(opcode);
						break;
					
					case ABCOpcodeKind.CALLPROPVOID:
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
					case ABCOpcodeKind.SETLOCAL_0:
					case ABCOpcodeKind.SETLOCAL_1:
					case ABCOpcodeKind.SETLOCAL_2:
					case ABCOpcodeKind.SETLOCAL_3:
						consumeTail(data, opcode);
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
						if(_opcodes.length > 0) {
							data.add(consume());
						}
						
						data.add(new <ABCOpcode>[opcode]);
						break;
					
					case ABCOpcodeKind.COERCE:
					case ABCOpcodeKind.COERCE_A:
					case ABCOpcodeKind.COERCE_B:
					case ABCOpcodeKind.COERCE_D:
					case ABCOpcodeKind.COERCE_I:
					case ABCOpcodeKind.COERCE_O:
					case ABCOpcodeKind.COERCE_S:
					case ABCOpcodeKind.COERCE_U:
					case ABCOpcodeKind.FINDPROPSTRICT:
						// Do nothing here
						break;
						
					default:
						trace(kind);
						break;
				}
			}
			
			trace(data);
		}
		
		private function consume(opcode:ABCOpcode=null):Vector.<ABCOpcode> {
			const result:Vector.<ABCOpcode> = _opcodes.slice();
			if(opcode) {
				result.push(opcode);
			}
			
			_opcodes.length = 0;
			
			return result;
		}
		
		private function consumeTail(data:ABCOpcodeTranslateData, opcode:ABCOpcode):void {
			const kind:ABCOpcodeKind = opcode.kind;
			switch(kind) {
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
					if(data.tail) {
						
						const tail:Vector.<ABCOpcode> = data.tail;
						const last:ABCOpcode = tail[tail.length - 1];
						
						if(ABCOpcodeKind.isIfType(last.kind) && containsKind(tail, ABCOpcodeKind.EQUALS)) {
							const previous:Vector.<ABCOpcode> = data.pop();
							var index:int = previous.length;
							while(--index>-1) {
								_opcodes.unshift(previous[index]);
							}
						}
					}
					break;
			}
		}
		
		private function containsKind(haystack:Vector.<ABCOpcode>, kind:ABCOpcodeKind):Boolean {
			var result:Boolean = false;
			
			const total:uint = haystack.length;
			for(var i:uint=0; i<total; i++) {
				if(haystack[i].kind == kind) {
					result = true;
					break;
				}
			}
			
			return result;
		}
	}
}
