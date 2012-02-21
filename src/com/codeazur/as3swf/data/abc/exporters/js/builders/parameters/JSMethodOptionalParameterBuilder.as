package com.codeazur.as3swf.data.abc.exporters.js.builders.parameters
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedNameType;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMatcher;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOptionalParameterBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCTernaryBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSReservedKind;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTernaryBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSValueBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.matchers.JSNotNullMatcher;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.matchers.JSStringNotEmptyMatcher;
	import com.codeazur.utils.StringUtils;
	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMethodOptionalParameterBuilder implements IABCMethodOptionalParameterBuilder {

		public static const DEFAULT_PARAMETER_NAME:String = "value";

		private var _parameters:Vector.<ABCParameter>;

		public function JSMethodOptionalParameterBuilder() {
		}
		
		public static function create(parameters:Vector.<ABCParameter>):JSMethodOptionalParameterBuilder {
			const builder:JSMethodOptionalParameterBuilder = new JSMethodOptionalParameterBuilder();
			builder.parameters = parameters;
			return builder;
		}

		public function write(data : ByteArray) : void {
			if(parameters.length > 0) {
				const total:uint = parameters.length;
				for(var i:uint=0; i<total; i++) {
					const parameter:ABCParameter = parameters[i];
					if(parameter.optional) {
						const parameterName:String = getParameterName(parameter.label, i);
						const parameterQName:ABCQualifiedName = parameter.qname.toQualifiedName();
						const parameterDefaultValue:* = parameter.defaultValue;
						
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
			}
		}
		
		private function getParameterName(label:String, index:uint):String {
			return StringUtils.isEmpty(label) ? DEFAULT_PARAMETER_NAME + index : label;
		}
		
		public function get parameters() : Vector.<ABCParameter> { return _parameters;	}
		public function set parameters(value : Vector.<ABCParameter>) : void { _parameters = value; }
		
		public function get name():String { return "JSMethodOptionalParameterBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
