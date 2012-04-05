package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	import com.codeazur.as3swf.data.abc.io.ABCScanner;
	import com.codeazur.as3swf.data.abc.utils.getMethodName;
	import com.codeazur.as3swf.data.abc.utils.getMethodNamespace;
	import com.codeazur.as3swf.data.abc.utils.getScopeName;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCMethodInfo extends ABCSet {

		public var multiname:IABCMultiname;
		public var methodName:String;
		public var methodNamespace:String;
		public var methodIndex:uint;
		public var methodBody:ABCMethodBody;
		public var parameters:Vector.<ABCParameter>;
		public var returnType:IABCMultiname;
		public var scopeName:String;
		public var label:String;
		public var flags:uint;
		public var optionalTotal:int;

		public function ABCMethodInfo(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCMethodInfo {
			return new ABCMethodInfo(abcData);
		}
		
		public function read(data:SWFData, scanner:ABCScanner):void {
			const methodPosition:uint = scanner.getMethodInfoAtIndex(methodIndex);
			if(methodPosition != data.position) {
				throw new Error("Invalid position (Expected: " + methodPosition + ", Recieved: " + data.position + ")");
			}
			data.position = methodPosition;
			
			const paramTotal:uint = data.readEncodedU30();
				
			const returnIndex:uint = data.readEncodedU30();
			returnType = getMultinameByIndex(returnIndex);
			
			parameters = new Vector.<ABCParameter>();
			for(var j:uint=0; j<paramTotal; j++) {
				const paramIndex:uint = data.readEncodedU30();
				const paramMName:IABCMultiname = getMultinameByIndex(paramIndex);
				
				parameters.push(ABCParameter.create(paramMName));
			}
			
			const methodNamePosition:uint = scanner.getMethodInfoNameAtIndex(methodIndex);
			if(methodNamePosition != data.position) {
				throw new Error("Invalid position (Expected: " + methodNamePosition + ", Recieved: " + data.position + ")");
			}
			data.position = methodNamePosition;
			
			const methodIndex:uint = data.readEncodedU30();
			
			label = getStringByIndex(methodIndex);
			
			scopeName = getScopeName(label);
			methodName = getMethodName(label);
			methodNamespace = getMethodNamespace(label);
									
			flags = data.readUI8();
						
			if(hasOptional) {
				optionalTotal = data.readEncodedU30();
				for(var k:uint=0; k<optionalTotal; k++) {
					
					const optionalParamIndex:uint = (paramTotal - optionalTotal) + k;
					const optionalParam:ABCParameter = parameters[optionalParamIndex];
					optionalParam.optional = true;
					
					const optionalValueIndex:uint = data.readEncodedU30();
					const optionalValueKind:uint = data.readUI8();
					
					const kind:ABCConstantKind = ABCConstantKind.getType(optionalValueKind);
					optionalParam.optionalKind = kind;
					optionalParam.defaultValue = getConstantPoolItemByKindAtIndex(kind, optionalValueIndex);
				}
			}
			
			for(var l:uint=0; l<paramTotal; l++) {
				const nameParam:ABCParameter = parameters[l];
				
				if(hasParamNames) {
					const paramNameIndex:uint = data.readEncodedU30();
					const paramName:String = getStringByIndex(paramNameIndex);
					nameParam.label = paramName;
				} else {
					nameParam.label = "";
				}
			}
		}
		
		public function write(bytes:SWFData):void {
			const paramTotal:uint = parameters.length;
			bytes.writeEncodedU32(paramTotal);
			bytes.writeEncodedU32(getMultinameIndex(returnType));
			
			for(var i:uint=0; i<paramTotal; i++) {
				bytes.writeEncodedU32(getMultinameIndex(parameters[i].multiname));
			}
			
			bytes.writeEncodedU32(getStringIndex(multiname ? multiname.fullPath : methodName));
			bytes.writeUI8(flags);
			
			if(hasOptional) {
				bytes.writeEncodedU32(optionalTotal);
				for(var k:uint=0; k<optionalTotal; k++) {
					
					const optionalParamIndex:uint = (paramTotal - optionalTotal) + k;
					const optionalParam:ABCParameter = parameters[optionalParamIndex];
					const optionalKind:ABCConstantKind = optionalParam.optionalKind;
					const position:int = getConstantPoolIndexByKindWithValue(optionalKind, optionalParam.defaultValue);
					bytes.writeEncodedU32(position);
					bytes.writeUI8(optionalParam.optionalKind.type);
				}
			}
			
			if(hasParamNames) {
				for(var j:uint=0; j<paramTotal; j++) {
					const paramName:String = parameters[j].label;
					bytes.writeEncodedU32(getStringIndex(paramName));
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
		public function get hasRest():Boolean {
			return ABCMethodInfoFlags.isType(flags, ABCMethodInfoFlags.NEED_REST);
		}
		public function get hasArguments():Boolean {
			return ABCMethodInfoFlags.isType(flags, ABCMethodInfoFlags.NEED_ARGUMENTS);
		}
		
		override public function toString(indent:uint = 0):String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2);
			str += "MethodName: " + methodName;
			
			if(multiname) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Multiname: ";
				str += "\n" + multiname.toString(indent + 4);
			}
			
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
			str += "MethodNamespace: " + methodNamespace;
			str += "\n" + StringUtils.repeat(indent + 2);
			str += "Flags: " + flags;
			
			return str;
		}
	}
}
