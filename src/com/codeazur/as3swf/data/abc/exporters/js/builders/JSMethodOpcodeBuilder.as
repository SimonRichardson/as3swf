package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeStringAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOpcodeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCVariableBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.JSStack;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSArgumentBuilderFactory;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSStringArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSThisArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSEqualityExpression;
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
				
				if(tail && (opcodes.length > 0 && opcodes[0] == tail)) {
					return;
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
					
					case ABCOpcodeKind.CALLPROPVOID:
						const propertyMethod:IABCValueBuilder = JSValueAttributeBuilder.create(opcode.attribute);
						const propertyName:Vector.<IABCWriteable> = createName(opcodes, opcode.attribute);
						const propertyArguments:Vector.<IABCWriteable> = createMethodArguments(opcodes, opcode.attribute);
						
						stack.add(JSNameBuilder.create(propertyName), JSMethodCallBuilder.create(propertyMethod, propertyArguments)).terminator = true;
						break;
					
					case ABCOpcodeKind.IFNE:
						const ifStatementExpr:JSConsumableBlock = createIfStatementExpression(JSEqualityExpression.create(), opcodes);
						const ifStatementBody:JSStack = parseInternalStack(opcode, indent);
						stack.add(JSIfStatementBuilder.create(ifStatementExpr, ifStatementBody));
						break;
					
					case ABCOpcodeKind.GETLOCAL_0:
						stack.add(JSNameBuilder.create(consume(opcodes, 0, offset + 1), true));
						break;
					
					case ABCOpcodeKind.SETLOCAL_1:
						const localQName:ABCQualifiedName = JSLocalVariableBuilder.createLocalQName(0);
						const localVariable:IABCVariableBuilder = JSLocalVariableBuilder.create(localQName, consume(opcodes, 0, offset));
						localVariable.includeKeyword = addLocal(localVariable);
						
						stack.add(localVariable);
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
						const propertyMethod:IABCValueBuilder = JSValueAttributeBuilder.create(opcode.attribute);
						const propertyArguments:Vector.<IABCWriteable> = consumeMethodArguments(result, opcode.attribute);
						if(result.length > 0) {
							// TODO: Should we consume the whole results
							const tail:IABCWriteable = result.pop();
							result.push(JSConsumableBlock.create(tail, JSMethodCallBuilder.create(propertyMethod, propertyArguments)));
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
					
					case ABCOpcodeKind.PUSHSTRING:
						const stringAttribute:ABCOpcodeStringAttribute = ABCOpcodeStringAttribute(opcode.attribute); 
						result.push(JSStringArgumentBuilder.create(stringAttribute.string));
						break;
						
					default:
						trace(">>>", kind);
						break;
				}
			}
			
			return result;
		}
		
		private function consumeMethodArguments(items:Vector.<IABCWriteable>, attribute:ABCOpcodeAttribute):Vector.<IABCWriteable> {
			const total:int = items.length - 1;
			const numArguments:uint = JSArgumentBuilderFactory.getNumberArguments(attribute);
			return items.splice(total - numArguments, numArguments);
		}
		
		private function getLocal(index:uint):IABCArgumentBuilder {
			var result:IABCArgumentBuilder = null;
			
			if(index == 0) {
				result = JSThisArgumentBuilder.create();
			} else if(index < methodInfo.parameters.length) {
				result = JSArgumentBuilder.create(_arguments[index - 1]);
			} else {
				if(!(methodInfo.needRest || methodInfo.needArguments)) {
					result = JSArgumentBuilder.create(_arguments[index - 1]);
				} else {
					// Work out needs rest and needs arguments
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
		
		private function createIfStatementExpression(expression:JSConsumableBlock, opcodes:Vector.<ABCOpcode>):JSConsumableBlock {
			const items:Vector.<IABCWriteable> = consume(opcodes, 0, opcodes.length - 1);
			if(expression is JSEqualityExpression) {
				if(items.length == 2) {
					expression.left = items[0];
					expression.right = items[1];
				} else {
					throw new Error();
				}
			} else {
				throw new Error();
			}
			return expression;
		}
		
		private function parseInternalStack(opcode:ABCOpcode, indent:uint):JSStack {
			const stack:JSStack = JSStack.create();
			const opcodes:ABCOpcodeSet = methodInfo.methodBody.opcode;
			
			_position++;
			recursive(stack, indent + 1, opcodes.getJumpTarget(opcode));
			
			return stack;
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