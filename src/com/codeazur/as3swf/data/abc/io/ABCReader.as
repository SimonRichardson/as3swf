package com.codeazur.as3swf.data.abc.io
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;

	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCReader {
		
		private var _bytes:SWFData;
		
		private var _scanner:ABCScanner;
		
		public function ABCReader(bytes:ByteArray) {
			if(bytes is SWFData) _bytes = SWFData(bytes);
			else {
				_bytes = new SWFData();
				_bytes.writeBytes(bytes, 0, bytes.length);
				_bytes.position = 0;
			}
			
			_scanner = new ABCScanner();
		}
		
		public function read(abcData:ABCData) : void {
			scanner.scan(_bytes);
			
			_bytes.position = scanner.minorVersion;
			abcData.minorVersion = _bytes.readUI16();
			
			_bytes.position = scanner.majorVersion;
			abcData.majorVersion = _bytes.readUI16();
					
			abcData.constantPool.read(_bytes, scanner);
			
			abcData.methodInfoSet.read(_bytes, scanner);
			abcData.metadataSet.read(_bytes, scanner);
			
			abcData.instanceInfoSet.read(_bytes, scanner);
			abcData.classInfoSet.read(_bytes, scanner);
			abcData.scriptInfoSet.read(_bytes, scanner);
			abcData.methodBodySet.read(_bytes, scanner);
			
			resolve(abcData);
			
			// Check the length at the end to confirm the length
			if(_bytes.length != scanner.length) {
				throw new Error('Length mismatch (expected:' + scanner.length + ', recieved:' + _bytes.length + ')');
			}
		}
		
		protected function resolve(abcData:ABCData):void {
			// TODO (Simon) Resolve any issues that happen after the reading.
			
		}
				
		public function get scanner():ABCScanner {
			return _scanner;
		}
	}
}
