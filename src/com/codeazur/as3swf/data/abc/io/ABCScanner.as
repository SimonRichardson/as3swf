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
		private var _constantNamespacePool:Vector.<uint>;
		private var _constantNamespaceSetPool:Vector.<uint>;
		private var _constantMultinamePool : Vector.<uint>;

		private var _methodInfo : Vector.<uint>;
		private var _metadataInfo : Vector.<uint>;
		private var _instanceInfo : Vector.<uint>;
		private var _classInfo : Vector.<uint>;
		private var _scriptInfo : Vector.<uint>;
		private var _methodBodyInfo : Vector.<uint>;
		
		public function ABCScanner() {
		}
		
		public function scan(input:SWFData):void {
			const position:uint = input.position;
			input.position = 0;
			
			_minorVersion = scanMinorVersion(input);
			_majorVersion = scanMajorVersion(input);
			
			_constantIntPool = scanIntConstants(input);
			_constantUIntPool = scanUIntConstants(input);
			_constantDoublePool = scanDoubleConstants(input);
			_constantStringPool = scanStringConstants(input);
			_constantNamespacePool = scanNamespaceConstants(input);
			_constantNamespaceSetPool = scanNamespaceSetConstants(input);
			_constantMultinamePool = scanMultinameConstants(input);
			
			_methodInfo = scanMethods(input);
			_metadataInfo = scanMetadata(input);
			
			const size:uint = input.readEncodedU32();
			_instanceInfo = scanInstances(input, size);
			_classInfo = scanClasses(input, size);
			
			_scriptInfo = scanScripts(input);
			_methodBodyInfo = scanMethodBodies(input);
			
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

		public function getConstantNamespaceAtIndex(index:uint):uint {
			return _constantNamespacePool[index];
		}

		public function getConstantNamespaceSetAtIndex(index:uint):uint	{
			return _constantNamespaceSetPool[index];
		}

		public function getConstantMultinameAtIndex(index:uint):uint {
			return _constantMultinamePool[index];
		}
		
		public function getMethodInfoAtIndex(index:uint):uint {
			return _methodInfo[index];
		}
		
		public function getMetadataInfoAtIndex(index:uint):uint {
			return _metadataInfo[index];
		}
		
		public function getInstanceInfoAtIndex(index:uint):uint {
			return _instanceInfo[index];
		}
		
		public function getClassInfoByIndex(index:uint):uint {
			return _classInfo[index];
		}
		
		public function getScriptInfoAtIndex(index:uint):uint {
			return _scriptInfo[index];
		}

		private function scanMinorVersion(input:SWFData) : uint	{
        	const position:uint = input.position;
        	input.skipEntries(2);
        	return position;
    	}

	    private function scanMajorVersion(input:SWFData):uint {
	        const position:uint = input.position;
	        input.skipBytes(2);
	        return position;
	    }
	
	    private function scanIntConstants(input:SWFData):Vector.<uint> {
	        const size:uint = input.readEncodedU32();
	        const positions:Vector.<uint> = new Vector.<uint>();
			positions.push(0);
	        for(var i:uint = 1; i < size; i++) {
	            positions.push(input.position);
	            input.readEncodedU32();
	        }
	
	        return positions;
	    }
	
	    private function scanUIntConstants(input:SWFData):Vector.<uint> {
	        const size:uint = input.readEncodedU32();
	        const positions:Vector.<uint> = new Vector.<uint>();
			positions.push(0);
	        for(var i:uint = 1; i < size; i++) {
	            positions.push(input.position);
	            input.readEncodedU32();
	        }
	
	        return positions;
	    }
	
	    private function scanDoubleConstants(input:SWFData):Vector.<uint> {
	        const size:uint = input.readEncodedU32();
	        const positions:Vector.<uint> = new Vector.<uint>();
			positions.push(0);
	        for(var i:uint = 1; i < size; i++) {
	            positions.push(input.position);
	            input.readDouble();
	        }
	
	        return positions;
	    }
	
	    private function scanStringConstants(input:SWFData):Vector.<uint> {
	        const size:uint = input.readEncodedU32();
	        const positions:Vector.<uint> = new Vector.<uint>();
			positions.push(0);
	        for(var i:uint = 1; i < size; i++) {
	            positions.push(input.position);
	            const length:int = input.readEncodedU32();
	            input.skipBytes(length);
	        }
	
	        return positions;
	    }
	
	    private function scanNamespaceConstants(input:SWFData):Vector.<uint> {
	        const size:uint = input.readEncodedU32();
	        const positions:Vector.<uint> = new Vector.<uint>();
			positions.push(0);
	        for(var i:uint = 1; i < size; i++) {
	            positions.push(input.position);
	            input.readUI8();
	            input.readEncodedU32();
	        }
	
	        return positions;
	    }
	
	    private function scanNamespaceSetConstants(input:SWFData):Vector.<uint> {
	        const size:uint = input.readEncodedU32();
	        const positions:Vector.<uint> = new Vector.<uint>();
			positions.push(0);
	        for(var i:uint = 1; i < size; i++) {
	            positions.push(input.position);
	            const count:int = input.readEncodedU32();
	            input.skipEntries(count);
	        }
	
	        return positions;
	    }
	
	    private function scanMultinameConstants(input:SWFData):Vector.<uint> {
	        const size:uint = input.readEncodedU32();
	        const positions:Vector.<uint> = new Vector.<uint>();
			positions.push(0);
	        for(var i:uint = 1; i < size; i++) {
	            positions.push(input.position);
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
	
	        return positions;
	    }
	
	    private function scanMethods(input:SWFData):Vector.<uint> {
	        const size:uint = input.readEncodedU32();
	        const positions:Vector.<uint> = new Vector.<uint>();
	        for(var i:uint = 0; i < size; i++) {
	            positions.push(input.position);
	            const paramCount:uint = input.readEncodedU32();
	            input.readEncodedU32();
	            input.skipEntries(paramCount);
	            input.readEncodedU32();
	            const flags:uint = input.readUI8();
	            const optionalCount:uint = (flags & 8) == 0 ? 0 : input.readEncodedU32();
	            for(var j:uint = 0; j < optionalCount; j++) {
	                input.readEncodedU32();
	                input.readUI8();
	            }
	
	            const paramNameCount:uint = (flags & 0x80) == 0 ? 0 : paramCount;
	            for(var k:uint = 0; k < paramNameCount; k++)
	                input.readEncodedU32();
	
	        }
	
	        return positions;
	    }
	
	    private function scanMetadata(input:SWFData):Vector.<uint> {
	        const size:uint = input.readEncodedU32();
	        const positions:Vector.<uint> = new Vector.<uint>();
	        for(var i:uint = 0; i < size; i++) {
	            positions.push(input.position);
	            input.readEncodedU32();
	            const value_count:uint = input.readEncodedU32();
	            input.skipEntries(value_count * 2);
	        }
	
	        return positions;
	    }
	
	    private function scanInstances(input:SWFData, size:uint):Vector.<uint> {
	        const positions:Vector.<uint> = new Vector.<uint>();
	        for(var i:uint = 0; i < size; i++) {
	            positions.push(input.position);
	            input.skipEntries(2);
	            const flags:uint = input.readUI8();
	            if((flags & 8) != 0)
	                input.readEncodedU32();
	            const interfaceCount:uint = input.readEncodedU32();
	            input.skipEntries(interfaceCount);
	            input.readEncodedU32();
				
	            scanTraits(input);
	        }
	
	        return positions;
	    }
	
	    private function scanClasses(input:SWFData, size:uint):Vector.<uint> {
	        const positions:Vector.<uint> = new Vector.<uint>();
	        for(var i:uint = 0; i < size; i++) {
	            positions.push(input.position);
	            input.readEncodedU32();
	            scanTraits(input);
	        }
	
	        return positions;
	    }
	
	    private function scanScripts(input:SWFData):Vector.<uint> {
	        const size:uint = input.readEncodedU32();
	        const positions:Vector.<uint> = new Vector.<uint>();
	        for(var i:uint = 0; i < size; i++) {
	            positions.push(input.position);
	            input.readEncodedU32();
	            scanTraits(input);
	        }
	
	        return positions;
	    }
	
	    private function scanMethodBodies(input:SWFData):Vector.<uint> {
	        const size:uint = input.readEncodedU32();
	        const positions:Vector.<uint> = new Vector.<uint>();
	        for(var i:uint = 0; i < size; i++) {
	            positions.push(input.position);
	            input.skipEntries(5);
	            const codeLength:uint = input.readEncodedU32();
	            input.skipBytes(codeLength);
	            scanExceptions(input);
	            scanTraits(input);
	        }
	
	        return positions;
	    }
	
	    private function scanExceptions(input:SWFData):void {
	        const count:uint = input.readEncodedU32();
			const version:uint =  (input[0] & 0xff) | ((input[1] & 0xff) << 8);
	        if(version == 15)
	            input.skipEntries(count * 4);
	        else
	            input.skipEntries(count * 5);
	    }
	
	    private function scanTraits(input:SWFData):void {
	        const count:uint = input.readEncodedU32();
	        for(var i:uint = 0; i < count; i++) {
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
			
			str += "\n" + StringUtils.repeat(indent + 2) + "MethodInfo: " + _methodInfo;
			str += "\n" + StringUtils.repeat(indent + 2) + "MetadataInfo: " + _metadataInfo;
			str += "\n" + StringUtils.repeat(indent + 2) + "InstanceInfo: " + _instanceInfo;
			str += "\n" + StringUtils.repeat(indent + 2) + "ClassInfo: " + _classInfo;
			str += "\n" + StringUtils.repeat(indent + 2) + "ScriptInfo: " + _scriptInfo;
			str += "\n" + StringUtils.repeat(indent + 2) + "MethodBodyInfo: " + _methodBodyInfo;
			
			return str;
		}
	}
}
