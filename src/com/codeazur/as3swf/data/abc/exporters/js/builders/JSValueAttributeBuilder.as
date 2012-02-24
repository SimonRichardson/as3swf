package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeMultinameUIntAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedNameType;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSValueAttributeBuilder implements IABCValueBuilder {
		
		public var attribute:ABCOpcodeAttribute;
		
		private var _value:*;
		private var _qname:ABCQualifiedName;
		
		public function JSValueAttributeBuilder() {
		}
		
		public static function create(attribute:ABCOpcodeAttribute):JSValueAttributeBuilder {
			const builder:JSValueAttributeBuilder = new JSValueAttributeBuilder();
			builder.attribute = attribute;
			return builder;
		}
		
		public function write(data:ByteArray):void {
			if(attribute is ABCOpcodeMultinameUIntAttribute) {
				const mname:ABCOpcodeMultinameUIntAttribute = ABCOpcodeMultinameUIntAttribute(attribute);
				const qname:ABCQualifiedName = mname.multiname.toQualifiedName();
				if(ABCQualifiedNameType.isType(qname, ABCQualifiedNameType.APPLY) ||
					ABCQualifiedNameType.isType(qname, ABCQualifiedNameType.TO_STRING)) {
					data.writeUTF(qname.label);
				} else {
					data.writeUTF(qname.fullName);
				}
			} else {
				throw new Error();
			}
		}
		
		public function get value():* { return _value; }
		public function set value(data:*):void { _value = data; }
		
		public function get qname():ABCQualifiedName { return _qname; }
		public function set qname(value:ABCQualifiedName) : void { _qname = value; }
		
		public function get name():String { return "JSValueAttributeBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
