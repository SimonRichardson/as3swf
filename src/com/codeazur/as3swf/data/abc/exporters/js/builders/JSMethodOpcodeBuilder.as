package com.codeazur.as3swf.data.abc.exporters.js.builders
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOpcodeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.JSStack;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSArgumentBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSArgumentBuilderFactory;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSThisArgumentBuilder;
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
			for(var j:uint=0; j<total; j++) {
				const opcodes:Vector.<ABCOpcode> = translateData.getAt(j);
				const opcodesTotal:uint = opcodes.length;
				
				// Get the tail items so that we know what to do with the item
				const offset:int = opcodesTotal - 1;
				const opcode:ABCOpcode = opcodes[offset];
				const kind:ABCOpcodeKind = opcode.kind;
				switch(kind) {
					case ABCOpcodeKind.CONSTRUCTSUPER:
						const superMethod:IABCValueBuilder = JSValueBuilder.create(JSReservedKind.SUPER.type);
						const superName:Vector.<IABCWriteable> = createName(opcodes, opcode.attribute);
						const superArguments:Vector.<IABCWriteable> = createMethodArguments(opcodes, opcode.attribute);
						
						_stack.add(JSConsumableBlock.create(JSNameBuilder.create(superName), JSMethodCallBuilder.create(superMethod, superArguments)));
						break;
					
					case ABCOpcodeKind.PUSHSCOPE:
						_stack.add(JSNameBuilder.create(consume(opcodes, 0, offset), true));
						break;
					
					case ABCOpcodeKind.DEBUG:
					case ABCOpcodeKind.DEBUGFILE:
					case ABCOpcodeKind.DEBUGLINE:
						// do nothing here
						break;
					
					default:
						trace(kind);
						break;
				}
			}
			
			_stack.write(data);
		}
		
		private function consume(opcodes:Vector.<ABCOpcode>, start:uint, finish:uint):Vector.<IABCWriteable> {
			const result:Vector.<IABCWriteable> = new Vector.<IABCWriteable>();
			
			for(var i:uint=start; i<finish; i++) {
				const opcode:ABCOpcode = opcodes[i];
				const kind:ABCOpcodeKind = opcode.kind;
				
				switch(kind) {
					case ABCOpcodeKind.GETLOCAL_0:
						result.push(getLocal(0));
						break;
						
					default:
						break;
				}
			}
			
			return result;
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