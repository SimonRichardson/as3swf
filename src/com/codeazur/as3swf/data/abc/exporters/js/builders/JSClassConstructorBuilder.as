package com.codeazur.as3swf.data.abc.exporters.js.builders
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBody;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassConstructorBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOpcodeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOptionalParameterBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodParameterBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.parameters.JSMethodOptionalParameterBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.parameters.JSMethodParameterBuilder;
	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSClassConstructorBuilder implements IABCClassConstructorBuilder {
		
		private var _qname:ABCQualifiedName;
		private var _instanceInfo:ABCInstanceInfo;
		
		public function JSClassConstructorBuilder() {
			
		}
		
		public static function create(qname:ABCQualifiedName):JSClassConstructorBuilder {
			const builder:JSClassConstructorBuilder = new JSClassConstructorBuilder();
			builder.qname = qname;
			return builder; 
		}
		
		public function write(data:ByteArray):void {
			data.writeUTF(qname.fullName);
			
			JSTokenKind.EQUALS.write(data);
			
			data.writeUTF(_instanceInfo.superMultiname.fullName);
			
			JSTokenKind.DOT.write(data);
			JSReservedKind.EXTENDS.write(data);
			JSTokenKind.LEFT_PARENTHESES.write(data);
			JSTokenKind.LEFT_CURLY_BRACKET.write(data);
			
			JSReservedKind.CONSTRUCTOR.write(data);
			JSTokenKind.COLON.write(data);
			JSReservedKind.FUNCTION.write(data);
			JSTokenKind.LEFT_PARENTHESES.write(data);
			
			const instanceInitialiser:ABCMethodInfo = instanceInfo.instanceInitialiser;
			const parameters:Vector.<ABCParameter> = instanceInitialiser.parameters;
			
			const parameterBuilder:IABCMethodParameterBuilder = JSMethodParameterBuilder.create(parameters);
			parameterBuilder.write(data);
			
			JSTokenKind.RIGHT_PARENTHESES.write(data);
			JSTokenKind.LEFT_CURLY_BRACKET.write(data);
			
			// These are no longer parameters, but are in fact arguments now.
			const args:Vector.<ABCParameter> = parameterBuilder.parameters;
			
			const optionalParameterBuilder:IABCMethodOptionalParameterBuilder = JSMethodOptionalParameterBuilder.create(args);
			optionalParameterBuilder.write(data);
			
			const methodBody:ABCMethodBody = instanceInitialiser.methodBody;
			const returnType:IABCMultiname = instanceInitialiser.returnType;
			
			const needsRest:Boolean = instanceInitialiser.needRest;
			const needsArguments:Boolean = instanceInitialiser.needArguments;
			
			const opcode:IABCMethodOpcodeBuilder = JSMethodOpcodeBuilder.create(args, methodBody, returnType);
			opcode.needsRest = needsRest;
			opcode.needsArguments = needsArguments;
			opcode.write(data);
			
			JSTokenKind.RIGHT_CURLY_BRACKET.write(data);
		}
		
		public function get qname():ABCQualifiedName { return _qname; }
		public function set qname(value:ABCQualifiedName) : void { _qname = value; }
		
		public function get instanceInfo():ABCInstanceInfo { return _instanceInfo; }
		public function set instanceInfo(value:ABCInstanceInfo):void { _instanceInfo = value; }
		
		public function get name():String { return "JSClassConstructorBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
