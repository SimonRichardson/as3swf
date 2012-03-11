package com.codeazur.as3swf.data.abc.exporters.js.builders.arguments
{
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeDoubleAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeMultinameAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeMultinameUIntAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeStringAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.IABCOpcodeIntegerAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.IABCOpcodeUnsignedIntegerAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCAttributeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSNamespaceFactory;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSAttributeFactory
	{
		
		public static function create(attribute:ABCOpcodeAttribute):IABCAttributeBuilder {
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
				builder = JSNumberArgumentBuilder.create(doubleAttr.double);
				
			} else if(attribute is ABCOpcodeMultinameAttribute) {
				
				const mnameAttr:ABCOpcodeMultinameAttribute = ABCOpcodeMultinameAttribute(attribute);
				if(mnameAttr.multiname is ABCQualifiedName) {
					builder = JSNamespaceFactory.create(mnameAttr.multiname.toQualifiedName());
				} else {
					throw new Error(attribute);
				}
				
			} else if(attribute is ABCOpcodeMultinameUIntAttribute) {
				
				const mnameUIntAttr:ABCOpcodeMultinameUIntAttribute = ABCOpcodeMultinameUIntAttribute(attribute);
				if(mnameUIntAttr.multiname is ABCQualifiedName) {
					builder = JSNamespaceFactory.create(mnameUIntAttr.multiname.toQualifiedName());
				} else {
					trace(mnameUIntAttr.multiname);
					throw new Error(attribute);
				}
				
			}  else {
				throw new Error(attribute);
			}
			
			return builder;					
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
