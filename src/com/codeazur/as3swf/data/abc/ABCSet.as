package com.codeazur.as3swf.data.abc
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCClassInfo;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.bytecode.ABCConstantKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMetadata;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespace;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCSet
	{
		
		private var _abcData:ABCData;

		public function ABCSet(abcData:ABCData)
		{
			_abcData = abcData;
		}
		
		public function parse(data : SWFData) : void {
			throw new Error();
		}
		
		protected function getIntegerByIndex(index:uint):int {
			return abcData.constantPool.getIntegerByIndex(index);
		}
		
		protected function getUnsignedIntegerByIndex(index:uint):uint {
			return abcData.constantPool.getUnsignedIntegerByIndex(index);
		}
				
		protected function getDoubleByIndex(index:uint):Number {
			return abcData.constantPool.getDoubleByIndex(index);
		}
		
		protected function addString(string:String):void {
			abcData.constantPool.addString(string);
		}
		
		protected function getStringByIndex(index:uint):String {
			return abcData.constantPool.getStringByIndex(index);
		}
		
		protected function addMultiname(multiname:IABCMultiname):void {
			abcData.constantPool.addMultiname(multiname);
		}
		
		protected function getMultinameByIndex(index:uint):IABCMultiname {
			return abcData.constantPool.getMultinameByIndex(index);
		}
		
		protected function addNamespace(ns:ABCNamespace):void {
			abcData.constantPool.addNamespace(ns);
		}
		
		protected function getNamespaceByIndex(index:uint):ABCNamespace {
			return abcData.constantPool.getNamespaceByIndex(index);
		}
		
		protected function getMethodInfoByIndex(index:uint):ABCMethodInfo {
			return abcData.methodInfoSet.getAt(index);
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
		
		public function get abcData():ABCData { return _abcData; }
		public function get name():String { return "ABCSet"; }
		public function get length():uint { return 0; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
