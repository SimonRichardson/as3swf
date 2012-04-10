package com.codeazur.as3swf.data.abc.reflect
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBody;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectSetter implements IABCReflectObject {
		
		private var _methodInfo:ABCMethodInfo;
		private var _methodBody:ABCMethodBody;
		private var _opcodes:Vector.<ABCOpcode>;
		
		private var _parameter:ABCReflectParameter;
		
		public function ABCReflectSetter(methodInfo:ABCMethodInfo) {
			_methodInfo = methodInfo;
			_methodBody = methodInfo.methodBody;
			_opcodes = _methodBody.opcodes.opcodes;
		}
		
		public static function create(methodInfo:ABCMethodInfo):ABCReflectSetter {
			return new ABCReflectSetter(methodInfo);
		}
		
		private function populateParameters():void {
			if(_methodInfo.parameters.length > 0) {
				const methodParam:ABCParameter = _methodInfo.parameters[0];
				_parameter = ABCReflectParameter.create(methodParam);
			}
		}
		
		public function get parameter():ABCReflectParameter { 
			if(!_parameter) {
				populateParameters();
			}
			
			return _parameter; 
		}
		
		public function get opcodes():Vector.<ABCOpcode> { return _opcodes; }
		public function get numOpcodes():int { return _opcodes.length; }

		public function get multiname():IABCMultiname { return _methodInfo.multiname; }
		
		public function get name():String { return "ABCReflectSetter"; }
		
		public function get hasOptional():Boolean { return _methodInfo.hasOptional; }
		public function get hasParamNames():Boolean { return _methodInfo.hasParamNames; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Multiname:";
			str += "\n" + StringUtils.repeat(indent + 4) + multiname.fullPath;
			
			if(parameter) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Parameter:";
				str += "\n" + parameter.toString(indent + 4);
			}
			
			str += "\n" + StringUtils.repeat(indent + 2) + "numOpcodes: " + numOpcodes;
			
			str += "\n" + StringUtils.repeat(indent + 2) + "hasParamNames: " + hasParamNames;
			str += "\n" + StringUtils.repeat(indent + 2) + "hasOptional: " + hasOptional;
			
			return str;
		}
	}
}
