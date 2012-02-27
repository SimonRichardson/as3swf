package com.codeazur.as3swf.data.abc.exporters.js.builders
{

	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSThisExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.JSStackItem;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBody;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOpcodeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCVariableBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.JSStack;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSArgumentBuilderFactory;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSThisArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSEqualityExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSInequalityExpression;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;



	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMethodOpcodeBuilder implements IABCMethodOpcodeBuilder {
		
		private var _parameters:Vector.<ABCParameter>;
		private var _scopeParameters:Vector.<ABCParameter>;
		
		private var _methodBody:ABCMethodBody;
		private var _returnType:IABCMultiname;
		private var _enableDebug:Boolean;
		
		private var _needsRest:Boolean;
		private var _needsArguments:Boolean;
		
		private var _position:int;
		private var _stack:JSStack;
		
		public function JSMethodOpcodeBuilder() {
			_enableDebug = false;
			
			_scopeParameters = new Vector.<ABCParameter>();
		}
		
		public static function create(parameters:Vector.<ABCParameter>, methodBody:ABCMethodBody, returnType:IABCMultiname):JSMethodOpcodeBuilder {
			const builder:JSMethodOpcodeBuilder = new JSMethodOpcodeBuilder();
			builder.parameters = parameters;
			builder.methodBody = methodBody;
			builder.returnType = returnType;
			return builder;
		}

		public function write(data : ByteArray) : void {			
			_position = 0;
			_stack = new JSStack();
			
			const parameterTotal:uint = _parameters.length;
			for(var i:uint=0; i<parameterTotal; i++) {
				_scopeParameters.push(_parameters[i]);
			}
			
			const opcodes:ABCOpcodeSet = methodBody.opcode;
			const opcodesTotal:uint = opcodes.length;
			if(opcodesTotal > 0) {
				statementBuilder(0, _stack);
			}
			
			_stack.write(data);
		}
		
		private function statementBuilder(indent:uint, stack:JSStack, tail:ABCOpcode = null):void {
			const opcodes:ABCOpcodeSet = methodBody.opcode;
			
			const total:uint = opcodes.length;
			for(; _position<total; _position++) {
				const opcode:ABCOpcode = opcodes.getAt(_position);
				if(null != tail && opcode == tail) {
					return;
				}
				
				// trace(indent, opcode);
				
				switch(opcode.kind) {
					case ABCOpcodeKind.DUP:
						stack.add(stack.tail.clone().writeable);
						break;
					
					case ABCOpcodeKind.GETLOCAL_0:
						stack.add(getLocal(0));
						break;
					
					case ABCOpcodeKind.GETLOCAL_1:
						stack.add(getLocal(1));
						break;	
					
					case ABCOpcodeKind.PUSHSCOPE:
						stack.add(JSConsumableBlock.create(stack.pop().writeable));
						break;
					
					case ABCOpcodeKind.PUSHBYTE:
					case ABCOpcodeKind.PUSHINT:
					case ABCOpcodeKind.PUSHSTRING:
					case ABCOpcodeKind.GETLEX:
					case ABCOpcodeKind.GETPROPERTY:
						stack.add(JSArgumentBuilderFactory.create(opcode.attribute));
						break;
					
					case ABCOpcodeKind.SETLOCAL_1:
						const localQName:ABCQualifiedName = JSLocalVariableBuilder.createLocalQName(0);
						const localVariable:IABCVariableBuilder = JSLocalVariableBuilder.create(localQName, stack.pop().writeable);
						localVariable.includeKeyword = insertLocal(localVariable);
						
						stack.add(localVariable);
						break;
					
					case ABCOpcodeKind.CONSTRUCTSUPER:
						const superMethod:IABCValueBuilder = JSValueBuilder.create(JSReservedKind.SUPER.type);
						const superArguments:Vector.<IABCArgumentBuilder> = createMethodArguments(stack, opcode.attribute);
						
						stack.add(JSConsumableBlock.create(stack.pop().writeable, JSMethodCallBuilder.create(superMethod, superArguments)));
						break;
					
					case ABCOpcodeKind.CALLPROPERTY:
					case ABCOpcodeKind.CALLPROPVOID:
						const propertyMethod:IABCValueBuilder = JSValueAttributeBuilder.create(opcode.attribute);
						const propertyArguments:Vector.<IABCArgumentBuilder> = createMethodArguments(stack, opcode.attribute);
						
						stack.add(JSConsumableBlock.create(stack.pop().writeable, JSMethodCallBuilder.create(propertyMethod, propertyArguments)));
						break;
					
					case ABCOpcodeKind.RETURNVOID:
						stack.add(JSConsumableBlock.create(JSReturnVoidBuilder.create()));
						break;
						
					case ABCOpcodeKind.IFNE:
					case ABCOpcodeKind.IFFALSE:
						stack.add(createIfStatement(stack, JSEqualityExpression.create(), opcode, indent));
						break;
					
					case ABCOpcodeKind.IFEQ:
					case ABCOpcodeKind.IFTRUE:
						stack.add(createIfStatement(stack, JSInequalityExpression.create(), opcode, indent));
						break;
						
					default:
						trace(opcode.kind);
						break;
				}
			}
		}
		
		private function createIfStatement(stack:JSStack, expression:JSConsumableBlock, opcode:ABCOpcode, indent:uint=0):JSIfStatementBuilder {
			if(	ABCOpcodeKind.isType(opcode.kind, ABCOpcodeKind.IFNE) ||
				ABCOpcodeKind.isType(opcode.kind, ABCOpcodeKind.IFEQ)
				) {
				expression.right = consume(stack);
			}
			
			expression.left = consume(stack);
						
			const ifStack:JSStack = parseInternalStack(indent, opcode);
						
			return JSIfStatementBuilder.create(expression, ifStack);
		}
		
		private function consume(stack:JSStack):IABCWriteable {
			const result:JSStack = new JSStack();
			
			var index:uint = stack.length;
			while(--index > -1) {
				const item:JSStackItem = stack.pop();
				result.addAt(item.writeable, 0);
				
				// TODO: Locate more locations of when this needs to break
				if(item.writeable is JSThisArgumentBuilder) {
					break;
				}
			}
			
			trace(result);
			
			return result;
		}
		
		private function parseInternalStack(indent:uint, opcode:ABCOpcode):JSStack {
			const stack:JSStack = JSStack.create();
			const opcodes:ABCOpcodeSet = methodBody.opcode;
			
			_position++;
			statementBuilder(indent + 1, stack, opcodes.getJumpTarget(opcode));
			_position--;
			
			return stack;
		}
		
		private function getLocal(index:uint):IABCArgumentBuilder {
			var result:IABCArgumentBuilder = null;
			if(index == 0) {
				result = JSThisArgumentBuilder.create();
			} else if(index < parameters.length) {
				result = JSArgumentBuilder.create(parameters[index - 1]);
			} else {
				if(!(needsRest || needsArguments)) {
					result = JSArgumentBuilder.create(_scopeParameters[index - 1]);
				} else {
					// Work out needs rest and needs arguments
					throw new Error();
				}
			}
			return result;
		}
		
		private function insertLocal(local:IABCVariableBuilder):Boolean {
			var exists:Boolean = false;
			
			const total:uint = _scopeParameters.length;
			for(var i:uint=0; i<total; i++) {
				const abcParameter:ABCParameter = _scopeParameters[i];
				if(abcParameter.qname.fullName == local.variable.fullName) {
					exists = true;
					break;
				}
			}
			
			if(!exists) {
				_scopeParameters.push(ABCParameter.create(local.variable, local.variable.fullName));
			}
			
			return !exists;
		}
		
		private function createMethodArguments(stack:JSStack, attribute:ABCOpcodeAttribute):Vector.<IABCArgumentBuilder> {
			const results:Vector.<IABCArgumentBuilder> = new Vector.<IABCArgumentBuilder>();
			const total:uint = JSArgumentBuilderFactory.getNumberArguments(attribute);
			for(var j:uint=1; j<total; j++) {
				const writeable:IABCWriteable = stack.pop().writeable;
				
				if(writeable is IABCArgumentBuilder) {
					results.push(writeable);
				} else {
					throw new Error();
				}
			}
			
			return results.reverse();
		}
		
		public function get parameters():Vector.<ABCParameter> { return _parameters; }
		public function set parameters(value:Vector.<ABCParameter>):void { _parameters = value; }
			
		public function get methodBody():ABCMethodBody { return _methodBody; }
		public function set methodBody(value:ABCMethodBody):void { _methodBody = value; }
		
		public function get returnType():IABCMultiname { return _returnType; }
		public function set returnType(value:IABCMultiname):void { _returnType = value; }
		
		public function get enableDebug() : Boolean { return _enableDebug; }
		public function set enableDebug(value : Boolean) : void { _enableDebug = value;	}
		
		public function get needsRest() : Boolean { return _needsRest; }
		public function set needsRest(value : Boolean) : void { _needsRest = value; }
		
		public function get needsArguments() : Boolean { return _needsArguments; }
		public function set needsArguments(value : Boolean) : void { _needsArguments = value; }
		
		public function get name():String { return "JSMethodOpcodeBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}