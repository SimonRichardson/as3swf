package com.codeazur.as3swf.data.abc.exporters.translator
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBody;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeSet;
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
					case ABCOpcodeKind.FINDPROPSTRICT:
						// The above codes can be ignored if outputting to JS
					case ABCOpcodeKind.ADD:
					case ABCOpcodeKind.ADD_D:
					case ABCOpcodeKind.ADD_I:
					case ABCOpcodeKind.CALLPROPERTY:
					case ABCOpcodeKind.DEBUG:
					case ABCOpcodeKind.DEBUGFILE:
					case ABCOpcodeKind.DEBUGLINE:
					case ABCOpcodeKind.DIVIDE:
					case ABCOpcodeKind.GREATERTHAN:
					case ABCOpcodeKind.GREATEREQUALS:
					case ABCOpcodeKind.EQUALS:
					case ABCOpcodeKind.GETLEX:
					case ABCOpcodeKind.GETLOCAL_0:
					case ABCOpcodeKind.GETLOCAL_1:
					case ABCOpcodeKind.GETLOCAL_2:
					case ABCOpcodeKind.GETLOCAL_3:
					case ABCOpcodeKind.GETPROPERTY:
					case ABCOpcodeKind.GETSUPER:
					case ABCOpcodeKind.MULTIPLY:
					case ABCOpcodeKind.MULTIPLY_I:
					case ABCOpcodeKind.NOT:
					case ABCOpcodeKind.PUSHBYTE:
					case ABCOpcodeKind.PUSHDECIMAL:
					case ABCOpcodeKind.PUSHDOUBLE:
					case ABCOpcodeKind.PUSHFALSE:
					case ABCOpcodeKind.PUSHINT:
					case ABCOpcodeKind.PUSHNULL:
					case ABCOpcodeKind.PUSHSTRING:
					case ABCOpcodeKind.PUSHTRUE:
					case ABCOpcodeKind.STRICTEQUALS:
					case ABCOpcodeKind.SUBTRACT:
					case ABCOpcodeKind.SUBTRACT_I:
						_opcodes.push(opcode);
						break;
						
					case ABCOpcodeKind.DUP:
						_opcodes.push(_opcodes.slice(_opcodes.length - 1)[0]);
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
					case ABCOpcodeKind.JUMP:
					case ABCOpcodeKind.RETURNVALUE:
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
					
					case ABCOpcodeKind.RETURNVOID:
						if(_opcodes.length > 0) {
							data.add(consume());
						}
						
						data.add(new <ABCOpcode>[opcode]);
						break;
					
					default:
						trace(kind, opcode);
						break;
				}
			}
			
			trace(data);
		}
		
		private function consume(opcode:ABCOpcode=null):Vector.<ABCOpcode> {
			const result:Vector.<ABCOpcode> = _opcodes.slice();
						
			if(opcode) {
				const length:uint = result.length;
				if(length > 0) {
					var index:int = indexOfKind(result, ABCOpcodeKind.JUMP);
					if(index > -1) {
						result.push(opcode, result.splice(index, 1)[0]);
					} else {
						result.push(opcode);
					}
				} else {
					result.push(opcode);
				}
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
						
						const methodBody:ABCMethodBody = methodInfo.methodBody;
						const opcodes:ABCOpcodeSet = methodBody.opcode;
						if(tail.length > 1) {
							const preTail:ABCOpcode = tail[tail.length - 2];
							if(ABCOpcodeKind.isIfType(preTail.kind) && opcodes.getJumpTarget(preTail)) {
								trace(">>>>>>>>", preTail.kind, opcodes.getJumpTarget(preTail));
								consumeBlock(data);
								return;
							}
						}
						
						if(ABCOpcodeKind.isIfType(last.kind) && containsComparison(tail)) {
							consumeBlock(data);
						} else if(ABCOpcodeKind.isType(last.kind, ABCOpcodeKind.JUMP) && containsComparison(tail)) {
							consumeBlock(data);
						}
						
						consumeJump(data);
					}
					break;
			}
		}
		
		private function consumeJump(data:ABCOpcodeTranslateData):void {
			if(data.tail){
				const length:uint = data.tail.length;
				if(length == 1 && ABCOpcodeKind.isType(data.tail[length - 1].kind, ABCOpcodeKind.JUMP)) {
					consumeBlock(data, true);
				}
			}
		}
		
		private function consumeBlock(data:ABCOpcodeTranslateData, insertAtTail:Boolean=false):void {
			const previous:Vector.<ABCOpcode> = data.pop();
			var index:int = previous.length;
			while(--index>-1) {
				if(insertAtTail) {
					_opcodes.push(previous[index]);
				} else {
					_opcodes.unshift(previous[index]);
				}
			}
		}
		
		private function containsComparison(haystack:Vector.<ABCOpcode>):Boolean {
			var result:Boolean = false;
			
			const total:uint = haystack.length;
			for(var i:uint=0; i<total; i++) {
				if(ABCOpcodeKind.isComparisonType(haystack[i].kind)) {
					result = true;
					break;
				}
			}
			
			return result;
		}
		
		private function indexOfKind(haystack:Vector.<ABCOpcode>, kind:ABCOpcodeKind):int {
			var result:int = -1;
			
			const total:uint = haystack.length;
			for(var i:uint=0; i<total; i++) {
				if(ABCOpcodeKind.isType(haystack[i].kind, kind)) {
					result = i;
					break;
				}
			}
			
			return result;
		}
	}
}
