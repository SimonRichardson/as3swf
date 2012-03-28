package com.codeazur.as3swf.data.abc.tools
{
	import flash.utils.getTimer;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfoKind;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.ABCExceptionInfoSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBody;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfoFlags;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeMultinameAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeMultinameUIntAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedNameBuilder;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfoFactory;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitMethodInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCRemoveTraceOpcodes implements IABCVistor {
		
		private static const TRACE_NAME:String = "trace";
		
		private static const NULL_TRACE_NAME:String = "NullTrace";
		
		public function ABCRemoveTraceOpcodes() {
		}

		public function visit(value : ABCData) : void {
			const total:uint = value.methodBodySet.length;
			for(var i:uint=0; i<total; i++){
				const traceOpcodes:Vector.<ABCOpcode> = new Vector.<ABCOpcode>();
				
				const methodBody:ABCMethodBody = value.methodBodySet.getAt(i);
				const opcodes:ABCOpcodeSet = methodBody.opcodes;
				var multiname:IABCMultiname;
				var index:int = opcodes.length;
				while(--index>-1) {
					const opcode:ABCOpcode = opcodes.getAt(index);
					const kind:ABCOpcodeKind = opcode.kind;
					const attribute:ABCOpcodeAttribute = opcode.attribute;
					if(ABCOpcodeKind.isType(kind, ABCOpcodeKind.FINDPROPSTRICT)) {
						if(attribute is ABCOpcodeMultinameAttribute) {
							const multinameAttribute:ABCOpcodeMultinameAttribute = ABCOpcodeMultinameAttribute(attribute);
							multiname = multinameAttribute.multiname;
							if(multiname.fullName == TRACE_NAME) {
								const getLocal0:ABCOpcode = ABCOpcode.create(abcData, ABCOpcodeKind.GETLOCAL_0, ABCOpcodeAttribute.create(abcData));
								opcodes.opcodes.splice(index, 1, getLocal0);
							}
						}
					} else if(ABCOpcodeKind.isType(kind, ABCOpcodeKind.CALLPROPERTY)) {
						if(attribute is ABCOpcodeMultinameUIntAttribute) {
							const multinameUIntAttribute:ABCOpcodeMultinameUIntAttribute = ABCOpcodeMultinameUIntAttribute(attribute);
							multiname = multinameUIntAttribute.multiname;
							if(multiname.fullName == TRACE_NAME) {
								traceOpcodes.push(opcode);
							}
						}
					}
				}
				
				// Inject a new method into the mix
				const traceTotal:uint = traceOpcodes.length;
				if(traceTotal > 0) {
					const abcData:ABCData = methodBody.abcData;
					const empty:ABCMethodBody = ABCMethodBody.create(methodBody.abcData);
					
					// TODO: change this so that we can use a builder.
					empty.methodInfo = ABCMethodInfo.create(abcData);
					empty.methodInfo.returnType = ABCQualifiedNameBuilder.create("void");
					empty.methodInfo.methodNameLabel = NULL_TRACE_NAME + getTimer();
					empty.methodInfo.scopeName = methodBody.methodInfo.scopeName;
					empty.methodInfo.methodName = empty.methodInfo.scopeName + "/" + empty.methodInfo.methodNameLabel;
					empty.methodInfo.multiname = ABCQualifiedNameBuilder.create(empty.methodInfo.methodName);
					empty.methodInfo.methodBody = empty;
					empty.methodInfo.flags = ABCMethodInfoFlags.NEED_REST.type;
					empty.methodInfo.parameters = new Vector.<ABCParameter>();
					
					empty.exceptionInfo = ABCExceptionInfoSet.create(abcData);
					
					empty.maxStack = 1;
					empty.localCount = 1;
					empty.initScopeDepth = 9;
					empty.maxScopeDepth = 10;
					
					empty.opcodes = ABCOpcodeSet.create(abcData);
					empty.opcodes.opcodes.push(ABCOpcode.create(abcData, ABCOpcodeKind.GETLOCAL_0, ABCOpcodeAttribute.create(abcData)));
					empty.opcodes.opcodes.push(ABCOpcode.create(abcData, ABCOpcodeKind.PUSHSCOPE, ABCOpcodeAttribute.create(abcData)));
					
					value.methodBodySet.addAt(empty, value.methodBodySet.length - 1);
					
					const traitQName:IABCMultiname = ABCQualifiedNameBuilder.create(empty.methodInfo.methodNameLabel);
					abcData.constantPool.addMultiname(traitQName);
					const trait:ABCTraitMethodInfo = ABCTraitMethodInfo(ABCTraitInfoFactory.create(abcData, ABCTraitInfoKind.METHOD.type, traitQName));
					trait.id = 1;
					trait.methodInfo = empty.methodInfo;
					
					for(var k:uint=0; k<value.instanceInfoSet.length; k++) {
						const instanceInfo:ABCInstanceInfo = value.instanceInfoSet.getAt(k);
						if(instanceInfo.qname.fullName == methodBody.methodInfo.scopeName) {
							instanceInfo.addTrait(trait);
							break;
						}
					}
					
					// Create a new multiname
					for(var j:uint=0; j<traceTotal; j++) {
						const traceOpcode:ABCOpcode = traceOpcodes[j];
						if(traceOpcode.attribute is ABCOpcodeMultinameUIntAttribute) {
							const traceMultinameAttribute:ABCOpcodeMultinameUIntAttribute = ABCOpcodeMultinameUIntAttribute.create(abcData);
							traceMultinameAttribute.multiname = traitQName;
							traceMultinameAttribute.numArguments = ABCOpcodeMultinameUIntAttribute(traceOpcode.attribute).numArguments;
							traceOpcode.attribute = traceMultinameAttribute;
						}
					}
				}
			}
		}
	}
}
