package com.codeazur.as3swf.data.abc.io
{
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceKind;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceKindFactory;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedNameBuilder;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.utils.getInstanceName;
	import com.codeazur.as3swf.data.abc.utils.getInstanceNamespace;
	import com.codeazur.as3swf.data.abc.utils.normaliseInstanceName;
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
			// Resolve any issues that happen after the reading.
			resolveNames(abcData);
		}
		
		private function resolveNames(abcData:ABCData):void {
			const total:uint = abcData.instanceInfoSet.length;
			for(var i:uint=0; i<total; i++) {
				const instance:ABCInstanceInfo = abcData.instanceInfoSet.getAt(i);
				const fullName:String = instance.multiname.fullName;
				
				const methodInfoTotal:uint = abcData.methodInfoSet.length;
				for(var j:uint=0; j<methodInfoTotal; j++) {
					
					const methodInfo:ABCMethodInfo = abcData.methodInfoSet.getAt(j);
					const label:String = methodInfo.label;
					if(!StringUtils.isEmpty(label)) {
						
						const index:uint = label.indexOf(fullName);
						if(index == 0) {
							methodInfo.scopeName = fullName;
							
							const partial:String = normaliseInstanceName(methodInfo.label.substr(fullName.length));
							const methodName:String = getInstanceName(partial);
							const possibleNamespace:String = getInstanceNamespace(partial);
							const methodNamespace:String = methodName != possibleNamespace ? possibleNamespace : "";
							
							methodInfo.methodName = methodName;
							methodInfo.methodNamespace = methodNamespace;
							
							const kind:ABCNamespaceKind = ABCNamespaceKindFactory.create(methodNamespace);
							
							methodInfo.multiname = ABCQualifiedNameBuilder.create(methodInfo.label, kind.type); 
						}
					}
				}
			}
		}
		
		public function get scanner():ABCScanner {
			return _scanner;
		}
	}
}
