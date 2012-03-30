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
	public class ABCMethodInfoSet extends ABCSet {
		
		public var methodInfos:Vector.<ABCMethodInfo>;
		
		public function ABCMethodInfoSet(abcData:ABCData){
			super(abcData);
			
			methodInfos = new Vector.<ABCMethodInfo>();
		}
		
		public function add(methodInfo:ABCMethodInfo):void {
			addAt(methodInfo, length);
		}
		
		public function addAt(methodInfo:ABCMethodInfo, index:uint):void {
			if(contains(methodInfo)) {
				throw new Error('Method info already exists');
			}
			if(methodInfo.multiname) {
				addMultiname(methodInfo.multiname);
			}
			addString(methodInfo.multiname ? methodInfo.multiname.fullPath : methodInfo.methodName);
			addMultiname(methodInfo.returnType);
			
			const parameters:Vector.<ABCParameter> = methodInfo.parameters;
			const total:uint = parameters.length;
			for(var i:uint=0; i<total; i++) {
				const parameter:ABCParameter = parameters[i];
				if(parameter.multiname) {
					addMultiname(parameter.multiname);
				}
				if(parameter.label) {
					addString(parameter.label);
				}
			}
			
			if(index == 0) {
				methodInfos.unshift(methodInfo);
			} else if(index == length) {
				methodInfos.push(methodInfo);
			} else if(index > 0 && index < length) {
				methodInfos.splice(index, 0, methodInfo);
			} else {
				throw new RangeError("Invalid index");
			}
		}
		
		public function merge(methodInfoSet:ABCMethodInfoSet):void {
			methodInfoSet.abcData = abcData;
			
			const total:uint = methodInfoSet.methodInfos.length;
			for(var i:uint=0; i<total; i++) {
				const info:ABCMethodInfo = methodInfoSet.methodInfos[i];
				info.abcData = abcData;
				info.methodIndex = methodInfos.length;
				
				methodInfos.push(info);
			}
		}
		
		public function read(data:SWFData, scanner:ABCScanner):void {
			const total:uint = data.readEncodedU30();
			for(var i:uint=0; i<total; i++) {
				const info:ABCMethodInfo = ABCMethodInfo.create(abcData);
				info.methodIndex = i;
				info.read(data, scanner);
				
				methodInfos.push(info);
			}
		}
		
		public function write(bytes:SWFData):void {
			const total:uint = methodInfos.length;
			bytes.writeEncodedU32(total);
			
			for(var i:uint=0; i<total; i++) {
				const info:ABCMethodInfo = methodInfos[i];
				info.write(bytes);
			}
		}
		
		public function getAt(index:uint):ABCMethodInfo {
			return methodInfos[index];
		}
		
		public function contains(methodInfo:ABCMethodInfo):Boolean {
			return methodInfos.indexOf(methodInfo) >= 0;
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
