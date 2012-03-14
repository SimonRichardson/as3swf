package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitConstInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitInfoKind;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCMultinameBuiltin;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceKind;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceType;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCApplyTypeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCAttributeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodCallBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOpcodeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMultinameAttributeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCVariableBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSArgumentsBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSAttributeFactory;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSIntegerArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSMultinameArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSStringArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSThisArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSUnsignedIntegerArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSOperatorExpressionFactory;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.variables.JSLocalVariableBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.variables.JSPackageVariableBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.variables.JSPrivateVariableBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.variables.JSProtectedVariableBuilder;
	import com.codeazur.as3swf.data.abc.exporters.translator.ABCOpcodeTranslateData;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;




	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMethodOpcodeBuilder implements IABCMethodOpcodeBuilder {
		
		private var _methodInfo:ABCMethodInfo;
		private var _traits:Vector.<ABCTraitInfo>;
		private var _translateData:ABCOpcodeTranslateData;
		
		private var _stack:JSStack;
		private var _position:uint;
		private var _arguments:Vector.<ABCParameter>;
		
		public function JSMethodOpcodeBuilder() {
			_stack = JSStack.create();
			_arguments = new Vector.<ABCParameter>();
		}
		
		public static function create(methodInfo:ABCMethodInfo, traits:Vector.<ABCTraitInfo>, translateData:ABCOpcodeTranslateData):JSMethodOpcodeBuilder {
			const builder:JSMethodOpcodeBuilder = new JSMethodOpcodeBuilder();
			builder.methodInfo = methodInfo;
			builder.traits = traits;
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
				const opcode:ABCOpcode = opcodes.pop();
				const numArguments:int = JSAttributeFactory.getNumberArguments(opcode.attribute);
				const consumables:Vector.<IABCWriteable> = consumeTail(opcodes, opcodes.length, 0);
				
				const kind:ABCOpcodeKind = opcode.kind;
				switch(kind) {
					
					case ABCOpcodeKind.CALLPROPERTY:
					case ABCOpcodeKind.CALLPROPVOID:
						const propertyName:IABCMultinameAttributeBuilder = JSAttributeFactory.create(opcode.attribute) as IABCMultinameAttributeBuilder;
						if(propertyName) {
							const propertyArguments:Vector.<IABCWriteable> = consumables.splice(0, numArguments);
							
							if(propertyArguments.length != numArguments) {
								throw new Error('Property argument mismatch');
							} else if(consumables.length == 0) {
								throw new Error('Invalid property accessor');
							}
							
							stack.add(JSNameBuilder.create(consumables), JSMethodCallBuilder.create(propertyName, propertyArguments)).terminator = true;
						} else {
							throw new Error('Property name mismatch');
						}
						break;
					
					case ABCOpcodeKind.CONSTRUCT:
						const constructArguments:Vector.<IABCWriteable> = consumables.splice(0, numArguments);
							
						if(constructArguments.length != numArguments) {
							throw new Error('Construct argument mismatch');
						} else if(consumables.length == 0) {
							throw new Error('Invalid construct accessor');
						}
						
						if(consumables.length != 1) {
							throw new Error('Missing implementation');
						}
						
						const constructMethod:IABCApplyTypeBuilder = consumables.splice(0, 1)[0];
						stack.add(JSConstructBuilder.create(constructMethod, constructArguments.reverse())).terminator = true;
						break;
					
					case ABCOpcodeKind.CONSTRUCTPROP:
						const constructPropName:IABCMultinameAttributeBuilder = JSAttributeFactory.create(opcode.attribute) as IABCMultinameAttributeBuilder;
						if(constructPropName) {
							const constructPropArguments:Vector.<IABCWriteable> = consumables.splice(0, numArguments);
							
							if(constructPropArguments.length != numArguments) {
								throw new Error('Construct property argument mismatch');
							}
							
							stack.add(JSConstructPropertyBuilder.create(constructPropName, constructPropArguments.reverse())).terminator = true;
						} else {
							throw new Error('Construct property name mismatch');
						}
						break; 
					
					case ABCOpcodeKind.CONSTRUCTSUPER:
						const superQName:ABCQualifiedName = ABCQualifiedName.create(JSReservedKind.SUPER.type, ABCNamespaceType.SUPER.ns);
						const superName:IABCMultinameAttributeBuilder = JSMultinameArgumentBuilder.create(superQName);
						const superArguments:Vector.<IABCWriteable> = consumables.splice(0, numArguments);
						
						if(superArguments.length != numArguments) {
							throw new Error('Super argument mismatch');
						}
						
						stack.add(JSNameBuilder.create(consumables), JSMethodCallBuilder.create(superName, superArguments)).terminator = true;
						
						// Init private and protected values
						initialiseTraits(stack);
						break;
				
					case ABCOpcodeKind.GETLOCAL_0:
						if(consumables.length > 0) {
							throw new Error('Invalid stack length');
						}
						
						stack.add(getLocal(0)).terminator = true;
						break;
					
					case ABCOpcodeKind.GETPROPERTY:
						trace(opcode, consumables);
						// const accessor:Vector.<IABCWriteable> = consumeTail(opcodes, 1, indent + 1);
						// attributeBuilder = JSAttributeFactory.create(attribute);
						// value = JSConsumableBlock.create(JSNameBuilder.create(accessor), attributeBuilder);
						break;
						
					case ABCOpcodeKind.SETLOCAL_1:
						if(consumables.length < 1) {
							throw new Error('Invalid stack length');
						}
						
						stack.add(createLocalVariable(1, consumables));
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
		
		private function consumeTail(opcodes:Vector.<ABCOpcode>, total:int, indent:int):Vector.<IABCWriteable> {
			const result:Vector.<IABCWriteable> = new Vector.<IABCWriteable>();
			if(total > 0) {
				var previous:IABCWriteable;
				while(opcodes.length > 0) {
					if(result.length >= total) {
						// Abort when we've got the total items
						break;
					}
					
					const opcode:ABCOpcode = opcodes.pop();
					const kind:ABCOpcodeKind = opcode.kind;
					const attribute:ABCOpcodeAttribute = opcode.attribute;
					
					var localIndex:int = 0;
					var value:IABCWriteable = null;
					var attributeBuilder:IABCAttributeBuilder;
					
					//opcodes.slice().reverse().forEach(function(opcode:ABCOpcode, index:int, vector:Vector.<ABCOpcode>):void { trace(opcode.kind); });
					
					switch(kind) {
						case ABCOpcodeKind.ADD:
						case ABCOpcodeKind.ADD_D:
						case ABCOpcodeKind.ADD_I:
						case ABCOpcodeKind.DECREMENT:
						case ABCOpcodeKind.DECREMENT_I:
						case ABCOpcodeKind.DIVIDE:
						case ABCOpcodeKind.EQUALS:
						case ABCOpcodeKind.INCREMENT:
						case ABCOpcodeKind.INCREMENT_I:
						case ABCOpcodeKind.MULTIPLY:
						case ABCOpcodeKind.MULTIPLY_I:
						case ABCOpcodeKind.NOT:
						case ABCOpcodeKind.SUBTRACT:
						case ABCOpcodeKind.SUBTRACT_I:
						
							const operatorNumArguments:int = 2;
							const operatorArguments:Vector.<IABCWriteable> = consumeTail(opcodes, operatorNumArguments, indent + 1);
							
							if(operatorArguments.length != operatorNumArguments) {
								throw new Error('Operator argument count mismatch (expected=2, recieved=' + operatorArguments.length + ")");
							}
							
							value = JSOperatorExpressionFactory.create(opcode.kind, operatorArguments);
							break;
							
						case ABCOpcodeKind.APPLYTYPE:
							const applyTypeNumArguments:int =JSAttributeFactory.getNumberArguments(attribute);
							const applyTypeArguments:Vector.<IABCWriteable> = consumeTail(opcodes, applyTypeNumArguments, indent + 1);
							
							value = JSApplyTypeBuilder.create(applyTypeArguments);
							break;
						
						case ABCOpcodeKind.CALLPROPERTY:
							
							const propertyMethod:IABCMultinameAttributeBuilder = JSAttributeFactory.create(attribute) as IABCMultinameAttributeBuilder;
							if(propertyMethod) {
								
								const propertyNumArguments:int = JSAttributeFactory.getNumberArguments(attribute);
								const propertyArguments:Vector.<IABCWriteable> = consumeTail(opcodes, propertyNumArguments, indent + 1);
								
								if(propertyArguments.length != propertyNumArguments) {
									throw new Error('Argument count mismatch');
								}
								
								result.push(JSMethodCallBuilder.create(propertyMethod, propertyArguments));
							} else {
								throw new Error('Unexpected method type');
							}
							
							break;
						
						case ABCOpcodeKind.CONSTRUCT:
							const constructNumArguments:int = JSAttributeFactory.getNumberArguments(attribute);
							const constructArguments:Vector.<IABCWriteable> = consumeTail(opcodes, constructNumArguments, indent + 1);
								
							if(constructArguments.length != constructNumArguments) {
								throw new Error('Construct argument mismatch');
							} else if(constructArguments.length == 0) {
								throw new Error('Invalid construct accessor');
							}
							
							const constructMethodNum:int = 1;
							const constructMethodExpression:Vector.<IABCWriteable> = consumeTail(opcodes, constructMethodNum, indent + 1);
							
							if(constructMethodExpression.length != constructMethodNum) {
								throw new Error('Construct method mismatch');
							}
							
							const constructMethod:IABCApplyTypeBuilder = constructMethodExpression.pop();
							value = JSConstructBuilder.create(constructMethod, constructArguments.reverse());
							break;
						
						case ABCOpcodeKind.CONSTRUCTPROP:
							const constructName:IABCMultinameAttributeBuilder = JSAttributeFactory.create(opcode.attribute) as IABCMultinameAttributeBuilder;
							if(constructName) {
								const constructPropNumArguments:int = JSAttributeFactory.getNumberArguments(attribute);
								const constructPropArguments:Vector.<IABCWriteable> = consumeTail(opcodes, constructPropNumArguments, indent + 1);
								
								if(constructPropArguments.length != constructPropNumArguments) {
									throw new Error('Construct property argument mismatch');
								}
								
								value = JSConstructPropertyBuilder.create(constructName, constructPropArguments);
							} else {
								throw new Error('Construct property name mismatch');
							}
							break; 
						
						case ABCOpcodeKind.GETLOCAL_3:
							localIndex++;
						case ABCOpcodeKind.GETLOCAL_2:
							localIndex++;
						case ABCOpcodeKind.GETLOCAL_1:
							localIndex++;
						case ABCOpcodeKind.GETLOCAL_0:
							result.push(getLocal(localIndex));
							break;
							
						case ABCOpcodeKind.GETPROPERTY:
							const accessor:Vector.<IABCWriteable> = consumeTail(opcodes, 1, indent + 1);
							attributeBuilder = JSAttributeFactory.create(attribute);
							value = JSConsumableBlock.create(JSNameBuilder.create(accessor), attributeBuilder);
							break;
						
						case ABCOpcodeKind.NEWOBJECT:
							const newObjectNumArguments:int = JSAttributeFactory.getNumberArguments(attribute);
							const newObjectCosumeAmount:int = newObjectNumArguments * 2;
							const newObjectArguments:Vector.<IABCWriteable> = consumeTail(opcodes, newObjectCosumeAmount, indent + 1);
							if(newObjectArguments.length != newObjectCosumeAmount) {
								throw new Error('Argument count mismatch');
							}
							value = JSNewObjectBuilder.create(newObjectArguments.reverse());
							break;
											
						case ABCOpcodeKind.PUSHBYTE:
						case ABCOpcodeKind.PUSHDECIMAL:
						case ABCOpcodeKind.PUSHDOUBLE:
						case ABCOpcodeKind.PUSHINT:
						case ABCOpcodeKind.PUSHSTRING:
						case ABCOpcodeKind.PUSHSTRING:
							value = JSAttributeFactory.create(attribute);
							break;
						
						case ABCOpcodeKind.PUSHFALSE:	
						case ABCOpcodeKind.PUSHTRUE:
						case ABCOpcodeKind.PUSHNULL:
							value = JSAttributeFactory.create(attribute, kind);
							break;
						
						case ABCOpcodeKind.DEBUG:
						case ABCOpcodeKind.DEBUGFILE:
						case ABCOpcodeKind.DEBUGLINE:
							// do nothing here
							break;
						
						default:
							trace(">>>>", kind);
							break;
					}
					
					// Back patch!
					if(value) {
						previous = result.length > 0 ? result[result.length - 1] : null;
						if(	previous is IABCMethodCallBuilder && 
							ABCMultinameBuiltin.isBuiltin((IABCMethodCallBuilder(previous).method.multiname))) {
							result.push(JSConsumableBlock.create(value, result.pop()));
						} else {
							result.push(value);
						}
					}
				}
			}
			
			return result;
		}
		
		private function initialiseTraits(stack:JSStack):void {
			const total:uint = traits.length;
			for(var i:int=0; i<total; i++) {
				const trait:ABCTraitInfo = traits[i];
				if(ABCTraitInfoKind.isType(trait.kind, ABCTraitInfoKind.CONST)) {
					const constTrait:ABCTraitConstInfo = ABCTraitConstInfo(trait);
					
					const qname:ABCQualifiedName = trait.qname.toQualifiedName();
					if(qname) {
						
						var variable:IABCVariableBuilder;
						if(ABCNamespaceKind.isType(qname.ns.kind, ABCNamespaceKind.PACKAGE_NAMESPACE)) {
							variable = JSPackageVariableBuilder.create(qname);							
						} else if(ABCNamespaceKind.isType(qname.ns.kind, ABCNamespaceKind.PRIVATE_NAMESPACE)) {
							variable = JSPrivateVariableBuilder.create(qname);
						} else if(ABCNamespaceKind.isType(qname.ns.kind, ABCNamespaceKind.PROTECTED_NAMESPACE)) {
							variable = JSProtectedVariableBuilder.create(qname);
						} else {
							throw new Error('Missing implementation');
						}
						
						const type:ABCQualifiedName = constTrait.typeMultiname.toQualifiedName();
						variable.expression = createExpressionFromQName(type, constTrait.defaultValue);
						
						stack.add(JSThisArgumentBuilder.create(), variable).terminator = true;
					} else {
						throw new Error();
					}
				}
			}
		}
		
		public static function createExpressionFromQName(qname:ABCQualifiedName, value:*):IABCAttributeBuilder {
			var builder:IABCAttributeBuilder = null;
			
			const name:String = qname.fullName; 
			if(ABCMultinameBuiltin.isNameType(name, ABCMultinameBuiltin.INT)) {
				builder = JSIntegerArgumentBuilder.create(value);
				
			} else if(ABCMultinameBuiltin.isNameType(name, ABCMultinameBuiltin.UINT)) {
				builder = JSUnsignedIntegerArgumentBuilder.create(value);
				
			} else if(ABCMultinameBuiltin.isNameType(name, ABCMultinameBuiltin.STRING)) {
				builder = JSStringArgumentBuilder.create(value);
				
			} else {
				throw new Error(name);
			}
			return builder;
		}
						
		private function getLocal(index:uint):IABCAttributeBuilder {
			var result:IABCAttributeBuilder = null;
			
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
		
		private function createLocalVariable(index:uint, expressions:Vector.<IABCWriteable>):IABCVariableBuilder {
			const localQName:ABCQualifiedName = JSLocalVariableBuilder.createQName(index);
			const localVariable:IABCVariableBuilder = JSLocalVariableBuilder.create(localQName, expressions);
			localVariable.includeKeyword = addLocal(localVariable);

			return localVariable;
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
			
		public function get methodInfo():ABCMethodInfo { return _methodInfo; }
		public function set methodInfo(value:ABCMethodInfo):void { _methodInfo = value; }
		
		public function get traits():Vector.<ABCTraitInfo> { return _traits; }
		public function set traits(value:Vector.<ABCTraitInfo>):void { _traits = value; }
		
		public function get translateData():ABCOpcodeTranslateData { return _translateData; }
		public function set translateData(value:ABCOpcodeTranslateData):void { _translateData = value; }
			
		public function get name():String { return "JSMethodOpcodeBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}