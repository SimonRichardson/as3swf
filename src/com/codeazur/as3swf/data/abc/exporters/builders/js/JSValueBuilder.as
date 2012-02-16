package com.codeazur.as3swf.data.abc.exporters.builders.js
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedNameType;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSValueBuilder implements IABCValueBuilder {
		
		private var _value:*;
		private var _qname:ABCQualifiedName;
		
		public function JSValueBuilder() {
		}
		
		public static function create(value:*, qname:ABCQualifiedName = null):JSValueBuilder {
			const builder:JSValueBuilder = new JSValueBuilder();
			builder.value = value;
			builder.qname = qname;
			return builder;
		}
		
		public function write(data:ByteArray):void {
			if(null != qname && ABCQualifiedNameType.isType(qname, ABCQualifiedNameType.STRING)) {
											
				JSTokenKind.DOUBLE_QUOTE.write(data);
				data.writeUTF(value);
				JSTokenKind.DOUBLE_QUOTE.write(data);
				
			} else {
				data.writeUTF(value);
			}
		}
		
		public function get value():* { return _value; }
		public function set value(data:*):void { _value = data; }
		
		public function get qname():ABCQualifiedName { return _qname; }
		public function set qname(value:ABCQualifiedName) : void { _qname = value; }
		
		public function get name():String { return "JSValueBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
		
	}
}
