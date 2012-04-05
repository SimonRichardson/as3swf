package com.codeazur.as3swf.data.abc.io
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedNameBuilder;
	import com.codeazur.utils.StringUtils;

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
			resolveMethodMultinames(abcData);
		}
		
		private function resolveMethodMultinames(abcData:ABCData):void {
			const total:uint = abcData.instanceInfoSet.length;
			for(var i:uint=0; i<total; i++) {
				const instance:ABCInstanceInfo = abcData.instanceInfoSet.getAt(i);
				const fullName:String = instance.multiname.fullName;
				
				const methodInfoTotal:uint = abcData.methodInfoSet.length;
				for(var j:uint=0; j<methodInfoTotal; j++) {
					
					const methodInfo:ABCMethodInfo = abcData.methodInfoSet.getAt(j);
					const label:String = methodInfo.label;
					const scopeName:String = methodInfo.scopeName;
					if(!StringUtils.isEmpty(label) && scopeName.indexOf(fullName) == 0) {
						methodInfo.multiname = ABCQualifiedNameBuilder.create(label);
					}
				}
			}
		}
				
		public function get scanner():ABCScanner {
			return _scanner;
		}
	}
}
