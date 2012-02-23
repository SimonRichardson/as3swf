package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBody;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCDebugBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOpcodeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSArgumentBuilderFactory;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSNullArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSRestArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.debug.JSDebugFactory;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSThisExpression;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;


	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMethodOpcodeBuilder implements IABCMethodOpcodeBuilder {
		
		private var _parameters:Vector.<ABCParameter>;
		private var _methodBody:ABCMethodBody;
		private var _returnType:IABCMultiname;
		private var _enableDebug:Boolean;
		
		private var _stack:JSStack;
		private var _position:int;
		private var _hasRestArguments:Boolean;
		
		public function JSMethodOpcodeBuilder() {
			_enableDebug = false;
			_hasRestArguments = false;
		}
		
		public static function create(parameters:Vector.<ABCParameter>, methodBody:ABCMethodBody, returnType:IABCMultiname):JSMethodOpcodeBuilder {
			const builder:JSMethodOpcodeBuilder = new JSMethodOpcodeBuilder();
			builder.parameters = parameters;
			builder.methodBody = methodBody;
			builder.returnType = returnType;
			return builder;
		}

		public function write(data : ByteArray) : void {			
			const opcodes:ABCOpcodeSet = methodBody.opcode;
			if(opcodes.length > 0) {
				_position = -1;
				_stack = new JSStack();
				
				recursion();
				
				stack.write(data);
			}
		}
		
		private function recursion():void {
			const opcodes:ABCOpcodeSet = methodBody.opcode;
			const total:uint = opcodes.length;
			
			for(_position++; _position<total; _position++) {
				const opcode:ABCOpcode = opcodes.getAt(_position);
				
				var getLocalIndex:uint = 0;
				var method:IABCValueBuilder = null;
				
				trace(">", opcode);
				
				switch(opcode.kind) {
					
					// NOTE: Notice the fall through of the switch
					case ABCOpcodeKind.CONSTRUCTSUPER:
						method = JSValueBuilder.create(JSReservedKind.SUPER.type);
					case ABCOpcodeKind.CALLPROPERTY:
					case ABCOpcodeKind.CALLPROPVOID:
						const params:Vector.<IABCArgumentBuilder> = new Vector.<IABCArgumentBuilder>();
						const numArguments:uint = JSArgumentBuilderFactory.getNumberArguments(opcode.attribute);
						for(var j:uint=1; j<numArguments; j++) {
							const writeable:IABCWriteable = stack.removeAt((stack.length - numArguments) + j).writeable;
							if(writeable is IABCArgumentBuilder) {
								params.push(writeable);
							} else {
								throw new Error();
							}
						}
						
						method = method || JSValueAttributeBuilder.create(opcode.attribute);
						stack.add(JSMethodCallBuilder.create(method, params));
						
						break;
						
					case ABCOpcodeKind.GETLOCAL_0:
						stack.add(JSThisExpression.create());
						
						recursion();
						break;
					
					// NOTE: Notice the fall through of the switch
					case ABCOpcodeKind.GETLOCAL_3:
						getLocalIndex++;
					case ABCOpcodeKind.GETLOCAL_2:
						getLocalIndex++;
					case ABCOpcodeKind.GETLOCAL_1:
						if(parameters.length > getLocalIndex) {
							stack.add(JSArgumentBuilder.create(parameters[getLocalIndex]));
						} else {
							if(!_hasRestArguments) {
								_hasRestArguments = true;
								
								stack.add(JSRestArgumentBuilder.create(parameters.length));
							} else {
								throw new Error();
							}
						}
						
						recursion();
						break;
					
					case ABCOpcodeKind.GETPROPERTY:
					case ABCOpcodeKind.PUSHBYTE:
					case ABCOpcodeKind.PUSHSTRING:
						stack.add(JSArgumentBuilderFactory.create(opcode.attribute));
						break;
						
					case ABCOpcodeKind.IFFALSE:
						//trace(opcode);
						break;
						
					case ABCOpcodeKind.PUSHNULL:
						stack.add(JSNullArgumentBuilder.create());
						break;
								
					case ABCOpcodeKind.PUSHSCOPE:
						stack.pop();
						break;
					
					case ABCOpcodeKind.RETURNVALUE:
						var index:int = stack.length;
						while(--index > -1) {
							const prev:JSStackItem = stack.getAt(index);
							if(index == 0) {
								stack.addAt(JSReturnBuilder.create(), index);
							} else if(prev.terminator) {
								if(enableDebug) {
									// debug is pushed inbetween the content to be returned!
									if(stack.length >= index - 1) {
										const prevPrev:JSStackItem = stack.getAt(index - 1);
										if(prev.writeable is IABCDebugBuilder && (!(prevPrev.writeable is IABCDebugBuilder) && !prevPrev.terminator)) {
											// splice the debug line in above the index
											const debug:IABCDebugBuilder = stack.removeAt(index).writeable as IABCDebugBuilder;
											stack.addAt(JSReturnBuilder.create(), index - 1);
											stack.addAt(debug, index - 1);
										} else {
											stack.addAt(JSReturnBuilder.create(), index + 1);
										}
									} else {
										throw new Error();
									}
								} else {
									stack.addAt(JSReturnBuilder.create(), index + 1);
								}
								break;
							}
						}
						stack.tail.terminator = true;
						break;
					
					case ABCOpcodeKind.RETURNVOID:
						stack.add(JSReturnVoidBuilder.create());
						break;
					
					case ABCOpcodeKind.DEBUG:
					case ABCOpcodeKind.DEBUGFILE:
					case ABCOpcodeKind.DEBUGLINE:
						if(enableDebug) {
							// we should ignore the first DEBUGLINE as it's not important
							if(_position != 1) {
								stack.add(JSDebugFactory.create(opcode.kind, opcode.attribute));
							}
						} 
						break;
						
					default:
						//trace("Root", opcode.kind);
						break;
				}
				
				if(JSOpcodeTerminatorKind.isType(opcode.kind)) {
					stack.tail.terminator = true;
				}
			}
		}
		
		public function get stack():JSStack { return _stack; }
		
		public function get parameters():Vector.<ABCParameter> { return _parameters; }
		public function set parameters(value:Vector.<ABCParameter>):void { _parameters = value; }
			
		public function get methodBody():ABCMethodBody { return _methodBody; }
		public function set methodBody(value:ABCMethodBody):void { _methodBody = value; }
		
		public function get returnType():IABCMultiname { return _returnType; }
		public function set returnType(value:IABCMultiname):void { _returnType = value; }
		
		public function get enableDebug() : Boolean { return _enableDebug; }
		public function set enableDebug(value : Boolean) : void { _enableDebug = value;	}
		
		public function get name():String { return "JSMethodOpcodeBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}