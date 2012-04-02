package com.codeazur.as3swf.data.abc.reflect
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectMethod implements IABCReflectObject {
		
		private var _methodInfo:ABCMethodInfo;

		public function ABCReflectMethod(methodInfo:ABCMethodInfo) {
			_methodInfo = methodInfo;
		}
		
		public static function create(methodInfo:ABCMethodInfo):ABCReflectMethod {
			return new ABCReflectMethod(methodInfo);
		}

		public function get multiname():IABCMultiname { return _methodInfo.multiname; }
		public function get name():String { return "ABCReflectInstance"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Multiname:";
			str += "\n" + multiname.toString(indent + 4);
			
			return str;
		}
		
	}
}
