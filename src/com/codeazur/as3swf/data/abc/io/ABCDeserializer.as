package com.codeazur.as3swf.data.abc.io
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
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
			scanner.scan(_bytes);
			
			_bytes.position = scanner.minorVersion;
			abcData.minorVersion = _bytes.readUI16();
			
			_bytes.position = scanner.majorVersion;
			abcData.majorVersion = _bytes.readUI16();
						
			abcData.constantPool.parse(_bytes, scanner);
			abcData.methodInfoSet.parse(_bytes, scanner);
			abcData.metadataSet.parse(_bytes, scanner);
			abcData.instanceInfoSet.parse(_bytes, scanner);
//			abcData.classInfoSet.parse(_bytes);
//			abcData.scriptInfoSet.parse(_bytes);
		}
		
		public function get scanner():ABCScanner {
			return _scanner;
		}
	}
}
