package com.codeazur.as3swf.data.abc.reflect
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBody;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectGetter implements IABCReflectObject {
		
		private var _methodInfo:ABCMethodInfo;
		private var _methodBody:ABCMethodBody;
		private var _opcodes:Vector.<ABCOpcode>;
		
		public function ABCReflectGetter(methodInfo:ABCMethodInfo) {
			_methodInfo = methodInfo;
			_methodBody = methodInfo.methodBody;
			_opcodes = _methodBody.opcodes.opcodes;
		}
		
		public static function create(methodInfo:ABCMethodInfo):ABCReflectGetter {
			return new ABCReflectGetter(methodInfo);
		}
				
		public function get opcodes():Vector.<ABCOpcode> { return _opcodes; }
		public function get numOpcodes():int { return _opcodes.length; }

		public function get multiname():IABCMultiname { return _methodInfo.multiname; }
		
		public function get name():String { return "ABCReflectGetter"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Multiname:";
			str += "\n" + StringUtils.repeat(indent + 4) + multiname.fullPath;
			
			str += "\n" + StringUtils.repeat(indent + 2) + "numOpcodes: " + numOpcodes;
			
			return str;
		}
	}
}
