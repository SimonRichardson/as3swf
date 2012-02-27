package com.codeazur.as3swf.data.abc.exporters.js.builders.parameters
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodParameterBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;
	import com.codeazur.utils.StringUtils;

	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMethodParameterBuilder implements IABCMethodParameterBuilder {

		public static const DEFAULT_PARAMETER_NAME:String = "value";

		private var _parameters:Vector.<ABCParameter>;

		public function JSMethodParameterBuilder() {
		}
		
		public static function create(parameters:Vector.<ABCParameter>):JSMethodParameterBuilder {
			const builder:JSMethodParameterBuilder = new JSMethodParameterBuilder();
			builder.parameters = parameters;
			return builder;
		}

		public function write(data : ByteArray) : void {
			if(parameters.length > 0) {
				
				const total:uint = parameters.length;
				for(var i:uint=0; i<total; i++) {
					const parameter:ABCParameter = parameters[i];
					const parameterName:String = getParameterName(parameter.label, i);
					
					if(parameter.label != parameterName) {
						const modified:ABCParameter = parameter.clone();
						modified.label = parameterName;
						parameters[i] = modified;
					}
					
					data.writeUTF(parameterName);
										
					if(i < total - 1) {
						JSTokenKind.COMMA.write(data);
					}
				}
			}
		}
		
		private function getParameterName(label:String, index:uint):String {
			return StringUtils.isEmpty(label) ? DEFAULT_PARAMETER_NAME + index : label;
		}
		
		public function get parameters() : Vector.<ABCParameter> { return _parameters;	}
		public function set parameters(value : Vector.<ABCParameter>) : void { _parameters = value; }
		
		public function get name():String { return "JSMethodParameterBuilder"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			if(parameters && parameters.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Parameters:";
				for(var i:uint=0; i<parameters.length; i++) {
					str += "\n" + parameters[i].toString(indent + 4);
				}
			}
			
			return str;
		}
	}
}
