package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSThisArgumentBuilder;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespace;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespaceKind;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCPropertyBuilder;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSPropertyBuilder implements IABCPropertyBuilder
	{

		private var _qname:ABCQualifiedName;
		
		private var _expressions:Vector.<IABCWriteable>;

		public function JSPropertyBuilder() {
		}
		
		public static function create(qname:ABCQualifiedName, expressions:Vector.<IABCWriteable>):JSPropertyBuilder {
			const builder:JSPropertyBuilder = new JSPropertyBuilder();
			builder.qname = qname;
			builder.expressions = expressions;
			return builder; 
		}

		public function write(data : ByteArray) : void {
			const ns:ABCNamespace = qname.ns;
			if( ABCNamespaceKind.isType(ns.kind, ABCNamespaceKind.PRIVATE_NAMESPACE) ||
				ABCNamespaceKind.isType(ns.kind, ABCNamespaceKind.PROTECTED_NAMESPACE)) {
				JSReservedKind.THIS.write(data);
				JSTokenKind.DOT.write(data);
				JSTokenKind.UNDERSCORE.write(data);
				JSTokenKind.DOT.write(data);
				
				data.writeUTF(qname.label);
			} else {
				throw new Error();
			}
			
			if(expressions) {
				JSTokenKind.EQUALS.write(data);
				
				if(expressions.length == 1 && expressions[0] is JSConsumableBlock) {
					const block:JSConsumableBlock = JSConsumableBlock(expressions[0]);
					if(block.left is JSThisArgumentBuilder && block.right) {
						if(block.right is JSMethodCallBuilder) {
							JSReservedKind.NEW.write(data);
							JSTokenKind.SPACE.write(data);
						}
						
						block.right.write(data);
					} else {
						throw new Error();
					}
				} else if(expressions.length == 2){
					if(expressions[0] is JSThisArgumentBuilder) {
						expressions[1].write(data);
					} else {
						throw new Error();
					}
				} else {
					throw new Error();
				}
			}
		}
		
		public function get qname():ABCQualifiedName { return _qname; }
		public function set qname(value:ABCQualifiedName):void { _qname = value; }
		
		public function get expressions():Vector.<IABCWriteable> { return _expressions; }
		public function set expressions(value:Vector.<IABCWriteable>):void { _expressions = value; }
		
		public function get name():String { return "JSPropertyBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
