package com.codeazur.as3swf.data.abc.exporters.builders.js
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespaceType;
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodNameBuilder;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMethodBuilder implements IABCMethodBuilder {
		
		private var _methodInfo:ABCMethodInfo;
		
		public function JSMethodBuilder() {}
		
		public static function create(methodInfo:ABCMethodInfo):JSMethodBuilder {
			const builder:JSMethodBuilder = new JSMethodBuilder();
			builder.methodInfo = methodInfo;
			return builder; 
		}
		
		public function write(data:ByteArray):void {
			const qname:ABCQualifiedName = ABCQualifiedName.create(methodInfo.methodName, ABCNamespaceType.ASTERISK.ns);
			const methodBuilder:IABCMethodNameBuilder = JSMethodNameBuilder.create(qname);
			methodBuilder.write(data);
			
			JSTokenKind.EQUALS.write(data);
			JSReservedKind.FUNCTION.write(data);
			JSTokenKind.LEFT_PARENTHESES.write(data);
			
			// TODO
			
			JSTokenKind.RIGHT_PARENTHESES.write(data);
			JSTokenKind.LEFT_CURLY_BRACKET.write(data);
			
			// TODO
			JSReservedKind.VAR.write(data);
			JSTokenKind.SEMI_COLON.write(data);
			
			JSTokenKind.RIGHT_CURLY_BRACKET.write(data);
			JSTokenKind.SEMI_COLON.write(data);
		}
		
		public function get methodInfo():ABCMethodInfo { return _methodInfo; }
		public function set methodInfo(value:ABCMethodInfo):void { _methodInfo = value; }
		
		public function get name():String { return "JSMethodBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
