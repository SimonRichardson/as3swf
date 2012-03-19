package com.codeazur.as3swf.data.abc.io
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCScanner {

		private var _minorVersion:uint;
		private var _majorVersion:uint;
		
		private var _constantIntPool:Vector.<uint>;
		private var _constantUIntPool:Vector.<uint>;
		private var _constantDoublePool:Vector.<uint>;
		private var _constantStringPool:Vector.<uint>;
		
		private var _constantNamespace:uint;
		private var _constantNamespacePool:Vector.<uint>;
		
		private var _constantNamespaceSet:uint;
		private var _constantNamespaceSetPool:Vector.<uint>;
		
		private var _constantMultiname:uint;
		private var _constantMultinamePool:Vector.<uint>;
		
		private var _methodInfo:uint;
		private var _methodInfos:Vector.<uint>;
		private var _methodInfosName:Vector.<uint>;
		
		private var _metadataInfo:uint;
		private var _metadataInfos:Vector.<uint>;
		
		private var _instanceInfo:uint;
		private var _instanceInfos:Vector.<uint>;
		private var _instanceTraitInfo:Vector.<Vector.<uint>>;
		
		private var _classInfo:uint;
		private var _classInfos:Vector.<uint>;
		private var _classTraitInfo:Vector.<Vector.<uint>>;
		
		private var _scriptInfo:uint;
		private var _scriptInfos:Vector.<uint>;
		private var _scriptTraitInfo:Vector.<Vector.<uint>>;
		
		private var _methodBodyInfo:uint;
		private var _methodBodyInfos:Vector.<uint>;
		private var _methodBodyTraitInfo:Vector.<Vector.<uint>>;
		
		public function ABCScanner() {
			_instanceTraitInfo = new Vector.<Vector.<uint>>();
			_classTraitInfo = new Vector.<Vector.<uint>>();
			_scriptTraitInfo = new Vector.<Vector.<uint>>();
			_methodBodyTraitInfo = new Vector.<Vector.<uint>>();
		}
		
		public function scan(input:SWFData):void {
			const position:uint = input.position;
			input.position = 0;
			
			scanMinorVersion(input);
			scanMajorVersion(input);
			
			scanIntConstants(input);
			scanUIntConstants(input);
			scanDoubleConstants(input);
			scanStringConstants(input);
			scanNamespaceConstants(input);
			scanNamespaceSetConstants(input);
			scanMultinameConstants(input);
			
			scanMethods(input);
			scanMetadata(input);
			
			scanInstances(input);
			scanClasses(input);
			
			scanScripts(input);
			scanMethodBodies(input);
			
			input.position = position;
		}
		
		public function get minorVersion():uint { return _minorVersion; }
		public function get majorVersion():uint { return _majorVersion; }
		
		public function getConstantIntegerAtIndex(index:uint):uint {
			return _constantIntPool[index];
		}

		public function getConstantUnsignedIntegerAtIndex(index:uint):uint {
			return _constantUIntPool[index];
		}

		public function getConstantDoubleAtIndex(index:uint):uint {
			return _constantDoublePool[index];
		}

		public function getConstantStringAtIndex(index:uint):uint {
			return _constantStringPool[index];
		}
		
		
		public function getConstantNamespace():uint	{
			return _constantNamespace;
		}

		public function getConstantNamespaceAtIndex(index:uint):uint {
			return _constantNamespacePool[index];
		}
		
		
		public function getConstantNamespaceSet():uint	{
			return _constantNamespaceSet;
		}
		
		public function getConstantNamespaceSetAtIndex(index:uint):uint	{
			return _constantNamespaceSetPool[index];
		}
		
		
		public function getConstantMultiname():uint {
			return _constantMultiname;
		}

		public function getConstantMultinameAtIndex(index:uint):uint {
			return _constantMultinamePool[index];
		}
		
		// method info
		
		public function getMethodInfo():uint {
			return _methodInfo;
		}
		
		public function getMethodInfoAtIndex(index:uint):uint {
			return _methodInfos[index];
		}
		
		public function getMethodInfoNameAtIndex(index:uint):uint {
			return _methodInfosName[index];
		}
		
		// metadata info
		
		public function getMetadataInfo():uint {
			return _metadataInfo;
		}
		
		public function getMetadataInfoAtIndex(index:uint):uint {
			return _metadataInfos[index];
		}
		
		// instance info
		
		public function getInstanceInfo():uint {
			return _instanceInfo;
		}
				
		public function getInstanceInfoAtIndex(index:uint):uint {
			return _instanceInfos[index];
		}
		
		public function getInstanceTraitInfoAtIndex(index:uint):Vector.<uint> {
			return _instanceTraitInfo[index];
		}
		
		// class info
		
		public function getClassInfo():uint {
			return _classInfo;
		}
		
		public function getClassInfoByIndex(index:uint):uint {
			return _classInfos[index];
		}
		
		public function getClassTraitInfoAtIndex(index:uint):Vector.<uint> {
			return _classTraitInfo[index];
		}
		
		// script info
		
		public function getScriptInfo():uint {
			 return _scriptInfo;
		}
		
		public function getScriptInfoAtIndex(index:uint):uint {
			return _scriptInfos[index];
		}
		
		public function getScriptTraitInfoAtIndex(index:uint):Vector.<uint> {
			return _scriptTraitInfo[index];
		}
		
		// method bodies
		
		public function getMethodBodyInfo():uint {
			return _methodBodyInfo;
		}
		
		public function getMethodBodyInfoAtIndex(index:uint):uint {
			return _methodBodyInfos[index];
		}
		
		public function getMethodBodyTraitInfoAtIndex(index:uint):Vector.<uint> {
			return _methodBodyTraitInfo[index];
		}
		
		// private		

		private function scanMinorVersion(input:SWFData):void	{
        	_minorVersion = input.position;
        	input.skipEntries(2);
    	}

	    private function scanMajorVersion(input:SWFData):void {
	        _majorVersion = input.position;
	        input.skipBytes(2);
	    }
	
	    private function scanIntConstants(input:SWFData):void {
	        _constantIntPool = new Vector.<uint>();
			_constantIntPool.push(0);
			
	        const size:uint = input.readEncodedU32();
	        for(var i:uint = 1; i < size; i++) {
	            _constantIntPool.push(input.position);
				
	            input.readEncodedU32();
	        }
	    }
	
	    private function scanUIntConstants(input:SWFData):void {
	        _constantUIntPool = new Vector.<uint>();
			_constantUIntPool.push(0);
			
	        const size:uint = input.readEncodedU32();
	        for(var i:uint = 1; i < size; i++) {
	            _constantUIntPool.push(input.position);
				
	            input.readEncodedU32();
	        }
	    }
	
	    private function scanDoubleConstants(input:SWFData):void {
	        _constantDoublePool = new Vector.<uint>();
			_constantDoublePool.push(0);
			
	        const size:uint = input.readEncodedU32();
	        for(var i:uint = 1; i < size; i++) {
	            _constantDoublePool.push(input.position);
				
	            input.readDouble();
	        }
	    }
	
	    private function scanStringConstants(input:SWFData):void {
	        _constantStringPool = new Vector.<uint>();
			_constantStringPool.push(0);
			
	        const size:uint = input.readEncodedU32();
	        for(var i:uint = 1; i < size; i++) {
	            _constantStringPool.push(input.position);
				
	            const length:int = input.readEncodedU32();
	            input.skipBytes(length);
	        }
	    }
	
	    private function scanNamespaceConstants(input:SWFData):void {
			_constantNamespace = input.position;
	        _constantNamespacePool = new Vector.<uint>();
			_constantNamespacePool.push(0);
			
	        const size:uint = input.readEncodedU32();
	        for(var i:uint = 1; i < size; i++) {
	            _constantNamespacePool.push(input.position);
				
	            input.readUI8();
	            input.readEncodedU32();
	        }
	    }
	
	    private function scanNamespaceSetConstants(input:SWFData):void {
			_constantNamespaceSet = input.position;
	        _constantNamespaceSetPool = new Vector.<uint>();
			_constantNamespaceSetPool.push(0);
			
	        const size:uint = input.readEncodedU32();
	        for(var i:uint = 1; i < size; i++) {
	            _constantNamespaceSetPool.push(input.position);
				
	            const count:int = input.readEncodedU32();
	            input.skipEntries(count);
	        }
	    }
	
	    private function scanMultinameConstants(input:SWFData):void {
			_constantMultiname = input.position;
	        _constantMultinamePool = new Vector.<uint>();
			_constantMultinamePool.push(0);
			
	        const size:uint = input.readEncodedU32();
	        for(var i:uint = 1; i < size; i++) {
	            _constantMultinamePool.push(input.position);
				
	            const kind:uint = input.readUI8();
	            switch(kind) {
		            case 7: // '\007'
		            case 13: // '\r'
		                input.readEncodedU32();
		                input.readEncodedU32();
		                break;
		
		            case 15: // '\017'
		            case 16: // '\020'
		                input.readEncodedU32();
		                break;
		
		            case 9: // '\t'
		            case 14: // '\016'
		                input.readEncodedU32();
		                input.readEncodedU32();
		                break;
		
		            case 27: // '\033'
		            case 28: // '\034'
		                input.readEncodedU32();
		                break;
		
		            case 29: // '\035'
		                input.readEncodedU32();
		                const count:uint = input.readEncodedU32();
		                input.skipEntries(count);
		                break;
		
		            case 8: // '\b'
		            case 10: // '\n'
		            case 11: // '\013'
		            case 12: // '\f'
		            case 19: // '\023'
		            case 20: // '\024'
		            case 21: // '\025'
		            case 22: // '\026'
		            case 23: // '\027'
		            case 24: // '\030'
		            case 25: // '\031'
		            case 26: // '\032'
		            default:
		                throw new Error("Invalid constant type: " + kind);
		
		            case 17: // '\021'
		            case 18: // '\022'
		                break;
	            }
	        }
	    }
	
	    private function scanMethods(input:SWFData):void {
			_methodInfo = input.position;
	        _methodInfos = new Vector.<uint>();
			_methodInfosName = new Vector.<uint>();
			
	        const size:uint = input.readEncodedU32();
	        for(var i:uint = 0; i < size; i++) {
	            _methodInfos.push(input.position);
				
	            const paramCount:uint = input.readEncodedU32();
	            input.readEncodedU32();
	            input.skipEntries(paramCount);
				
				_methodInfosName.push(input.position);
				
	            input.readEncodedU32();
	            const flags:uint = input.readUI8();
	            const optionalCount:uint = (flags & 8) == 0 ? 0 : input.readEncodedU32();
	            for(var j:uint = 0; j < optionalCount; j++) {
	                input.readEncodedU32();
	                input.readUI8();
	            }
	
	            const paramNameCount:uint = (flags & 0x80) == 0 ? 0 : paramCount;
	            for(var k:uint = 0; k < paramNameCount; k++) {
	                input.readEncodedU32();
				}
	        }
	    }
	
	    private function scanMetadata(input:SWFData):void {
			_metadataInfo = input.position;
	        _metadataInfos = new Vector.<uint>();
			
	        const size:uint = input.readEncodedU32();
	        for(var i:uint = 0; i < size; i++) {
	            _metadataInfos.push(input.position);
				
	            input.readEncodedU32();
	            const value_count:uint = input.readEncodedU32();
	            input.skipEntries(value_count * 2);
	        }
	    }
	
	    private function scanInstances(input:SWFData):void {
			_instanceInfo = input.position;
	        _instanceInfos = new Vector.<uint>();
			
			const size:uint = input.readEncodedU32();
	        for(var i:uint = 0; i < size; i++) {
	            _instanceInfos.push(input.position);
				
	            input.skipEntries(2);
	            const flags:uint = input.readUI8();
	            if((flags & 8) != 0)
	                input.readEncodedU32();
	            const interfaceCount:uint = input.readEncodedU32();
	            input.skipEntries(interfaceCount);
	            input.readEncodedU32();
				
	            _instanceTraitInfo.push(scanTraits(input));
	        }
	    }
	
	    private function scanClasses(input:SWFData):void {
			_classInfo = input.position;
	        _classInfos = new Vector.<uint>();
			
	        for(var i:uint = 0; i < _instanceInfos.length; i++) {
	            _classInfos.push(input.position);
				
	            input.readEncodedU32();
	            _classTraitInfo.push(scanTraits(input));
	        }
	    }
	
	    private function scanScripts(input:SWFData):void {
			_scriptInfo = input.position;
	        _scriptInfos = new Vector.<uint>();
			
	        const size:uint = input.readEncodedU32();
	        for(var i:uint = 0; i < size; i++) {
	            _scriptInfos.push(input.position);
	            input.readEncodedU32();
				
	            _scriptTraitInfo.push(scanTraits(input));
	        }
	    }
	
	    private function scanMethodBodies(input:SWFData):void {
			_methodBodyInfo = input.position;
	        _methodBodyInfos = new Vector.<uint>();
			
	        const size:uint = input.readEncodedU32();
	        for(var i:uint = 0; i < size; i++) {
	            _methodBodyInfos.push(input.position);
				
	            input.skipEntries(5);
	            const codeLength:uint = input.readEncodedU32();
	            input.skipBytes(codeLength);
	            scanExceptions(input);
				
	            _methodBodyTraitInfo.push(scanTraits(input));
	        }
	    }
	
	    private function scanExceptions(input:SWFData):void {
	        const count:uint = input.readEncodedU32();
			const version:uint =  (input[0] & 0xff) | ((input[1] & 0xff) << 8);
	        if(version == 15)
	            input.skipEntries(count * 4);
	        else
	            input.skipEntries(count * 5);
	    }
	
	    private function scanTraits(input:SWFData):Vector.<uint> {
	        const count:uint = input.readEncodedU32();
			const positions:Vector.<uint> = new Vector.<uint>();
	        for(var i:uint = 0; i < count; i++) {
				positions.push(input.position);
				
	            input.readEncodedU32();
	            const kind:uint = input.readUI8();
	            const tag:uint = kind & 0xf;
	            switch(tag) {
		            case 0: // '\0'
		            case 6: // '\006'
		                input.skipEntries(2);
		                const valueId:uint = input.readEncodedU32();
		                if(valueId > 0)
		                    input.readUI8();
		                break;
		
		            case 1: // '\001'
		            case 2: // '\002'
		            case 3: // '\003'
		                input.skipEntries(2);
		                break;
		
		            case 4: // '\004'
		            case 5: // '\005'
		                input.skipEntries(2);
		                break;
		
		            default:
		                throw new Error("invalid trait type: " + tag);
		                break;
	            }
	            if((kind >> 4 & 4) != 0) {
	                const metadata:uint = input.readEncodedU32();
	                input.skipEntries(metadata);
	            }
	        }
			
			return positions;
		}
		
		public function get name():String { return "ABCScanner"; }
		
		public function toString(indent:uint=0) : String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "MinorVersion: " + _minorVersion;
			str += "\n" + StringUtils.repeat(indent + 2) + "MajorVersion: " + _majorVersion;
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Constant Pool:";
			str += "\n" + StringUtils.repeat(indent + 4) + "Integer: " + _constantIntPool;
			str += "\n" + StringUtils.repeat(indent + 4) + "UnsignedInteger: " + _constantUIntPool;
			str += "\n" + StringUtils.repeat(indent + 4) + "Double: " + _constantDoublePool;
			str += "\n" + StringUtils.repeat(indent + 4) + "String: " + _constantStringPool;
			str += "\n" + StringUtils.repeat(indent + 4) + "Namespace: " + _constantNamespacePool;
			str += "\n" + StringUtils.repeat(indent + 4) + "NamespaceSet: " + _constantNamespaceSetPool;
			str += "\n" + StringUtils.repeat(indent + 4) + "Multiname: " + _constantMultinamePool;
			
			str += "\n" + StringUtils.repeat(indent + 2) + "MethodInfo: " + _methodInfos;
			str += "\n" + StringUtils.repeat(indent + 2) + "MetadataInfo: " + _metadataInfos;
			str += "\n" + StringUtils.repeat(indent + 2) + "InstanceInfo: " + _instanceInfos;
			str += "\n" + StringUtils.repeat(indent + 2) + "ClassInfo: " + _classInfos;
			str += "\n" + StringUtils.repeat(indent + 2) + "ScriptInfo: " + _scriptInfos;
			str += "\n" + StringUtils.repeat(indent + 2) + "MethodBodyInfo: " + _methodBodyInfos;
			
			return str;
		}
	}
}
