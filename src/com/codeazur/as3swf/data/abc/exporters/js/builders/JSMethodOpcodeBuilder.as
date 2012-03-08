package com.codeazur.as3swf.data.abc.exporters.js.builders
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOpcodeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCVariableBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSArgumentBuilderFactory;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSArgumentsBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSThisArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSOperatorExpressionFactory;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSPrimaryExpressionFactory;
	import com.codeazur.as3swf.data.abc.exporters.translator.ABCOpcodeTranslateData;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	import flash.utils.ByteArray;


	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMethodOpcodeBuilder implements IABCMethodOpcodeBuilder {
		
		private var _methodInfo:ABCMethodInfo;
		private var _translateData:ABCOpcodeTranslateData;
		
		private var _stack:JSStack;
		private var _position:uint;
		private var _arguments:Vector.<ABCParameter>;
		
		public function JSMethodOpcodeBuilder() {
			_stack = JSStack.create();
			_arguments = new Vector.<ABCParameter>();
		}
		
		public static function create(methodInfo:ABCMethodInfo, translateData:ABCOpcodeTranslateData):JSMethodOpcodeBuilder {
			const builder:JSMethodOpcodeBuilder = new JSMethodOpcodeBuilder();
			builder.methodInfo = methodInfo;
			builder.translateData = translateData;
			return builder;
		}

		public function write(data : ByteArray) : void {
			const parameters:Vector.<ABCParameter> = methodInfo.parameters;
			const parameterTotal:uint = parameters.length;
			for(var i:uint=0; i<parameterTotal; i++) {
				_arguments.push(parameters[i]);
			}
			
			const total:uint = translateData.length;
			if(total > 0) {
				_position = 0;
				recursive(_stack, 0);
			}
			
			_stack.write(data);
		}
		
		private function recursive(stack:JSStack, indent:uint=0, tail:ABCOpcode = null):void {
			const total:uint = translateData.length;
			for(; _position<total; _position++) {
				
				const opcodes:Vector.<ABCOpcode> = translateData.getAt(_position);
				const opcodesTotal:uint = opcodes.length;
				
				if(tail) {
					if(opcodes.indexOf(tail) > -1) {
						return;
					} else if(ABCOpcodeKind.isType(opcodes[opcodes.length - 1].kind, ABCOpcodeKind.JUMP)) {
						const next:Vector.<ABCOpcode> = translateData.getAt(_position + 1);
						if(next.indexOf(tail) > -1) {
							return;
						}
					} 
				} 
				
				// Get the tail items so that we know what to do with the item
				const offset:int = opcodesTotal - 1;
				const opcode:ABCOpcode = opcodes[offset];
				const kind:ABCOpcodeKind = opcode.kind;
				switch(kind) {
					case ABCOpcodeKind.CONSTRUCTSUPER:
						const superMethod:IABCValueBuilder = JSValueBuilder.create(JSReservedKind.SUPER.type);
						const superName:Vector.<IABCWriteable> = createName(opcodes, opcode.attribute);
						const superArguments:Vector.<IABCWriteable> = createMethodArguments(opcodes, opcode.attribute);
						
						stack.add(JSNameBuilder.create(superName), JSMethodCallBuilder.create(superMethod, superArguments)).terminator = true;
						break;
					
					case ABCOpcodeKind.CALLPROPERTY:
					case ABCOpcodeKind.CALLPROPVOID:
						const propertyMethod:IABCValueBuilder = JSValueAttributeBuilder.create(opcode.attribute);
						const propertyName:Vector.<IABCWriteable> = createName(opcodes, opcode.attribute);
						const propertyArguments:Vector.<IABCWriteable> = createMethodArguments(opcodes, opcode.attribute);
						stack.add(JSNameBuilder.create(propertyName), JSMethodCallBuilder.create(propertyMethod, propertyArguments)).terminator = true;
						break;
					
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
						const ifExpr:JSConsumableBlock = createIfStatementExpression(opcodes);
						const ifBody:JSStack = parseInternalBlock(opcode, indent);
						stack.add(JSIfStatementBuilder.create(kind, ifExpr, ifBody));
						break;
						
					case ABCOpcodeKind.JUMP:
						const jumpcode:ABCOpcode = opcodes.length > 2 ? opcodes[opcodes.length - 2] : opcodes[opcodes.length - 1];
						const jumpExpr:JSConsumableBlock = createIfStatementExpression(opcodes);
						const jumpBody:JSStack = parseInternalBlock(jumpcode, indent);
						stack.add(JSIfStatementBuilder.create(kind, jumpExpr, jumpBody));
						break;
				
					case ABCOpcodeKind.GETLOCAL_0:
						stack.add(JSNameBuilder.create(consume(opcodes, 0, offset + 1), true));
						break;
					
					case ABCOpcodeKind.SETLOCAL_1:
						stack.add(createLocalVariable(0, opcodes, offset));
						break;
						
					case ABCOpcodeKind.SETLOCAL_2:
						stack.add(createLocalVariable(1, opcodes, offset));
						break;
						
					case ABCOpcodeKind.SETLOCAL_3:
						stack.add(createLocalVariable(2, opcodes, offset));
						break;
					
					case ABCOpcodeKind.RETURNVALUE:
						const returnValue:Vector.<IABCWriteable> = consume(opcodes, 0, offset);
						stack.add(JSReturnBuilder.create(JSNameBuilder.create(returnValue))).terminator = true;
						break;
					
					case ABCOpcodeKind.RETURNVOID:
						stack.add(JSReturnVoidBuilder.create()).terminator = true;
						break;
					
					case ABCOpcodeKind.DEBUG:
					case ABCOpcodeKind.DEBUGFILE:
					case ABCOpcodeKind.DEBUGLINE:
						// do nothing here
						break;
					
					default:
						trace(">>", kind);
						break;
				}
			}
		}
		
		private function consume(opcodes:Vector.<ABCOpcode>, start:uint, finish:uint):Vector.<IABCWriteable> {
			const result:Vector.<IABCWriteable> = new Vector.<IABCWriteable>();
			
			for(var i:uint=start; i<finish; i++) {
				const opcode:ABCOpcode = opcodes[i];
				const kind:ABCOpcodeKind = opcode.kind;
							
				switch(kind) {
					case ABCOpcodeKind.CALLPROPERTY:
					case ABCOpcodeKind.CONSTRUCTPROP:
						const propertyMethod:IABCValueBuilder = JSValueAttributeBuilder.create(opcode.attribute);
						const propertyArguments:Vector.<IABCWriteable> = consumeMethodArguments(result, opcode.attribute);
						if(result.length > 0) {
							// TODO: Should we consume the whole results
							result.push(JSConsumableBlock.create(result.pop(), JSMethodCallBuilder.create(propertyMethod, propertyArguments)));
						} else {
							result.push(JSMethodCallBuilder.create(propertyMethod, propertyArguments));
						}
						break;
						
					case ABCOpcodeKind.GETLOCAL_0:
						result.push(getLocal(0));
						break;
						
					case ABCOpcodeKind.GETLOCAL_1:
						result.push(getLocal(1));
						break;
					
					case ABCOpcodeKind.GETLOCAL_2:
						result.push(getLocal(2));
						break;
					
					case ABCOpcodeKind.GETLOCAL_3:
						result.push(getLocal(3));
						break;
						
					case ABCOpcodeKind.GETSUPER:
						const superProperty:IABCValueBuilder = JSValueAttributeBuilder.create(opcode.attribute);
						if(result.length > 0) {
							// TODO: Should we consume the whole results
							result.push(JSConsumableBlock.create(result.pop(), JSConsumableBlock.create(JSValueBuilder.create(JSReservedKind.SUPER.type), superProperty)));
						} else {
							result.push(JSConsumableBlock.create(JSValueBuilder.create(JSReservedKind.SUPER.type), superProperty));
						}
						break;
						
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
						result.push(JSIfStatementFactory.create(kind, result.splice(0, result.length)));
						break;
	
					case ABCOpcodeKind.ADD:
					case ABCOpcodeKind.ADD_D:
					case ABCOpcodeKind.ADD_I:
					case ABCOpcodeKind.DIVIDE:
					case ABCOpcodeKind.EQUALS:
					case ABCOpcodeKind.MULTIPLY:
					case ABCOpcodeKind.MULTIPLY_I:
					case ABCOpcodeKind.NOT:
					case ABCOpcodeKind.SUBTRACT:
					case ABCOpcodeKind.SUBTRACT_I:
						result.push(JSOperatorExpressionFactory.create(opcode.kind, result.splice(0, result.length)));
						break;
					
					case ABCOpcodeKind.PUSHFALSE:
					case ABCOpcodeKind.PUSHNULL:
					case ABCOpcodeKind.PUSHTRUE:
						result.push(JSPrimaryExpressionFactory.create(opcode.kind));
						break;
						
					case ABCOpcodeKind.PUSHBYTE:
					case ABCOpcodeKind.PUSHDECIMAL:
					case ABCOpcodeKind.PUSHDOUBLE:
					case ABCOpcodeKind.PUSHINT:
					case ABCOpcodeKind.PUSHSTRING:
					case ABCOpcodeKind.GETLEX:
					case ABCOpcodeKind.GETPROPERTY:
					case ABCOpcodeKind.PUSHSTRING:
						result.push(JSArgumentBuilderFactory.create(opcode.attribute));
						break;
					
					case ABCOpcodeKind.DUP:
						throw new Error('Invalid duplication (expected=null, recieved=' + kind + ")");
						break;
					
					case ABCOpcodeKind.DEBUG:
					case ABCOpcodeKind.DEBUGFILE:
					case ABCOpcodeKind.DEBUGLINE:
						// do nothing here
						break;
					
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
						// Ignore these for JS output.
						break;
						
					default:
						trace(">>>", kind);
						break;
				}
			}
			
			return result;
		}
		
		private function consumeMethodArguments(items:Vector.<IABCWriteable>, attribute:ABCOpcodeAttribute):Vector.<IABCWriteable> {
			const numArguments:uint = JSArgumentBuilderFactory.getNumberArguments(attribute);
			return items.splice(items.length - numArguments, numArguments);
		}
		
		private function getLocal(index:uint):IABCArgumentBuilder {
			var result:IABCArgumentBuilder = null;
			
			if(index == 0) {
				result = JSThisArgumentBuilder.create();
			} else if(index <= methodInfo.parameters.length) {
				result = JSArgumentBuilder.create(_arguments[index - 1]);
			} else {
				if(!(methodInfo.needRest || methodInfo.needArguments)) {
					result = JSArgumentBuilder.create(_arguments[index - 1]);
				} else if(methodInfo.needRest){
					result = JSArgumentsBuilder.create();
				} else {
					throw new Error();
				}
			}
			
			return result;
		}
		
		private function addLocal(local:IABCVariableBuilder):Boolean {
			var exists:Boolean = false;
			
			const total:uint = _arguments.length;
			for(var i:uint=0; i<total; i++) {
				const abcParameter:ABCParameter = _arguments[i];
				if(abcParameter.qname.fullName == local.variable.fullName) {
					exists = true;
					break;
				}
			}
			
			if(!exists) {
				_arguments.push(ABCParameter.create(local.variable, local.variable.fullName));
			}
			
			return !exists;
		}
		
		private function createName(opcodes:Vector.<ABCOpcode>, attribute:ABCOpcodeAttribute):Vector.<IABCWriteable> {
			const total:int = opcodes.length - 1;
			const numArguments:uint = JSArgumentBuilderFactory.getNumberArguments(attribute);
			return consume(opcodes, 0, total - numArguments);
		}
		
		private function createMethodArguments(opcodes:Vector.<ABCOpcode>, attribute:ABCOpcodeAttribute):Vector.<IABCWriteable> {
			const total:int = opcodes.length - 1;
			const numArguments:uint = JSArgumentBuilderFactory.getNumberArguments(attribute);
			return consume(opcodes, total - numArguments, total);
		}
		
		private function createIfStatementExpression(opcodes:Vector.<ABCOpcode>):JSConsumableBlock {
			const items:Vector.<IABCWriteable> = new Vector.<IABCWriteable>();
			
			const total:uint = opcodes.length;
			
			var previous:uint = 0;
			for(var i:uint=0; i<total; i++) {
				const opcode:ABCOpcode = opcodes[i];
				if(ABCOpcodeKind.isIfType(opcode.kind)) {
					const index:uint = i + 1;
					const statement:Vector.<IABCWriteable> = consume(opcodes, previous, index);
					if(statement.length == 1) {
						items.push(statement[0]);
					} else {
						throw new Error();
					}
					previous = index;
				} else if(ABCOpcodeKind.isType(opcode.kind, ABCOpcodeKind.JUMP)) {
					continue;
				}
			}
			
			return JSIfStatementFactory.make(items);
		}
		
		private function parseInternalBlock(opcode:ABCOpcode, indent:uint):JSStack {
			const stack:JSStack = JSStack.create();
			const opcodes:ABCOpcodeSet = methodInfo.methodBody.opcode;
						
			_position++;
			recursive(stack, indent + 1, opcodes.getJumpTarget(opcode));
			_position--;
			
			return stack;
		}
		
		private function createLocalVariable(index:uint, opcodes:Vector.<ABCOpcode>, offset:uint):IABCVariableBuilder {
			const localQName:ABCQualifiedName = JSLocalVariableBuilder.createLocalQName(index);
			const localVariable:IABCVariableBuilder = JSLocalVariableBuilder.create(localQName, consume(opcodes, 0, offset));
			localVariable.includeKeyword = addLocal(localVariable);
						
			return localVariable;
		}
		
		public function get methodInfo():ABCMethodInfo { return _methodInfo; }
		public function set methodInfo(value:ABCMethodInfo):void { _methodInfo = value; }
		
		public function get translateData():ABCOpcodeTranslateData { return _translateData; }
		public function set translateData(value:ABCOpcodeTranslateData):void { _translateData = value; }
			
		public function get name():String { return "JSMethodOpcodeBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}