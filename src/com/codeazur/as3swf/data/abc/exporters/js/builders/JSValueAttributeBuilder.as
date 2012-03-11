package com.codeazur.as3swf.data.abc.exporters.js.builders
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeMultinameAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeMultinameUIntAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCMultinameBuiltin;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.utils.StringUtils;

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
			const qname:ABCQualifiedName = getQName(attribute);
			if(qname) {
				if(ABCMultinameBuiltin.isBuiltin(qname)) {
					data.writeUTF(qname.label);
				} else {
					data.writeUTF(qname.fullName);
				}
			} else {
				throw new Error();
			}
		}
		
		private function getQName(attribute:ABCOpcodeAttribute):ABCQualifiedName {
			var result:ABCQualifiedName;
			if(attribute is ABCOpcodeMultinameAttribute) {
				result = ABCOpcodeMultinameAttribute(attribute).multiname.toQualifiedName();
			} else if(attribute is ABCOpcodeMultinameUIntAttribute) {
				result = ABCOpcodeMultinameUIntAttribute(attribute).multiname.toQualifiedName();
			} 
			return result;
		}
		
		public function get value():* { return _value; }
		public function set value(data:*):void { _value = data; }
		
		public function get qname():ABCQualifiedName { return _qname; }
		public function set qname(value:ABCQualifiedName) : void { _qname = value; }
		
		public function get name():String { return "JSValueAttributeBuilder"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Value:" + value;
			
			if(_qname) {
				str += "\n" + StringUtils.repeat(indent + 2) + "QName:";
				str += "\n" + _qname.toString(indent + 4);
			}
			
			return str;
		}
	}
}
