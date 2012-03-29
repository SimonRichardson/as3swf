package com.codeazur.as3swf.data.abc.tools
{
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceKind;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceType;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.ABCExceptionInfoSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
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
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedNameBuilder;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfoFactory;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfoFlags;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfoKind;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitMethodInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCRemoveTraceOpcodes implements IABCVistor {
		
		private static const TRACE_NAME:String = "trace";
		
		private static const NULL_TRACE_NAME:String = "NullTrace";
		
		public function ABCRemoveTraceOpcodes() {
		}

		public function visit(abcData : ABCData) : void {
			const total:uint = abcData.methodBodySet.length;
			for(var i:uint=0; i<total; i++){
				const traceOpcodes:Vector.<ABCOpcode> = new Vector.<ABCOpcode>();
				
				const methodBody:ABCMethodBody = abcData.methodBodySet.getAt(i);
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
								// Swap out the findpropstrict for a getlocal0
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
					const traitQName:IABCMultiname = createEmptyMethod(abcData, methodBody.methodInfo.scopeName);
					
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
		
		private function createEmptyMethod(abcData:ABCData, scopeName:String):IABCMultiname {
			const qname:ABCQualifiedName = ABCQualifiedNameBuilder.create(scopeName);
			const instanceInfo:ABCInstanceInfo = abcData.instanceInfoSet.getByMultiname(qname);
			
			if(!instanceInfo) {
				throw new Error('Invalid Instance Info');
			}
			
			// Seems we already have a null trace method, use it!
			const traitQName:IABCMultiname = ABCQualifiedNameBuilder.create(NULL_TRACE_NAME, ABCNamespaceKind.PRIVATE_NAMESPACE.type);
			if(instanceInfo.hasTrait(ABCTraitInfoKind.METHOD, traitQName)) {
				return traitQName;
			}
			
			// TODO: change this so that we can use a builder.
			const empty:ABCMethodBody = ABCMethodBody.create(abcData);
			
			empty.methodInfo = ABCMethodInfo.create(abcData);
			empty.methodInfo.returnType = ABCQualifiedNameBuilder.create("void");
			empty.methodInfo.methodNameLabel = traitQName.fullName;
			empty.methodInfo.scopeName = scopeName;
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
			
			abcData.methodBodySet.addAt(empty, abcData.methodBodySet.length - 1);
			
			abcData.constantPool.addMultiname(traitQName);
			const trait:ABCTraitMethodInfo = ABCTraitMethodInfo(ABCTraitInfoFactory.create(abcData, ABCTraitInfoKind.METHOD.type, traitQName));
			trait.id = 1;
			trait.methodInfo = empty.methodInfo;
			
			instanceInfo.addTrait(trait);
			
			return traitQName;
		}
	}
}
