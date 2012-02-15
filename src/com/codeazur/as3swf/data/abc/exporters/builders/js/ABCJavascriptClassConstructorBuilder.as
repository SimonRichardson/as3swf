package com.codeazur.as3swf.data.abc.exporters.builders.js
{

	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOpcodeBuilder;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassConstructorBuilder;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCJavascriptClassConstructorBuilder implements IABCClassConstructorBuilder {
		
		private var _qname:ABCQualifiedName;
		private var _instanceInfo:ABCInstanceInfo;
		
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
			ABCJavascriptReservedKind.FUNCTION.write(data);
			ABCJavascriptTokenKind.LEFT_PARENTHESES.write(data);
			
			// TODO:arguments
			
			ABCJavascriptTokenKind.RIGHT_PARENTHESES.write(data);
			ABCJavascriptTokenKind.LEFT_CURLY_BRACKET.write(data);
			
			const opcode:IABCMethodOpcodeBuilder = ABCJavascriptMethodOpcodeBuilder.create();
			opcode.write(data);
			
			ABCJavascriptTokenKind.RIGHT_CURLY_BRACKET.write(data);
			ABCJavascriptTokenKind.SEMI_COLON.write(data);
		}

		public function get qname():ABCQualifiedName { return _qname; }
		public function set qname(value:ABCQualifiedName) : void { _qname = value; }
		
		public function get instanceInfo():ABCInstanceInfo { return _instanceInfo; }
		public function set instanceInfo(value:ABCInstanceInfo):void { _instanceInfo = value; }
		
		public function get name():String { return "ABCJavascriptClassConstructorBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
