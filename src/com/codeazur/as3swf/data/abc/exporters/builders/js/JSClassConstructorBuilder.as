package com.codeazur.as3swf.data.abc.exporters.builders.js
{

	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBody;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.matchers.JSStringNotEmptyMatcher;
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedNameType;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMatcher;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.matchers.JSNotNullMatcher;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassConstructorBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOpcodeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCTernaryBuilder;
	import com.codeazur.utils.StringUtils;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSClassConstructorBuilder implements IABCClassConstructorBuilder {
		
		public static const DEFAULT_PARAMETER_NAME:String = "value";
		
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
			JSReservedKind.FUNCTION.write(data);
			JSTokenKind.LEFT_PARENTHESES.write(data);
			
			const instanceInitialiser:ABCMethodInfo = instanceInfo.instanceInitialiser;
			const parameters:Vector.<ABCParameter> = instanceInitialiser.parameters;
			
			var parameter:ABCParameter;
			var parameterName:String;
			var parameterQName:ABCQualifiedName;
			var parameterDefaultValue:String;
			
			const total:uint = parameters.length;
			for(var i:uint=0; i<total; i++) {
				parameter = parameters[i];
				parameterName = getParameterName(parameter.label, i);
				
				data.writeUTF(parameterName);
									
				if(i < total - 1) {
					JSTokenKind.COMMA.write(data);
				}
			}
			
			JSTokenKind.RIGHT_PARENTHESES.write(data);
			JSTokenKind.LEFT_CURLY_BRACKET.write(data);
			
			for(var j:uint=0; j<total; j++) {
				parameter = parameters[j];
				if(parameter.optional) {
					parameterName = StringUtils.isEmpty(parameter.label) ? DEFAULT_PARAMETER_NAME + i : parameter.label;
					parameterQName = parameter.qname.toQualifiedName();
					parameterDefaultValue = parameter.defaultValue;
					
					JSReservedKind.VAR.write(data);
					JSTokenKind.SPACE.write(data);
					
					data.writeUTF(parameterName);
					
					JSTokenKind.EQUALS.write(data);
					
					const value:IABCValueBuilder = JSValueBuilder.create(parameterName);
					const defaultValue:IABCValueBuilder = JSValueBuilder.create(parameterDefaultValue, parameterQName);
					
					var matcher:IABCMatcher;
					if(ABCQualifiedNameType.isType(parameterQName, ABCQualifiedNameType.STRING)){
						matcher = JSStringNotEmptyMatcher.create(value);	
					} else {
						matcher = JSNotNullMatcher.create(value);
					}
					
					const ternary:IABCTernaryBuilder = JSTernaryBuilder.create(matcher, value, defaultValue);
					ternary.write(data);
					
					JSTokenKind.SEMI_COLON.write(data);
				}
			}
			
			const methodBody:ABCMethodBody = instanceInitialiser.methodBody;
			const returnType:IABCMultiname = instanceInitialiser.returnType;
			
			const opcode:IABCMethodOpcodeBuilder = JSMethodOpcodeBuilder.create(parameters, methodBody, returnType);
			opcode.write(data);
			
			JSTokenKind.RIGHT_CURLY_BRACKET.write(data);
			JSTokenKind.SEMI_COLON.write(data);
		}
		
		private function getParameterName(label:String, index:uint):String {
			return StringUtils.isEmpty(label) ? DEFAULT_PARAMETER_NAME + index : label;
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
