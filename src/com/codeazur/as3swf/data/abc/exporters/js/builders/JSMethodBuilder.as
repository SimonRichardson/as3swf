package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfo;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodNameBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOpcodeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOptionalParameterBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodParameterBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.parameters.JSMethodOptionalParameterBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.parameters.JSMethodParameterBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.translator.JSOpcodeTranslatorOptimizer;
	import com.codeazur.as3swf.data.abc.exporters.translator.ABCOpcodeTranslateData;
	import com.codeazur.as3swf.data.abc.exporters.translator.ABCOpcodeTranslator;
	import flash.utils.ByteArray;


	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMethodBuilder implements IABCMethodBuilder {
		
		private var _methodInfo:ABCMethodInfo;
		private var _traits:Vector.<ABCTraitInfo>;
		
		public function JSMethodBuilder() {}
		
		public static function create(methodInfo:ABCMethodInfo, traits:Vector.<ABCTraitInfo>):JSMethodBuilder {
			const builder:JSMethodBuilder = new JSMethodBuilder();
			builder.methodInfo = methodInfo;
			builder.traits = traits;
			return builder; 
		}
		
		public function write(data:ByteArray):void {
			const qname:ABCQualifiedName = methodInfo.multiname.toQualifiedName();
			const methodBuilder:IABCMethodNameBuilder = JSMethodNameBuilder.create(qname);
			methodBuilder.write(data);
			
			JSTokenKind.COLON.write(data);
			JSReservedKind.FUNCTION.write(data);
			JSTokenKind.LEFT_PARENTHESES.write(data);
			
			const parameters:Vector.<ABCParameter> = methodInfo.parameters;
			
			const parameterBuilder:IABCMethodParameterBuilder = JSMethodParameterBuilder.create(parameters);
			parameterBuilder.write(data);
			
			JSTokenKind.RIGHT_PARENTHESES.write(data);
			JSTokenKind.LEFT_CURLY_BRACKET.write(data);
			
			const optionalParameterBuilder:IABCMethodOptionalParameterBuilder = JSMethodOptionalParameterBuilder.create(parameters);
			optionalParameterBuilder.write(data);
			
			const translateData:ABCOpcodeTranslateData = ABCOpcodeTranslateData.create();
			const translator:ABCOpcodeTranslator = ABCOpcodeTranslator.create(methodInfo);
			translator.optimizer = JSOpcodeTranslatorOptimizer.create();
			translator.translate(translateData);
			
			const opcode:IABCMethodOpcodeBuilder = JSMethodOpcodeBuilder.create(methodInfo, traits, translateData);
			opcode.write(data);
			
			JSTokenKind.RIGHT_CURLY_BRACKET.write(data);
		}
		
		public function get methodInfo():ABCMethodInfo { return _methodInfo; }
		public function set methodInfo(value:ABCMethodInfo):void { _methodInfo = value; }
		
		public function get traits():Vector.<ABCTraitInfo> { return _traits; }
		public function set traits(value:Vector.<ABCTraitInfo>):void { _traits = value; }
		
		public function get name():String { return "JSMethodBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
