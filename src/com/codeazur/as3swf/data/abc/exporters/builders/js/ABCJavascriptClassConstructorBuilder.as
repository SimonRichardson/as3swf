package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassConstructorBuilder;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCJavascriptClassConstructorBuilder implements IABCClassConstructorBuilder {
		
		private var _qname:ABCQualifiedName;
		
		public function ABCJavascriptClassConstructorBuilder() {
			
		}
		
		public static function create(qname:ABCQualifiedName):ABCJavascriptClassConstructorBuilder {
			const builder:ABCJavascriptClassConstructorBuilder = new ABCJavascriptClassConstructorBuilder();
			builder.qname = qname;
			return builder; 
		}
		
		public function write(data:ByteArray):void {
			data.writeUTF(qname.fullName);
			
			ABCJavascriptTokenKind.EQUALS.write(data);
			ABCJavascriptLiteralKind.FUNCTION.write(data);
			
			ABCJavascriptTokenKind.SEMI_COLON.write(data);
		}

		public function get qname():ABCQualifiedName { return _qname; }
		public function set qname(value:ABCQualifiedName) : void { _qname = value; }
		
		public function get name():String { return "ABCJavascriptClassConstructorBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
