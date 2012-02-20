package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBody;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeMultinameAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeMultinameUIntAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeStringAttribute;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCDebugBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOpcodeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCParameterBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.debug.JSDebugBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.debug.JSDebugFileBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.debug.JSDebugLineBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.expressions.JSThisExpression;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.parameters.JSMultinameParameterBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.parameters.JSNullParameterBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.parameters.JSParameterBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.parameters.JSStringParameterBuilder;
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
		
		public function JSMethodOpcodeBuilder() {
			_enableDebug = false;
		}
		
		public static function create(parameters:Vector.<ABCParameter>, methodBody:ABCMethodBody, returnType:IABCMultiname):JSMethodOpcodeBuilder {
			const builder:JSMethodOpcodeBuilder = new JSMethodOpcodeBuilder();
			builder.parameters = parameters;
			builder.methodBody = methodBody;
			builder.returnType = returnType;
			return builder;
		}

		public function write(data : ByteArray) : void {
			trace("------------------------------- START -");
			
			const opcodes:ABCOpcodeSet = methodBody.opcode;
			const total:uint = opcodes.length;
			if(total > 0) {
				var pending:Boolean = false;
				var hasRestArguments:Boolean = false;
				
				const stack:JSStack = new JSStack();
				const scope:JSScope = new JSScope();
				const params:Vector.<IABCParameterBuilder> = new Vector.<IABCParameterBuilder>();
								
				// Build method args
				for(var i:uint=0; i<total; i++) {
					const opcode:ABCOpcode = opcodes.getAt(i);
					const attribute:ABCOpcodeAttribute = opcode.attribute;
					const kind:ABCOpcodeKind = opcode.kind;
					
					if(!ABCOpcodeKind.isDebug(kind)) {
						switch(kind) {
							case ABCOpcodeKind.CALLPROPERTY:
								if(pending) {
									pending = false;
									stack.tail.terminator = true;
								}
								
								const numArguments:uint = getNumberArguments(opcode.attribute);
								
								scope.reset();
								scope.add(stack.tail);
								
								params.length = 0;
								for(var j:uint=1; j<numArguments; j++) {
									const writeable:IABCWriteable = stack.getAt((stack.length - numArguments) + j).writeable;
									if(writeable is IABCParameterBuilder) {
										params.push(writeable);
									} else {
										throw new Error();
									}
								}
								
								const method:IABCValueBuilder = JSValueAttributeBuilder.create(opcode.attribute);
								stack.add(JSMethodCallBuilder.create(scope.expressions, method, params));
								pending = true;
								break;
							
							case ABCOpcodeKind.CONSTRUCTSUPER:
								scope.reset();
								scope.add(stack.tail);
								
								const superctorMethod:IABCValueBuilder = JSValueBuilder.create(JSReservedKind.SUPER.type);
								stack.add(JSMethodCallBuilder.create(scope.expressions, superctorMethod));
								pending = true;
								break;
							
							case ABCOpcodeKind.GETLOCAL_0:
								if(pending) {
									pending = false;
									stack.tail.terminator = true;
								}
								
								stack.add(JSThisExpression.create());
								break;
								
							case ABCOpcodeKind.GETPROPERTY:
								stack.add(createParameterFromAttribute(attribute));
								break;
							
							case ABCOpcodeKind.GETLOCAL_1:
								stack.add(JSParameterBuilder.create(parameters[0]));
								break;
							
							case ABCOpcodeKind.GETLOCAL_2:
								if(parameters.length >= 2) {
									stack.add(JSParameterBuilder.create(parameters[1]));
								} else {
									if(!hasRestArguments) {
										hasRestArguments = true;
										stack.add(createRestArgument());
									} else {
										throw new Error();
									}
								}
								break;
							
							case ABCOpcodeKind.GETLOCAL_3:
								if(parameters.length >= 2) {
									stack.add(JSParameterBuilder.create(parameters[1]));
								} else {
									if(!hasRestArguments) {
										hasRestArguments = true;
										stack.add(createRestArgument());
									} else {
										throw new Error();
									}
								}
								break;
							
							case ABCOpcodeKind.PUSHNULL:
								stack.add(JSNullParameterBuilder.create());
								break;
							
							case ABCOpcodeKind.PUSHSCOPE:
								scope.reset();
								scope.add(stack.tail);
								
								stack.add(JSAccessorBuilder.create(scope.expressions));
								pending = true;
								break;
							
							case ABCOpcodeKind.PUSHSTRING:
								stack.add(createParameterFromAttribute(attribute));
								break;
							
							case ABCOpcodeKind.POP:
								stack.pop();
								break;
							
							case ABCOpcodeKind.RETURNVALUE:
								if(pending) {
									pending = false;
									stack.tail.terminator = true;
								}
								trace(opcode);
								break;
								
							case ABCOpcodeKind.RETURNVOID:
								if(pending) {
									pending = false;
									stack.tail.terminator = true;
								}
								stack.add(JSReturnVoidBuilder.create());
								break;
							
							default:
								trace(kind);
								break;
						}
					} else {
						// Don't push this on the stack!
						if(enableDebug) {
							if(pending) {
								pending = false;
								stack.tail.terminator = true;
							}
							
							var debug:IABCDebugBuilder;
							switch(kind) {
								case ABCOpcodeKind.DEBUG:
									debug = JSDebugBuilder.create(opcode.attribute);
									break;
									
								case ABCOpcodeKind.DEBUGFILE:
									debug = JSDebugFileBuilder.create(opcode.attribute);
									break;
									
								case ABCOpcodeKind.DEBUGLINE:
									debug = JSDebugLineBuilder.create(opcode.attribute);
									break;
								
								default:
									throw new Error();
							}
							
							if(length > 0) {
								stack.tail.debug = debug;
							} else {
								stack.add(debug, debug);
							}
						}
					}
				}
			}
			
			stack.write(data);
			
			trace("------------------------------ FINISH -");
		}
		
		private function getNumberArguments(attribute:ABCOpcodeAttribute):uint {
			var numArguments:uint = 1;
			if(attribute is ABCOpcodeMultinameUIntAttribute){
				numArguments = ABCOpcodeMultinameUIntAttribute(attribute).numArguments + 1;
			} else {
				throw new Error();
			}
			return numArguments;
		}
		
		private function createParameterFromAttribute(attribute:ABCOpcodeAttribute):IABCParameterBuilder {
			var builder:IABCParameterBuilder;
			if(attribute is ABCOpcodeMultinameAttribute) {
				const mnameAttr:ABCOpcodeMultinameAttribute = ABCOpcodeMultinameAttribute(attribute);
				builder = JSMultinameParameterBuilder.create(mnameAttr.multiname);
				
			} else if(attribute is ABCOpcodeStringAttribute) {
				const strAttr:ABCOpcodeStringAttribute = ABCOpcodeStringAttribute(attribute);
				builder = JSStringParameterBuilder.create(strAttr.string);
				
			} else {
				throw new Error(attribute);
			}
						
			return builder;					
		}
		
		private function createRestArgument():JSParameterBuilder {
			return JSParameterBuilder.create(ABCParameter.create(null, JSReservedKind.ARGUMENTS.type));
		}
				
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