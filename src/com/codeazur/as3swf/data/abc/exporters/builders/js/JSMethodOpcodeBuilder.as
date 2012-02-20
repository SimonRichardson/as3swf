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
			_enableDebug = true;
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
				var opcode:ABCOpcode;
				
				const stack:JSStack = new JSStack();
				
				// Build method args
				for(var i:uint=0; i<total; i++) {
					opcode = opcodes.getAt(i);
					
					switch(opcode.kind) {
						case ABCOpcodeKind.GETLOCAL_0:
							stack.add(JSThisExpression.create());
						
							for(; i<total; i++) {
								opcode = opcodes.getAt(i);
								
								switch(opcode.kind) {
									case ABCOpcodeKind.CALLPROPERTY:
										const params:Vector.<IABCParameterBuilder> = new Vector.<IABCParameterBuilder>();
										const numArguments:uint = getNumberArguments(opcode.attribute);
										for(var j:uint=1; j<numArguments; j++) {
											const writeable:IABCWriteable = stack.removeAt((stack.length - numArguments) + j).writeable;
											if(writeable is IABCParameterBuilder) {
												params.push(writeable);
											} else {
												throw new Error();
											}
										}
										
										const method:IABCValueBuilder = JSValueAttributeBuilder.create(opcode.attribute);
										stack.add(JSMethodCallBuilder.create(method, params));
										break;
									
									case ABCOpcodeKind.CONSTRUCTSUPER:
										const superConstructorMethod:IABCValueBuilder = JSValueBuilder.create(JSReservedKind.SUPER.type);
										stack.add(JSMethodCallBuilder.create(superConstructorMethod));
										break;
										
									case ABCOpcodeKind.GETLOCAL_1:
										stack.add(JSParameterBuilder.create(parameters[0]));
										break;
										
									case ABCOpcodeKind.PUSHSCOPE:
										stack.pop();
										break;
									
									case ABCOpcodeKind.DEBUG:
									case ABCOpcodeKind.DEBUGFILE:
									case ABCOpcodeKind.DEBUGLINE:
										if(enableDebug) {
											stack.add(getDebugStackItem(opcode.kind, opcode.attribute));
										} 
										break;
										
									default:
										trace("Getlocal_0", opcode.kind);
										break;
								}
								
								if(JSOpcodeTerminatorKind.isType(opcode.kind)) {
									stack.tail.terminator = true;
									break;
								}
							}
							break;
						
						case ABCOpcodeKind.RETURNVOID:
							stack.add(JSReturnVoidBuilder.create());
							break;
						
						case ABCOpcodeKind.DEBUG:
						case ABCOpcodeKind.DEBUGFILE:
						case ABCOpcodeKind.DEBUGLINE:
							if(enableDebug) {
								stack.add(getDebugStackItem(opcode.kind, opcode.attribute));
							}
							break;
						
						default:
							trace("Root:", opcode.kind);
							break;
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
		
		private function getDebugStackItem(kind:ABCOpcodeKind, attribute:ABCOpcodeAttribute):IABCDebugBuilder {
			var debug:IABCDebugBuilder;
			switch(kind) {
				case ABCOpcodeKind.DEBUG:
					debug = JSDebugBuilder.create(attribute);
					break;
					
				case ABCOpcodeKind.DEBUGFILE:
					debug = JSDebugFileBuilder.create(attribute);
					break;
					
				case ABCOpcodeKind.DEBUGLINE:
					debug = JSDebugLineBuilder.create(attribute);
					break;
				
				default:
					throw new Error();
			}
			return debug;
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