package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCScanner {

		public var minorVersion:uint;
		public var majorVersion:uint;
		
		public var constantIntPool:Vector.<uint>;
		public var constantUIntPool:Vector.<uint>;
		public var constantDoublePool:Vector.<uint>;
		public var constantStringPool:Vector.<uint>;
		public var constantNamespacePool:Vector.<uint>;
		public var constantNamespaceSetPool:Vector.<uint>;
		public var constantMultinamePool : Vector.<uint>;

		public var methodInfo : Vector.<uint>;
		public var metadataInfo : Vector.<uint>;
		public var instanceInfo : Vector.<uint>;
		public var classInfo : Vector.<uint>;
		public var scriptInfo : Vector.<uint>;
		public var methodBodyInfo : Vector.<uint>;
		
		public function ABCScanner() {
		}
		
		public function scan(input:SWFData):void {
			const position:uint = input.position;
			input.position = 0;
			
			minorVersion = scanMinorVersion(input);
			majorVersion = scanMajorVersion(input);
			
			constantIntPool = scanIntConstants(input);
			constantUIntPool = scanUIntConstants(input);
			constantDoublePool = scanDoubleConstants(input);
			constantStringPool = scanStringConstants(input);
			constantNamespacePool = scanNamespaceConstants(input);
			constantNamespaceSetPool = scanNamespaceSetConstants(input);
			constantMultinamePool = scanMultinameConstants(input);
			
			methodInfo = scanMethods(input);
			metadataInfo = scanMetadata(input);
			
			const size:uint = input.readEncodedU32();
			instanceInfo = scanInstances(input, size);
			classInfo = scanClasses(input, size);
			
			scriptInfo = scanScripts(input);
			methodBodyInfo = scanMethodBodies(input);
			
			input.position = position;
		}
		
		public function getConstantIntegerAtIndex(index:uint):uint
		{
			return constantIntPool[index];
		}

		public function getConstantUnsignedIntegerAtIndex(index:uint):uint
		{
			return constantUIntPool[index];
		}

		public function getConstantDoubleAtIndex(index:uint):uint
		{
			return constantDoublePool[index];
		}

		public function getConstantStringAtIndex(index:uint):uint
		{
			return constantStringPool[index];
		}

		public function getConstantNamespaceAtIndex(index:uint):uint
		{
			return constantNamespacePool[index];
		}

		public function getConstantNamespaceSetAtIndex(index:uint):uint
		{
			return constantNamespaceSetPool[index];
		}

		public function getConstantMultinameAtIndex(index:uint):uint
		{
			return constantMultinamePool[index];
		}

		private function scanMinorVersion(input:SWFData) : uint
		{
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
			
			str += "\n" + StringUtils.repeat(indent + 2) + "MinorVersion: " + minorVersion;
			str += "\n" + StringUtils.repeat(indent + 2) + "MajorVersion: " + majorVersion;
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Constant Pool:";
			str += "\n" + StringUtils.repeat(indent + 4) + "Integer: " + constantIntPool;
			str += "\n" + StringUtils.repeat(indent + 4) + "UnsignedInteger: " + constantUIntPool;
			str += "\n" + StringUtils.repeat(indent + 4) + "Double: " + constantDoublePool;
			str += "\n" + StringUtils.repeat(indent + 4) + "String: " + constantStringPool;
			str += "\n" + StringUtils.repeat(indent + 4) + "Namespace: " + constantNamespacePool;
			str += "\n" + StringUtils.repeat(indent + 4) + "NamespaceSet: " + constantNamespaceSetPool;
			str += "\n" + StringUtils.repeat(indent + 4) + "Multiname: " + constantMultinamePool;
			
			str += "\n" + StringUtils.repeat(indent + 2) + "MethodInfo: " + methodInfo;
			str += "\n" + StringUtils.repeat(indent + 2) + "MetadataInfo: " + metadataInfo;
			str += "\n" + StringUtils.repeat(indent + 2) + "InstanceInfo: " + instanceInfo;
			str += "\n" + StringUtils.repeat(indent + 2) + "ClassInfo: " + classInfo;
			str += "\n" + StringUtils.repeat(indent + 2) + "ScriptInfo: " + scriptInfo;
			str += "\n" + StringUtils.repeat(indent + 2) + "MethodBodyInfo: " + methodBodyInfo;
			
			return str;
		}
	}
}
