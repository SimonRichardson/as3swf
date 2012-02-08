package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCMethodInfoSet extends ABCSet {
		
		public var methodInfos:Vector.<ABCMethodInfo>;
		
		public function ABCMethodInfoSet(abcData:ABCData){
			super(abcData);
			
			methodInfos = new Vector.<ABCMethodInfo>();
		}
		
		override public function parse(data : SWFData) : void {
			const total:uint = data.readEncodedU30();
			for(var i:uint=0; i<total; i++) {
				const paramTotal:uint = data.readEncodedU30();
				
				const returnIndex:uint = data.readEncodedU30();
				const returnType:IABCMultiname = getMultinameByIndex(returnIndex);
				
				const parameters:Vector.<ABCParameter> = new Vector.<ABCParameter>();
				for(var j:uint=0; j<paramTotal; j++) {
					const paramIndex:uint = data.readEncodedU30();
					const mname:IABCMultiname = getMultinameByIndex(paramIndex);
					const qname:IABCMultiname = mname.toQualifiedName();
					parameters.push(ABCParameter.create(qname));
				}
				
				const methodIndex:uint = data.readEncodedU30();
				const methodName:String = getStringByIndex(methodIndex);
				
				const methodFlags:uint = data.readUI8();
				
				const info:ABCMethodInfo = ABCMethodInfo.create(methodName, parameters, returnType, methodFlags);
				
				if(info.hasOptional) {
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
				
				if(info.hasParamNames) {
					for(var l:uint=0; l<paramTotal; l++) {
						const paramNameIndex:uint = data.readEncodedU30();
						const paramName:String = getStringByIndex(paramNameIndex);
						const nameParam:ABCParameter = parameters[l];
						nameParam.label = paramName;
					}
				}
				
				methodInfos.push(info);
			}
		}
		
		override public function get name():String { return "ABCMethodInfoSet"; }
		
		public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
			
			if(methodInfos.length > 0) {
				for(var i:uint=0; i<methodInfos.length; i++) {
					str += "\n" + methodInfos[i].toString(indent + 4);
				}
			}
			
			return str;
		}
	}
}
