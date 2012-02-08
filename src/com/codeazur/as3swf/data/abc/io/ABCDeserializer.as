package com.codeazur.as3swf.data.abc.io
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCDeserializer {
		
		private var _bytes : SWFData;
		
		public function ABCDeserializer(bytes : ByteArray) {
			if(bytes is SWFData) _bytes = SWFData(bytes);
			else {
				_bytes = new SWFData();
				_bytes.writeBytes(bytes, 0, bytes.length);
				_bytes.position = 0;
			}
		}
		
		public function parse(abcData : ABCData) : void {
			abcData.minorVersion = _bytes.readUI16();
			abcData.majorVersion = _bytes.readUI16();
			
			abcData.constantPool.parse(_bytes);
			
			abcData.methodInfoSet.parse(_bytes);
			abcData.metadataSet.parse(_bytes);
			abcData.instanceInfoSet.parse(_bytes);
		}
	}
}
