package com.codeazur.as3swf.data.abc.io
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.ABCScanner;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCDeserializer {
		
		private var _bytes:SWFData;
		
		private var _scanner:ABCScanner;
		
		public function ABCDeserializer(bytes : ByteArray) {
			if(bytes is SWFData) _bytes = SWFData(bytes);
			else {
				_bytes = new SWFData();
				_bytes.writeBytes(bytes, 0, bytes.length);
				_bytes.position = 0;
			}
			
			_scanner = new ABCScanner();
		}
		
		public function parse(abcData : ABCData) : void {
			_scanner.scan(_bytes);
			
			_bytes.position = _scanner.minorVersion;
			abcData.minorVersion = _bytes.readUI16();
			
			_bytes.position = _scanner.majorVersion;
			abcData.majorVersion = _bytes.readUI16();
						
			abcData.constantPool.parse(_bytes, _scanner);
			
//			abcData.methodInfoSet.parse(_bytes);
//			abcData.metadataSet.parse(_bytes);
//			abcData.instanceInfoSet.parse(_bytes);
//			abcData.classInfoSet.parse(_bytes);
//			abcData.scriptInfoSet.parse(_bytes);
		}
		
		public function get scanner():ABCScanner {
			return _scanner;
		}
	}
}
