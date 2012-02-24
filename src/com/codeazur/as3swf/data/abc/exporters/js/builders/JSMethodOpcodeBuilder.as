package com.codeazur.as3swf.data.abc.exporters.js.builders
{
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
	import com.codeazur.as3swf.data.abc.exporters.js.JSStack;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSArgumentBuilderFactory;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSEmptyExpression;
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
		
		private var _position:int;
		private var _stack:JSStack;
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
			_position = 0;
			_stack = new JSStack();
			
			const opcodes:ABCOpcodeSet = methodBody.opcode;
			if(opcodes.length > 0) {
				statementBuilder();
			}
			
			_stack.write(data);
		}
		
		private function statementBuilder():void {
			const opcodes:ABCOpcodeSet = methodBody.opcode;
			const total:uint = opcodes.length;
			
			for(; _position<total; _position++) {
				const opcode:ABCOpcode = opcodes.getAt(_position);
				
				switch(opcode.kind) {
					case ABCOpcodeKind.GETLOCAL_0:
						_stack.add(JSThisExpression.create());
						break;
						
					case ABCOpcodeKind.PUSHSCOPE:
						_stack.add(JSConsumedBlock.create(_stack.pop().writeable));
						break;
					
					case ABCOpcodeKind.PUSHSTRING:
						_stack.add(JSArgumentBuilderFactory.create(opcode.attribute));
						break;
					
					case ABCOpcodeKind.SETLOCAL_1:
						const localQName:ABCQualifiedName = JSLocalVariableBuilder.createLocalQName(0);
						_stack.add(JSLocalVariableBuilder.create(localQName, _stack.pop().writeable));
						break;
					
					case ABCOpcodeKind.CONSTRUCTSUPER:
						const superMethod:IABCValueBuilder = JSValueBuilder.create(JSReservedKind.SUPER.type);
						const superArguments:Vector.<IABCArgumentBuilder> = createMethodArguments(opcode.attribute);
						
						_stack.add(JSConsumedBlock.create(_stack.pop().writeable, JSMethodCallBuilder.create(superMethod, superArguments)));
						break;
					
					case ABCOpcodeKind.CALLPROPERTY:
						const propertyMethod:IABCValueBuilder = JSValueAttributeBuilder.create(opcode.attribute);
						const propertyArguments:Vector.<IABCArgumentBuilder> = createMethodArguments(opcode.attribute);
						
						_stack.add(JSConsumedBlock.create(_stack.pop().writeable, JSMethodCallBuilder.create(propertyMethod, propertyArguments)));
						break;
					
					case ABCOpcodeKind.RETURNVOID:
						_stack.add(JSConsumedBlock.create(JSReturnVoidBuilder.create()));
						break;
						
					default:
						// trace("Root", opcode.kind);
						break;
				}
			}
		}
		
		private function createMethodArguments(attribute:ABCOpcodeAttribute):Vector.<IABCArgumentBuilder> {
			const results:Vector.<IABCArgumentBuilder> = new Vector.<IABCArgumentBuilder>();
			const total:uint = JSArgumentBuilderFactory.getNumberArguments(attribute);
			for(var j:uint=1; j<total; j++) {
				const writeable:IABCWriteable = _stack.pop().writeable;
				
				if(writeable is IABCArgumentBuilder) {
					results.push(writeable);
				} else {
					throw new Error();
				}
			}
			
			return results;
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