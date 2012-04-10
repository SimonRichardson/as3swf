package com.codeazur.as3swf.data.abc.reflect
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBody;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectMethod implements IABCReflectObject {
		
		private var _methodInfo:ABCMethodInfo;
		private var _methodBody:ABCMethodBody;
		private var _opcodes:Vector.<ABCOpcode>;
		
		private var _parameters:Vector.<ABCReflectParameter>;
		
		public function ABCReflectMethod(methodInfo:ABCMethodInfo) {
			_methodInfo = methodInfo;
			_methodBody = methodInfo.methodBody;
			_opcodes = _methodBody.opcodes.opcodes;
		}
		
		public static function create(methodInfo:ABCMethodInfo):ABCReflectMethod {
			return new ABCReflectMethod(methodInfo);
		}
		
		private function populateParameters():void {
			_parameters = new Vector.<ABCReflectParameter>();
			
			const methodParams:Vector.<ABCParameter> = _methodInfo.parameters;
			const total:uint = methodParams.length;
			for(var i:uint = 0; i<total; i++) {
				const methodParam:ABCParameter = _methodInfo.parameters[i];
				const parameter:ABCReflectParameter = ABCReflectParameter.create(methodParam);
				_parameters.push(parameter);
			}
		}
		
		public function get parameters():Vector.<ABCReflectParameter> { 
			if(!_parameters || (_parameters && _parameters.length != _methodInfo.parameters.length)) {
				populateParameters();
			}
			
			return _parameters; 
		}
		public function get numParameters():uint { return _methodInfo.parameters.length; }
		
		public function get opcodes():Vector.<ABCOpcode> { return _opcodes; }
		public function get numOpcodes():int { return _opcodes.length; }

		public function get multiname():IABCMultiname { return _methodInfo.multiname; }
		
		public function get name():String { return "ABCReflectMethod"; }
		
		public function get isStatic():Boolean { return _methodInfo.isStatic; }
		
		public function get hasOptional():Boolean { return _methodInfo.hasOptional; }
		public function get hasParamNames():Boolean { return _methodInfo.hasParamNames; }
		public function get hasRest():Boolean { return _methodInfo.hasRest; }
		public function get hasArguments():Boolean { return _methodInfo.hasArguments; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Multiname:";
			str += "\n" + StringUtils.repeat(indent + 4) + multiname.fullPath;
			
			str += "\n" + StringUtils.repeat(indent + 2) + "numParameters: " + numParameters;
			
			str += "\n" + StringUtils.repeat(indent + 2) + "numOpcodes: " + numOpcodes;
			
			str += "\n" + StringUtils.repeat(indent + 2) + "hasParamNames: " + hasParamNames;
			str += "\n" + StringUtils.repeat(indent + 2) + "hasOptional: " + hasOptional;
			str += "\n" + StringUtils.repeat(indent + 2) + "needRest: " + hasRest;
			str += "\n" + StringUtils.repeat(indent + 2) + "needArguments: " + hasArguments;
			
			return str;
		}
	}
}
