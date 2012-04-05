package com.codeazur.as3swf.data.abc.tools
{
	import com.codeazur.as3swf.data.abc.utils.getQualifiedNameFullPath;
	import com.codeazur.as3swf.data.abc.utils.getMethodName;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCDataSet;
	import com.codeazur.as3swf.data.abc.ABC_PREFIX;
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
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCMultinameBuiltin;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceKind;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceType;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedNameBuilder;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfoFactory;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfoFlags;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfoKind;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitMethodInfo;
	import com.codeazur.as3swf.data.abc.utils.NAMESPACE_SEPARATOR;
	import com.codeazur.as3swf.data.abc.utils.getScopeName;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCRemoveTraceOpcodes implements IABCVistor {
		
		private static const TRACE_NAME:String = "trace";
		
		private static const NULL_TRACE_NAME:String = ABC_PREFIX + "NullTrace";
		
		private var _abcDataSet:ABCDataSet;
		
		public function ABCRemoveTraceOpcodes(abcDataSet:ABCDataSet) {
			_abcDataSet = abcDataSet;
		}

		public function visit(abcData : ABCData) : void {
			const total:uint = abcData.methodBodySet.length;
			for(var i:uint=0; i<total; i++){
				const traceOpcodes:Vector.<ABCOpcode> = new Vector.<ABCOpcode>();
				
				const methodBody:ABCMethodBody = abcData.methodBodySet.getAt(i);
				if(!methodBody.hasAlchemyOpcodes) {
					const methodInfo:ABCMethodInfo = methodBody.methodInfo;
					// Make sure we don't do this on a invalid item
					if(	methodInfo.methodName == "" ||
						methodInfo.methodName == ABCNamespaceType.ASTERISK.ns.value || 
						methodInfo.multiname && methodInfo.multiname.equals(ABCMultinameBuiltin.ANY)) {
						continue;
					}

					const scopeName:String = methodInfo.scopeName;
					const qname:ABCQualifiedName = ABCQualifiedNameBuilder.create(scopeName);
					const instanceInfo:ABCInstanceInfo = _abcDataSet.getInstanceInfoByMultiname(qname);
					
					if(!instanceInfo) {
						throw new Error('Invalid Instance Info (' + scopeName + ')');
					}
					
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
						const traitQName:IABCMultiname = createEmptyMethod(abcData, instanceInfo);
						
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
		
		private function createEmptyMethod(abcData:ABCData, instanceInfo:ABCInstanceInfo):IABCMultiname {
			// FIXME (Simon) This needs updating.
			// Seems we already have a null trace method, use it!
			const instanceQName:ABCQualifiedName = instanceInfo.multiname.toQualifiedName();
			const traitName:String = getQualifiedNameFullPath(instanceQName.ns, NULL_TRACE_NAME);
			const traitQName:IABCMultiname = ABCQualifiedNameBuilder.create(traitName, ABCNamespaceKind.PROTECTED_NAMESPACE.type);
			if(instanceInfo.hasTrait(ABCTraitInfoKind.METHOD, traitQName)) {
				return traitQName;
			}
			
			// TODO: change this so that we can use a builder.
			const empty:ABCMethodBody = ABCMethodBody.create(abcData);
			
			const normalised:String = traitQName.fullPath;
			
			empty.methodInfo = ABCMethodInfo.create(abcData);
			empty.methodInfo.returnType = ABCQualifiedNameBuilder.create("void");
			empty.methodInfo.label = normalised;
			empty.methodInfo.scopeName = getScopeName(normalised);
			empty.methodInfo.methodName = getMethodName(normalised);
			empty.methodInfo.multiname = traitQName;
			empty.methodInfo.methodBody = empty;
			empty.methodInfo.flags = ABCMethodInfoFlags.NEED_REST.type ^ ABCMethodInfoFlags.HAS_PARAM_NAMES.type;
			empty.methodInfo.parameters = new Vector.<ABCParameter>();
			
			empty.exceptionInfo = ABCExceptionInfoSet.create(abcData);
			
			empty.maxStack = 1;
			empty.localCount = 2;
			empty.initScopeDepth = 9;
			empty.maxScopeDepth = 10;
			
			empty.opcodes = ABCOpcodeSet.create(abcData);
			empty.opcodes.opcodes.push(ABCOpcode.create(abcData, ABCOpcodeKind.GETLOCAL_0, ABCOpcodeAttribute.create(abcData)));
			empty.opcodes.opcodes.push(ABCOpcode.create(abcData, ABCOpcodeKind.PUSHSCOPE, ABCOpcodeAttribute.create(abcData)));
			empty.opcodes.opcodes.push(ABCOpcode.create(abcData, ABCOpcodeKind.RETURNVOID, ABCOpcodeAttribute.create(abcData)));
			
			abcData.methodBodySet.addAt(empty, abcData.methodBodySet.length - 1);
			
			abcData.constantPool.addMultiname(traitQName);
			
			const trait:ABCTraitMethodInfo = ABCTraitMethodInfo(ABCTraitInfoFactory.create(abcData, ABCTraitInfoKind.METHOD.type, traitQName));
			trait.id = 0;
			trait.methodInfo = empty.methodInfo;
			
			if(hasTrait(instanceInfo, traitQName)) {
				empty.initScopeDepth = 10;
				empty.maxScopeDepth = 11;
				
				trait.kind ^= ABCTraitInfoFlags.OVERRIDE.type << 4;
			}
			
			instanceInfo.addTrait(trait);
			
			return traitQName;
		}
		
		private function hasTrait(info:ABCInstanceInfo, traitQName:IABCMultiname):Boolean {
			if(info && info.superMultiname) {
				const superInfo:ABCInstanceInfo = _abcDataSet.getInstanceInfoByMultiname(info.superMultiname);
				if(superInfo) {
					if(superInfo.hasTraitByMultinameName(ABCTraitInfoKind.METHOD, traitQName)) {
						return true;
					} else {
						return hasTrait(superInfo, traitQName);
					}
				}
			}
			
			return false;
		}
	}
}
