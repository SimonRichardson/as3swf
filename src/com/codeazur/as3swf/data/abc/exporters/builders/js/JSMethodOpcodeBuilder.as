package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBody;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeMultinameUIntAttribute;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOpcodeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.expressions.JSThisExpression;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMethodOpcodeBuilder implements IABCMethodOpcodeBuilder {
		
		private var _parameters:Vector.<ABCParameter>;
		private var _methodBody:ABCMethodBody;
		private var _returnType:IABCMultiname;
		
		public function JSMethodOpcodeBuilder() {
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
			const total:uint = opcodes.length;
			if(total > 0) {
				var pending:Boolean = false;
				var item:IABCWriteable;
				
				const scope:Vector.<IABCWriteable> = new Vector.<IABCWriteable>();
				const stack:Vector.<IABCWriteable> = new Vector.<IABCWriteable>();
				const params:Vector.<IABCWriteable> = new Vector.<IABCWriteable>();
								
				// Build method args
				for(var i:uint=0; i<total; i++) {
					const opcode:ABCOpcode = opcodes.getAt(i);
					const kind:ABCOpcodeKind = opcode.kind;
					
					if(!ABCOpcodeKind.isDebug(kind)) {
						if(!(i == total - 1 && ABCOpcodeKind.isType(kind, ABCOpcodeKind.RETURNVOID))) {
							switch(kind) {
								case ABCOpcodeKind.CALLPROPERTY:
									const numArguments:uint = getNumberArguments(opcode.attribute);
									
									scope.length = 0;
									scope[0] = stack[stack.length - numArguments];
									
									params.length = 0;
									for(var j:uint=0; j<numArguments; j++) {
										params.push(stack[(stack.length - numArguments) + j]);
									}
									
									const method:IABCValueBuilder = JSValueAttributeBuilder.create(opcode.attribute);
									item = JSMethodCallBuilder.create(scope, method, params);
									item.write(data);
									stack.push(item);
									pending = true;
									break;
								
								case ABCOpcodeKind.CONSTRUCTSUPER:
									scope.length = 0;
									scope[0] = stack[stack.length - 1];
									
									const superctorMethod:IABCValueBuilder = JSValueBuilder.create(JSReservedKind.SUPER.type);
									item = JSMethodCallBuilder.create(scope, superctorMethod);
									item.write(data);
									stack.push(item);
									pending = true;
									break;
								
								case ABCOpcodeKind.GETLOCAL_0:
									if(pending) {
										pending = false;
										JSTokenKind.SEMI_COLON.write(data);
									}
									stack.push(JSThisExpression.create());
									break;
								
								case ABCOpcodeKind.GETLOCAL_1:
									stack.push(JSValueBuilder.create(parameters[0].name));
									break;
									
								case ABCOpcodeKind.PUSHSCOPE:
									scope.length = 0;
									scope[0] = stack[stack.length - 1];
									
									item = JSAccessorBuilder.create(scope);
									item.write(data);
									stack.push(item);
									pending = true;
									break;
								
								case ABCOpcodeKind.POP:
									if(pending) {
										pending = false;
										JSTokenKind.SEMI_COLON.write(data);
									}
									stack.pop();
									break;
									
								default:
									trace(kind);
									break;
							}
						}
					}
				}
			}
		}
		
		private function getNumberArguments(attribute:ABCOpcodeAttribute):uint {
			var numArguments:uint = 1;
			if(attribute is ABCOpcodeMultinameUIntAttribute){
				numArguments = ABCOpcodeMultinameUIntAttribute(attribute).numArguments + 1;
			}
			return numArguments;
		}
		
		public function get parameters():Vector.<ABCParameter> { return _parameters; }
		public function set parameters(value:Vector.<ABCParameter>):void { _parameters = value; }
			
		public function get methodBody():ABCMethodBody { return _methodBody; }
		public function set methodBody(value:ABCMethodBody):void { _methodBody = value; }
		
		public function get returnType():IABCMultiname { return _returnType; }
		public function set returnType(value:IABCMultiname):void { _returnType = value; }
		
		public function get name():String { return "JSMethodOpcodeBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}