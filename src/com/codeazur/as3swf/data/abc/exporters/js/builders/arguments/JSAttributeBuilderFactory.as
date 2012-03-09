package com.codeazur.as3swf.data.abc.exporters.js.builders.arguments
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespaceKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitConstInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitInfoKind;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeDoubleAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeMultinameAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeMultinameUIntAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeStringAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.IABCOpcodeIntegerAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.IABCOpcodeUnsignedIntegerAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCBaseMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedNameType;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCAttributeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSAttributeBuilderFactory
	{
		
		public static function create(traits:Vector.<ABCTraitInfo>, attribute:ABCOpcodeAttribute):IABCAttributeBuilder {
			var builder:IABCAttributeBuilder = null;
			if(attribute is IABCOpcodeIntegerAttribute) { 
				
				const intAttr:IABCOpcodeIntegerAttribute = IABCOpcodeIntegerAttribute(attribute);
				builder = JSIntegerArgumentBuilder.create(intAttr.integer);
			
			} else if(attribute is IABCOpcodeUnsignedIntegerAttribute) {
				
				const uintAttr:IABCOpcodeUnsignedIntegerAttribute = IABCOpcodeUnsignedIntegerAttribute(attribute);
				builder = JSUnsignedIntegerArgumentBuilder.create(uintAttr.unsignedInteger);
				
			} else if(attribute is ABCOpcodeStringAttribute) {
				
				const strAttr:ABCOpcodeStringAttribute = ABCOpcodeStringAttribute(attribute);
				builder = JSStringArgumentBuilder.create(strAttr.string);
				
			} else if(attribute is ABCOpcodeDoubleAttribute) {
				
				const doubleAttr:ABCOpcodeDoubleAttribute = ABCOpcodeDoubleAttribute(attribute);
				builder = JSFloatArgumentBuilder.create(doubleAttr.double);
				
			} else if(attribute is ABCOpcodeMultinameAttribute) {
				
				const mnameAttr:ABCOpcodeMultinameAttribute = ABCOpcodeMultinameAttribute(attribute);
				if(mnameAttr.multiname is ABCQualifiedName) {
					builder = createBuilderFromQName(traits, mnameAttr.multiname.toQualifiedName());
				} else {
					throw new Error(attribute);
				}
				
			} else if(attribute is ABCOpcodeMultinameUIntAttribute) {
				
				const mnameUIntAttr:ABCOpcodeMultinameUIntAttribute = ABCOpcodeMultinameUIntAttribute(attribute);
				if(mnameUIntAttr.multiname is ABCQualifiedName) {
					builder = createBuilderFromQName(traits, mnameUIntAttr.multiname.toQualifiedName());
				} else {
					throw new Error(attribute);
				}
				
			}  else {
				throw new Error(attribute);
			}
			
			return builder;					
		}
		
		private static function createBuilderFromQName(traits:Vector.<ABCTraitInfo>, qname:ABCQualifiedName):IABCAttributeBuilder {
			var builder:IABCAttributeBuilder = null;
					
			if(ABCNamespaceKind.isType(qname.ns.kind, ABCNamespaceKind.PACKAGE_NAMESPACE)) {
				const trait:ABCTraitInfo = getTraitFromQName(traits, qname);
				if(trait) {
					if(trait is ABCTraitConstInfo) {
						const constTrait:ABCTraitConstInfo = ABCTraitConstInfo(trait);
						const constQName:ABCQualifiedName = constTrait.typeMultiname.toQualifiedName();
						builder = createBuilderFromQNameString(constQName.fullName, constTrait.defaultValue);
					} else {
						throw new Error(trait);
					}
				}
				
			} else if(ABCNamespaceKind.isType(qname.ns.kind, ABCNamespaceKind.PRIVATE_NAMESPACE) ||
						ABCNamespaceKind.isType(qname.ns.kind, ABCNamespaceKind.PROTECTED_NAMESPACE)) {
				
				qname.ns.value = JSTokenKind.UNDERSCORE.type;
				builder = JSMultinameArgumentBuilder.create(qname);
				
			} else if(ABCNamespaceKind.isType(qname.ns.kind, ABCNamespaceKind.NAMESPACE)) {
				
				if(ABCQualifiedNameType.isBuiltin(qname)) {
					builder = JSMultinameArgumentBuilder.create(qname);
				} else {
					throw new Error(qname);
				}
				
			} else {
				throw new Error(qname.ns.kind);
			}
		
			// Return with a valid builder if none found
			if(!builder) {
				builder = JSMultinameArgumentBuilder.create(qname);
			}
			
			return builder;
		}
		
		private static function createBuilderFromQNameString(name:String, value:*):IABCAttributeBuilder {
			var builder:IABCAttributeBuilder = null;
			if(ABCQualifiedNameType.isNameType(name,  ABCQualifiedNameType.INT)) {
				builder = JSIntegerArgumentBuilder.create(value);
			} else if(ABCQualifiedNameType.isNameType(name,  ABCQualifiedNameType.UINT)) {
				builder = JSUnsignedIntegerArgumentBuilder.create(value);
			} else if(ABCQualifiedNameType.isNameType(name,  ABCQualifiedNameType.STRING)) {
				builder = JSStringArgumentBuilder.create(value);
			} else {
				throw new Error(name);
			}
			return builder;
		}
		
		private static function getTraitFromQName(traits:Vector.<ABCTraitInfo>, qname:ABCQualifiedName):ABCTraitInfo {
			var result:ABCTraitInfo = null;
						
			const total:uint = traits.length;
			for(var i:uint=0; i<total; i++) {
				const trait:ABCTraitInfo = traits[i];
				if(ABCTraitInfoKind.isType(trait.kind, ABCTraitInfoKind.CONST)) {
					if(ABCBaseMultiname.equals(trait.qname, qname)) {
						result = trait;
						break;
					}
				}
			}
			
			return result;
		}
		
		public static function getNumberArguments(attribute:ABCOpcodeAttribute):uint {
			var numArguments:uint = 0;
			if(attribute is ABCOpcodeMultinameUIntAttribute){
				numArguments = ABCOpcodeMultinameUIntAttribute(attribute).numArguments;
			} else if(attribute is IABCOpcodeIntegerAttribute){
				numArguments = IABCOpcodeIntegerAttribute(attribute).integer;
			} else if(attribute is IABCOpcodeUnsignedIntegerAttribute){
				numArguments = IABCOpcodeUnsignedIntegerAttribute(attribute).unsignedInteger;
			}
			return numArguments;
		}
	}
}
