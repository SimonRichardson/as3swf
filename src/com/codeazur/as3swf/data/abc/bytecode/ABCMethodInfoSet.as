package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCMethodInfoSet {
		
		private var _abcData:ABCData;
		
		public var methodInfos:Vector.<ABCMethodInfo>;
		
		public function ABCMethodInfoSet(abcData:ABCData){
			_abcData = abcData;
			
			methodInfos = new Vector.<ABCMethodInfo>();
		}
		
		public function parse(data : SWFData) : void {
			const total:uint = data.readEncodedU30();
			for(var i:uint=0; i<total; i++) {
				const paramTotal:uint = data.readEncodedU30();
				
				const returnIndex:uint = data.readEncodedU30();
				const returnType:IABCMultiname = getMultinameByIndex(returnIndex);
				
				const parameters:Vector.<ABCArgument> = new Vector.<ABCArgument>();
				for(var j:uint=0; j<paramTotal; j++) {
					const paramIndex:uint = data.readEncodedU30();
					const mname:IABCMultiname = getMultinameByIndex(paramIndex);
					const qname:IABCMultiname = (mname is ABCMultinameGeneric) ? mname : mname.toQualifiedName();
					parameters.push(ABCArgument.create(qname));
				}
				
				const methodIndex:uint = data.readEncodedU30();
				const methodName:String = getStringByIndex(methodIndex);
				const methodFlags:uint = data.readUI8();
				
				const info:ABCMethodInfo = ABCMethodInfo.create(methodName, parameters, returnType, methodFlags);
				
				if(info.hasOptional) {
					const optionalTotal:uint = data.readEncodedU30();
					for(var k:uint=0; k<optionalTotal; k++) {
						const optionalValueIndex:uint = data.readEncodedU30();
						const optionalValueKind:uint = data.readUI8();
						
					}
				}
			}
		}
		
		private function getStringByIndex(index:uint):String {
			return abcData.constantPool.stringPool[index];
		}
		
		private function getMultinameByIndex(index:uint):IABCMultiname {
			return abcData.constantPool.multinamePool[index];
		}
		
		public function get abcData():ABCData { return _abcData; }
		public function get name():String { return "ABCMethodInfoSet"; }
		
		public function toString(indent:uint = 0) : String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
