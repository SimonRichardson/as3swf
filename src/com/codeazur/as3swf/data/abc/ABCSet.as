package com.codeazur.as3swf.data.abc
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCClassInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCConstantKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMetadata;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespace;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCSet
	{

		private var _abcData : ABCData;

		public function ABCSet(abcData:ABCData)
		{
			_abcData = abcData;
		}
		
		protected function getIntegerIndex(integer:uint):int {
			const index:int = abcData.constantPool.getIntegerIndex(integer);
			if(index < 0) {
				throw new Error('Range Error (recieved:' + integer + ')');
			}
			return index;
		}	
				
		protected function getIntegerByIndex(index:uint):int {
			return abcData.constantPool.getIntegerByIndex(index);
		}
		
		protected function getUnsignedIntegerIndex(unsignedInteger:uint):int {
			const index:int = abcData.constantPool.getUnsignedIntegerIndex(unsignedInteger);
			if(index < 0) {
				throw new Error('Range Error (recieved:' + unsignedInteger + ')');
			}
			return index;
		}	
		
		protected function getUnsignedIntegerByIndex(index:uint):uint {
			return abcData.constantPool.getUnsignedIntegerByIndex(index);
		}
			
		protected function getDoubleIndex(double:Number):int {
			const index:int = abcData.constantPool.getDoubleIndex(double);
			if(index < 0) {
				throw new Error('Range Error (recieved:' + double + ')');
			}
			return index;
		}	
				
		protected function getDoubleByIndex(index:uint):Number {
			return abcData.constantPool.getDoubleByIndex(index);
		}
		
		protected function addString(string:String):void {
			abcData.constantPool.addString(string);
		}
		
		protected function getStringIndex(string:String):int {
			const index:int = abcData.constantPool.getStringIndex(string);
			if(index < 0) {
				throw new Error('Range Error (recieved:' + string + ')');
			}
			return index;
		}
		
		protected function getStringByIndex(index:uint):String {
			return abcData.constantPool.getStringByIndex(index);
		}
		
		protected function addMultiname(multiname:IABCMultiname):void {
			abcData.constantPool.addMultiname(multiname);
		}
		
		protected function getMultinameIndex(multiname:IABCMultiname):int {
			const index:int = abcData.constantPool.getMultinameIndex(multiname);
			if(index < 0) {
				throw new Error('Range Error (recieved:' + multiname + ', with index:' + index + ')');
			}
			return index;
		}
		
		protected function getMultinameByIndex(index:uint):IABCMultiname {
			return abcData.constantPool.getMultinameByIndex(index);
		}
		
		protected function addNamespace(ns:ABCNamespace):void {
			abcData.constantPool.addNamespace(ns);
		}
		
		protected function getNamespaceIndex(ns:ABCNamespace):int {
			const index:int = abcData.constantPool.getNamespaceIndex(ns);
			if(index < 0) {
				throw new Error('Range Error');
			}
			return index;
		}
		
		protected function getNamespaceByIndex(index:uint):ABCNamespace {
			return abcData.constantPool.getNamespaceByIndex(index);
		}
		
		protected function getMethodInfoIndex(value:ABCMethodInfo):int {
			const index:int = abcData.methodInfoSet.methodInfos.indexOf(value);
			if(index < 0) {
				throw new Error('Range Error');
			}
			return index;
		}
		
		protected function getMethodInfoByIndex(index:uint):ABCMethodInfo {
			return abcData.methodInfoSet.getAt(index);
		}
		
		protected function getMetadataIndex(value:ABCMetadata):int {
			const index:int = abcData.metadataSet.indexOf(value);
			if(index < 0) {
				throw new Error('Range Error');
			}
			return index;
		}
		
		protected function getMetadataByIndex(index:uint):ABCMetadata {
			return abcData.metadataSet.getAt(index);
		}
		
		protected function getInstanceInfoByIndex(index:uint):ABCInstanceInfo {
			return abcData.instanceInfoSet.getAt(index);
		}
		
		protected function getClassInfoByIndex(index:uint):ABCClassInfo {
			return abcData.classInfoSet.getAt(index);
		}
		
		protected function getConstantPoolItemByKindAtIndex(kind:ABCConstantKind, index:uint):* {
			return abcData.constantPool.getPoolItemByKindAtIndex(kind, index);
		}
		
		protected function getConstantPoolIndexByKindWithValue(kind:ABCConstantKind, defaultValue:*):int {
			return abcData.constantPool.getPoolIndexByKindWithValue(kind, defaultValue);
		}

		public function get abcData():ABCData { return _abcData; }
		public function set abcData(value:ABCData):void { _abcData = value; }
		
		public function get name():String { return "ABCSet"; }
		public function get length():uint { return 0; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
