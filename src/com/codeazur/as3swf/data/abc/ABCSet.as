package com.codeazur.as3swf.data.abc
{

	import com.codeazur.as3swf.SWFData;
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
		
		protected function getStringByIndex(index:uint):String {
			return abcData.constantPool.getStringByIndex(index);
		}
		
		protected function getMultinameByIndex(index:uint):IABCMultiname {
			return abcData.constantPool.getMultinameByIndex(index);
		}
		
		protected function getNamespaceByIndex(index:uint):ABCNamespace {
			return abcData.constantPool.getNamespaceByIndex(index);
		}
		
		public function get abcData():ABCData { return _abcData; }
		public function get name():String { return "ABCSet"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
