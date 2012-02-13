package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.utils.StringUtils;
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
		
		override public function parse(data:SWFData, scanner:ABCScanner):void {
			const total:uint = data.readEncodedU30();
			for(var i:uint=0; i<total; i++) {
				data.position = scanner.getMethodInfoAtIndex(i);
				
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
				
				const info:ABCMethodInfo = ABCMethodInfo.create(abcData, methodName, parameters, returnType, methodFlags);
				info.parse(data, scanner);
				
				methodInfos.push(info);
			}
		}
		
		public function getAt(index:uint):ABCMethodInfo {
			return methodInfos[index];
		}
		
		override public function get name():String { return "ABCMethodInfoSet"; }
		override public function get length():uint { return methodInfos.length; }
		
		override public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Number MethodInfo: ";
			str += methodInfos.length;
			
			if(methodInfos.length > 0) {
				for(var i:uint=0; i<methodInfos.length; i++) {
					str += "\n" + methodInfos[i].toString(indent + 4);
				}
			}
			
			return str;
		}
	}
}
