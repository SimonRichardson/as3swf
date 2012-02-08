package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCMethodInfo
	{

		public var methodName:String;
		public var parameters:Vector.<ABCParameter>;
		public var returnType:IABCMultiname;
		public var scopeName:String;
		public var flags:uint;

		public function ABCMethodInfo() {}
		
		public static function create(methodName:String, parameters:Vector.<ABCParameter>, returnType:IABCMultiname, flags:uint):ABCMethodInfo {
			const info:ABCMethodInfo = new ABCMethodInfo();
			info.methodName = methodName;
			info.parameters = parameters;
			info.returnType = returnType;
			info.flags = flags;
			info.scopeName = getScopeName(methodName); 
			return info;
		}
		
		private static function getScopeName(methodName:String):String {
			var result : String = "";
			if (null != methodName && methodName.length > 0) {
				const parts:Array = methodName.split(".");
				if (parts.length > 1) {
					parts.pop();
					result = parts.join(".");
				}
			}
			return result;
		}
		
		public function get name():String { return "ABCMethodInfo"; }
		public function get hasOptional():Boolean { 
			return ABCMethodInfoFlags.isType(flags, ABCMethodInfoFlags.HAS_OPTIONAL); 
		}
		public function get hasParamNames():Boolean {
			return ABCMethodInfoFlags.isType(flags, ABCMethodInfoFlags.HAS_PARAM_NAMES);
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2);
			str += "MethodName: " + methodName;
			
			const total:int = parameters.length;
			if(total > 0) {
				str += "\n" + StringUtils.repeat(indent + 2);
				str += "Parameters:\n";
				for(var i:uint=0; i<total; i++) {
					str += parameters[i].toString(indent + 4);
					if(i < total-1)
						str += "\n";
				}
			}
			
			str += "\n" + StringUtils.repeat(indent + 2);
			str += "ReturnType:";
			str += "\n" + returnType.toString(indent + 4);
			str += "\n" + StringUtils.repeat(indent + 2);
			str += "ScopeName: " + scopeName;
			str += "\n" + StringUtils.repeat(indent + 2);
			str += "Flags: " + flags;
			
			return str;
		}
	}
}