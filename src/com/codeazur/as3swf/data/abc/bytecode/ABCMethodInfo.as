package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	import com.codeazur.as3swf.data.abc.io.ABCScanner;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCMethodInfo extends ABCSet {

		public var methodName:String;
		public var parameters:Vector.<ABCParameter>;
		public var returnType:IABCMultiname;
		public var scopeName:String;
		public var flags:uint;

		public function ABCMethodInfo(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData, methodName:String, parameters:Vector.<ABCParameter>, returnType:IABCMultiname, flags:uint):ABCMethodInfo {
			const info:ABCMethodInfo = new ABCMethodInfo(abcData);
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
		
		override public function parse(data:SWFData, scanner:ABCScanner):void {
			const paramTotal:uint = parameters.length;
			
			if(hasOptional) {
				const optionalTotal:uint = data.readEncodedU30();
				for(var k:uint=0; k<optionalTotal; k++) {
					
					const optionalParamIndex:uint = (paramTotal - optionalTotal) + k;
					const optionalParam:ABCParameter = parameters[optionalParamIndex];
					optionalParam.optional = true;
					
					const optionalValueIndex:uint = data.readEncodedU30();
					const optionalValueKind:uint = data.readUI8();
					
					const kind:ABCConstantKind = ABCConstantKind.getType(optionalValueKind);
					optionalParam.optionalKind = kind;
					
					switch(kind) {
						case ABCConstantKind.INT:
							optionalParam.defaultValue = getIntegerByIndex(optionalValueIndex);
							break;
							
						case ABCConstantKind.UINT:
							optionalParam.defaultValue = getUnsignedIntegerByIndex(optionalValueIndex);
							break;
						
						case ABCConstantKind.DOUBLE:
							optionalParam.defaultValue = getDoubleByIndex(optionalValueIndex);
							break;
						
						case ABCConstantKind.UTF8:
							optionalParam.defaultValue = getStringByIndex(optionalValueIndex);
							break;
						
						case ABCConstantKind.TRUE:
							optionalParam.defaultValue = true;
							break;
						
						case ABCConstantKind.FALSE:
							optionalParam.defaultValue = false;
							break;
							
						case ABCConstantKind.NULL:
							optionalParam.defaultValue = null;
							break;
						
						case ABCConstantKind.UNDEFINED:
							optionalParam.defaultValue = undefined;
							break;
						
						case ABCConstantKind.EXPLICIT_NAMESPACE:
						case ABCConstantKind.NAMESPACE:
						case ABCConstantKind.PACKAGE_NAMESPACE:
						case ABCConstantKind.PACKAGE_INTERNAL_NAMESPACE:
						case ABCConstantKind.PRIVATE_NAMESPACE:
						case ABCConstantKind.PROTECTED_NAMESPACE:
						case ABCConstantKind.STATIC_PROTECTED_NAMESPACE:
							optionalParam.defaultValue = getNamespaceByIndex(optionalValueIndex);
							break;
						
						default:
							throw new Error();
					}
				}
			}
			
			if(hasParamNames) {
				for(var l:uint=0; l<paramTotal; l++) {
					const paramNameIndex:uint = data.readEncodedU30();
					const paramName:String = getStringByIndex(paramNameIndex);
					const nameParam:ABCParameter = parameters[l];
					nameParam.label = paramName;
				}
			}
		}
		
		override public function get name():String { return "ABCMethodInfo"; }
		public function get hasOptional():Boolean { 
			return ABCMethodInfoFlags.isType(flags, ABCMethodInfoFlags.HAS_OPTIONAL); 
		}
		public function get hasParamNames():Boolean {
			return ABCMethodInfoFlags.isType(flags, ABCMethodInfoFlags.HAS_PARAM_NAMES);
		}
		
		override public function toString(indent:uint = 0):String {
			var str:String = super.toString(indent);
			
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
