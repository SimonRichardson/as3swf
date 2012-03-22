package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceKind;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCMultinameGeneric;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCMultinameKind;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCMultinameLate;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamedMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespace;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceSet;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceType;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCRuntimeQualifiedName;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCRuntimeQualifiedNameLate;
	import com.codeazur.as3swf.data.abc.io.ABCScanner;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCConstantsPool {
		
		public var integerPool:Vector.<int>;
		public var unsignedIntegerPool:Vector.<uint>;
		public var doublePool:Vector.<Number>;
		public var stringPool:Vector.<String>;
		public var namespacePool:Vector.<ABCNamespace>;
		public var namespaceSetPool:Vector.<ABCNamespaceSet>;
		public var multinamePool:Vector.<IABCMultiname>;
		
		private var _abcData:ABCData;
		
		public function ABCConstantsPool(abcData:ABCData) {
			_abcData = abcData;
			
			integerPool = new Vector.<int>();
			integerPool.push(0);
			
			unsignedIntegerPool = new Vector.<uint>();
			unsignedIntegerPool.push(0);
			
			doublePool = new Vector.<Number>();
			doublePool.push(NaN);
			
			const asterisk : ABCNamespace = ABCNamespace.getType(ABCNamespaceType.ASTERISK);
			
			stringPool = new Vector.<String>();
			stringPool.push(asterisk.value);
			
			namespacePool = new Vector.<ABCNamespace>();
			namespacePool.push(asterisk);
			
			namespaceSetPool = new Vector.<ABCNamespaceSet>();
			namespaceSetPool.push(ABCNamespaceSet.create(new <ABCNamespace>[asterisk]));
			
			multinamePool = new Vector.<IABCMultiname>();
			multinamePool.push(ABCQualifiedName.create(asterisk.value, asterisk));
		}
		
		public function merge(value:ABCConstantsPool):void {
			var i:uint;
			var total:uint;
			
			total = value.integerPool.length;
			for(i=0; i<total; i++) {
				addInteger(value.integerPool[i]);
			}
			
			total = value.unsignedIntegerPool.length;
			for(i=0; i<total; i++) {
				addUnsignedInteger(value.unsignedIntegerPool[i]);
			}
			
			total = value.doublePool.length;
			for(i=0; i<total; i++) {
				addDouble(value.doublePool[i]);
			}
			
			total = value.stringPool.length;
			for(i=0; i<total; i++) {
				addString(value.stringPool[i]);
			}
			
			total = value.namespacePool.length;
			for(i=0; i<total; i++) {
				addNamespace(value.namespacePool[i]);
			}
			
			total = value.namespaceSetPool.length;
			for(i=0; i<total; i++) {
				const nsSet:ABCNamespaceSet = value.namespaceSetPool[i];
				addNamespaceSet(nsSet);
			}
			
			total = value.multinamePool.length;
			for(i=0; i<total; i++) {
				const abcMultiname:IABCMultiname = value.multinamePool[i];
				addMultiname(abcMultiname);
			}
		}
		
		public function read(data:SWFData, scanner:ABCScanner) : void {
			
			var ref:uint = 0;
			var index:int = 0;
			var sIndex:uint = 0;
			
			index = data.readEncodedU32();
			sIndex = 1;
			while(--index > 0){
				data.position = scanner.getConstantIntegerAtIndex(sIndex++);
				
				integerPool.push(data.readEncodedU32());
			}
			
			index = data.readEncodedU32();
			sIndex = 1;
			while(--index > 0){
				data.position = scanner.getConstantUnsignedIntegerAtIndex(sIndex++);
				
				unsignedIntegerPool.push(data.readEncodedU32());	
			}
			
			index = data.readEncodedU32();
			sIndex = 1;
			while(--index > 0){
				data.position = scanner.getConstantDoubleAtIndex(sIndex++);
				
				doublePool.push(data.readDouble());
			}
			
			index = data.readEncodedU32();
			sIndex = 1;
			while(--index > 0){
				data.position = scanner.getConstantStringAtIndex(sIndex++);
				
				const strLength:uint = data.readEncodedU32();
				const str:String = data.readUTFBytes(strLength);
				if (strLength != str.length) {
					throw new Error("String length mismatch (expected=" + strLength + ", recieved=" + str.length + ")");
				}
				stringPool.push(str);
			}
			
			data.position = scanner.getConstantNamespace();
			index = data.readEncodedU32();
			sIndex = 1;
			while(--index > 0){
				data.position = scanner.getConstantNamespaceAtIndex(sIndex++); 
				
				const nsByte:int = data.readByte();
				const nsKind:uint = 255 & nsByte;
				const strPoolIndex:uint = data.readEncodedU32();
				if(strPoolIndex >= stringPool.length){
					throw new Error();
				}
				const nsName:String = getStringByIndex(strPoolIndex);
				
				const abcNamespace:ABCNamespace = ABCNamespace.create(nsKind, nsName);
				abcNamespace.byte = nsByte;
				
				namespacePool.push(abcNamespace);
			}
			
			data.position = scanner.getConstantNamespaceSet();
			index = data.readEncodedU32();
			sIndex = 1;
			while(--index > 0){
				data.position = scanner.getConstantNamespaceSetAtIndex(sIndex++); 
				
				const nsSet:ABCNamespaceSet = ABCNamespaceSet.create();
				
				const nsIndex:uint = data.readEncodedU32(); 
				while(--nsIndex > -1){
					const nsPoolIndex:uint = data.readEncodedU32();
					if(nsPoolIndex > namespacePool.length){
						throw new Error();
					}
					nsSet.namespaces.push(getNamespaceByIndex(nsPoolIndex));
				}
				
				namespaceSetPool.push(nsSet);
			}

			data.position = scanner.getConstantMultiname();
			index = data.readEncodedU32();
			sIndex = 1;
			while(--index > 0) {
				data.position = scanner.getConstantMultinameAtIndex(sIndex++); 
				
				var multiname:IABCMultiname;
				const multinameByte:int = data.readByte();
				
				const kind : uint = 255 & multinameByte;
				if(kind == 0x07 || kind == 0x0D){
					
					ref = data.readEncodedU32();
					const ns:ABCNamespace = getNamespaceByIndex(ref);
					ref = data.readEncodedU32();
					const name:String = getStringByIndex(ref);
					multiname = ABCQualifiedName.create(name, ns, kind);
					
				} else if(kind == 0x0f || kind == 0x10){
					
					ref = data.readEncodedU32();
					const strRQname:String = getStringByIndex(ref);
					multiname = ABCRuntimeQualifiedName.create(strRQname, kind);
					
				} else if(kind == 0x11 || kind == 0x12){
					
					multiname = ABCRuntimeQualifiedNameLate.create(kind);
					
				} else if(kind == 0x09 || kind == 0x0E){
					
					ref = data.readEncodedU32();
					const strMName:String = getStringByIndex(ref);
					ref = data.readEncodedU32();
					const namespaces:ABCNamespaceSet = getNamespaceSetByIndex(ref);
					multiname = ABCMultiname.create(strMName, namespaces, kind);
					
				} else if(kind == 0x1B || kind == 0x1C){
					
					ref = data.readEncodedU32();
					const namespacesLate:ABCNamespaceSet = getNamespaceSetByIndex(ref);
					multiname = ABCMultinameLate.create(namespacesLate, kind);
					
				} else if(kind == 0x1D){
					
					ref = data.readEncodedU32();
					const qname:IABCMultiname = getMultinameByIndex(ref);
					ref = data.readEncodedU32();
					var paramIndex:int = ref;
					const params:Vector.<IABCMultiname> = new Vector.<IABCMultiname>();
					
					while(--paramIndex > -1){
						ref = data.readEncodedU32();
						const param:IABCMultiname = getMultinameByIndex(ref);
						params.push(param);
					}
					multiname = ABCMultinameGeneric.create(qname, params);
					
				} else {
					throw new Error();
				}
				
				multiname.byte = multinameByte;
				multinamePool.push(multiname);
			}
		}
		
		public function write(bytes:SWFData):void {
			
			var i:int = 0;
			var total:int = 0;
			
			total = integerPool.length;
			bytes.writeEncodedU32(calculatePoolTotal(total));
			
			for(i=1; i<total; i++) {
				bytes.writeEncodedU32(integerPool[i]);
			}
			
			total = unsignedIntegerPool.length;
			bytes.writeEncodedU32(calculatePoolTotal(total));
			
			for(i=1; i<total; i++) {
				bytes.writeEncodedU32(unsignedIntegerPool[i]);
			}
			
			total = doublePool.length;
			bytes.writeEncodedU32(calculatePoolTotal(total));
			
			for(i=1; i<total; i++) {
				bytes.writeDouble(doublePool[i]);
			}
			
			total = stringPool.length;
			bytes.writeEncodedU32(calculatePoolTotal(total));
			
			for(i=1; i<total; i++) {
				const string:String = stringPool[i];
				bytes.writeEncodedU32(string.length);
				bytes.writeUTFBytes(string);
			}
						
			total = namespacePool.length;
			bytes.writeEncodedU32(calculatePoolTotal(total));
			
			for(i=1; i<total; i++) {
				const ns:ABCNamespace = namespacePool[i];
				bytes.writeUI8(ns.byte);
				bytes.writeEncodedU32(getStringIndex(ns.value));
			}
				
			total = namespaceSetPool.length;
			bytes.writeEncodedU32(calculatePoolTotal(total));
			for(i=1; i<total; i++) {
				const nsSet:ABCNamespaceSet = namespaceSetPool[i];
				const nsSetTotal:int = nsSet.length;
				bytes.writeEncodedU32(nsSetTotal);
				
				for(var j:int=0; j<nsSetTotal; j++) {
					const index:int = getNamespaceIndex(nsSet.getAt(j));
					bytes.writeEncodedU32(index);
				}
			}
												
			total = multinamePool.length;
			bytes.writeEncodedU32(calculatePoolTotal(total));
			
			for(i=1; i<total; i++) {
				const abcMultiname:IABCMultiname = multinamePool[i];
				
				bytes.writeByte(abcMultiname.byte);
				
				switch(abcMultiname.kind) {
					case ABCMultinameKind.QNAME:
					case ABCMultinameKind.QNAME_A:
						
						const qname:ABCQualifiedName = abcMultiname.toQualifiedName();
						bytes.writeEncodedU32(getNamespaceIndex(qname.ns));
						bytes.writeEncodedU32(getStringIndex(qname.label));
						break;
					
					case ABCMultinameKind.RUNTIME_QNAME:
					case ABCMultinameKind.RUNTIME_QNAME_A:
						const runtime:ABCRuntimeQualifiedName = ABCRuntimeQualifiedName(abcMultiname);
						bytes.writeEncodedU32(getStringIndex(runtime.label));
						break;
						
					case ABCMultinameKind.RUNTIME_QNAME_LATE:
					case ABCMultinameKind.RUNTIME_QNAME_LATE_A:
						// does nothing.
						break;
						
					case ABCMultinameKind.MULTINAME:
					case ABCMultinameKind.MULTINAME_A:
						
						const multiname:ABCMultiname = ABCMultiname(abcMultiname);
						bytes.writeEncodedU32(getStringIndex(multiname.label));
						bytes.writeEncodedU32(getNamespaceSetIndex(multiname.namespaces));
						break;
					
					case ABCMultinameKind.MULTINAME_LATE:
					case ABCMultinameKind.MULTINAME_LATE_A:
						
						const multinameLate:ABCMultinameLate = ABCMultinameLate(abcMultiname);
						bytes.writeEncodedU32(getNamespaceSetIndex(multinameLate.namespaces));
						break;
						
					case ABCMultinameKind.GENERIC:
						const generic:ABCMultinameGeneric = ABCMultinameGeneric(abcMultiname);
						
						bytes.writeEncodedU32(getMultinameIndex(generic.qname));
						
						const multinameTotal:int = generic.params.length;
						bytes.writeEncodedU32(multinameTotal);
						
						for(var k:int=0; k<multinameTotal; k++) {
							bytes.writeEncodedU32(getMultinameIndex(generic.params[k]));
						}
						break;
					
					default:	
						throw new Error();
				}
			}
		}
		
		public function addInteger(integer:int):void {
			if(getIntegerIndex(integer) < 0) {
				integerPool.push(integer);
			}
		}
		
		public function getIntegerIndex(integer:int):int {
			return integerPool.indexOf(integer);
		}
		
		public function getIntegerByIndex(index:uint):int {
			return integerPool[index];
		}
		
		public function addUnsignedInteger(unsignedInteger:uint):void {
			if(getUnsignedIntegerIndex(unsignedInteger) < 0) {
				unsignedIntegerPool.push(unsignedInteger);
			}
		}
		
		public function getUnsignedIntegerIndex(unsignedInteger:uint):int {
			return unsignedIntegerPool.indexOf(unsignedInteger);
		}
		
		public function getUnsignedIntegerByIndex(index:uint):uint {
			return unsignedIntegerPool[index];
		}
		
		public function addDouble(double:Number):void {
			if(getDoubleIndex(double) < 0) {
				doublePool.push(double);
			}
		}
		
		public function getDoubleIndex(double:Number):int {
			return doublePool.indexOf(double);
		}
		
		public function getDoubleByIndex(index:uint):Number {
			return doublePool[index];
		}
		
		public function addString(string:String):void {
			if(getStringIndex(string) < 0) {
				stringPool.push(string);
			}
		}
		
		public function getStringIndex(string:String):int {
			return stringPool.indexOf(string);
		}
		
		public function getStringByIndex(index:uint):String {
			return stringPool[index];
		}
		
		public function addMultiname(multiname:IABCMultiname):void {
			if(getMultinameIndex(multiname) < 0) {
				// Make sure we add the correct items to the pool if they're missing.
				switch(multiname.kind) {
					case ABCMultinameKind.QNAME:
					case ABCMultinameKind.QNAME_A:
					case ABCMultinameKind.RUNTIME_QNAME:
					case ABCMultinameKind.RUNTIME_QNAME_A:
					case ABCMultinameKind.RUNTIME_QNAME_LATE:
					case ABCMultinameKind.RUNTIME_QNAME_LATE_A:
						// does nothing.
						break;
						
					case ABCMultinameKind.MULTINAME:
					case ABCMultinameKind.MULTINAME_A:
						const mname:ABCMultiname = ABCMultiname(multiname);
						addNamespaceSet(mname.namespaces);
						break;
					
					case ABCMultinameKind.MULTINAME_LATE:
					case ABCMultinameKind.MULTINAME_LATE_A:
						addNamespaceSet(ABCMultinameLate(multiname).namespaces);
						break;
						
					case ABCMultinameKind.GENERIC:
						const generic:ABCMultinameGeneric = ABCMultinameGeneric(multiname);
						
						addMultiname(generic.qname);
						
						const multinameTotal:int = generic.params.length;
						for(var k:int=0; k<multinameTotal; k++) {
							addMultiname(generic.params[k]);
						}
						break;
					
					default:	
						throw new Error();
				}
				
				if(multiname is ABCNamedMultiname) {
					const nmname:ABCNamedMultiname = ABCNamedMultiname(multiname);
					addString(nmname.label);
				}
				
				const qname:ABCQualifiedName = multiname.toQualifiedName();
				if(qname && qname.ns) {
					addNamespace(qname.ns);
				}
						
				multinamePool.push(multiname);
			}
		}
		
		public function getMultinameIndex(multiname:IABCMultiname):int {
			var index:int = -1;
			var contains:Boolean = false;
			
			const total:uint = multinamePool.length;
			for(var i:uint=0; i<total; i++) {
				const m:IABCMultiname = multinamePool[i];
				if(ABCMultinameKind.isType(m.kind, multiname.kind)) {
					switch(m.kind) {
						case ABCMultinameKind.QNAME:
						case ABCMultinameKind.QNAME_A:
						case ABCMultinameKind.RUNTIME_QNAME:
						case ABCMultinameKind.RUNTIME_QNAME_A:
						case ABCMultinameKind.RUNTIME_QNAME_LATE:
						case ABCMultinameKind.RUNTIME_QNAME_LATE_A:
							const qname0:ABCQualifiedName = m.toQualifiedName();
							const qname1:ABCQualifiedName = multiname.toQualifiedName();
							if(qname0 == qname1) {
								return i;
							} else if(qname0.label == qname1.label && ABCNamespaceKind.isType(qname0.ns.kind, qname1.ns.kind)) {
								return i;
							}
							break;
							
						case ABCMultinameKind.MULTINAME:
						case ABCMultinameKind.MULTINAME_A:
							const mname0:ABCMultiname = ABCMultiname(m);
							const mname1:ABCMultiname = ABCMultiname(multiname);
							if(	mname0 === mname1) {
								return i;
							} else if(mname0.label == mname1.label && mname0.namespaces.length == mname1.namespaces.length) {
								contains = true;
								for(var j:uint=0; j<mname0.namespaces.length; j++) {
									const mnameNs0:ABCNamespace = mname0.namespaces.getAt(j);
									const mnameNs1:ABCNamespace = mname1.namespaces.getAt(j);
									if(!mnameNs0.equals(mnameNs1)) {
										contains = false;
										break;
									}
								}
								if(contains) {
									return i;
								}
							}
							break;
						
						case ABCMultinameKind.MULTINAME_LATE:
						case ABCMultinameKind.MULTINAME_LATE_A:
							const mnameLate0:ABCMultinameLate = ABCMultinameLate(m);
							const mnameLate1:ABCMultinameLate = ABCMultinameLate(multiname);
							if(mnameLate0.namespaces.length == mnameLate1.namespaces.length) {
								contains = true;
								for(var k:uint=0; k<mnameLate0.namespaces.length; k++) {
									const mnameLateNs0:ABCNamespace = mnameLate0.namespaces.getAt(k);
									const mnameLateNs1:ABCNamespace = mnameLate1.namespaces.getAt(k);
									if(!mnameLateNs0.equals(mnameLateNs1)) {
										contains = false;
										break;
									}
								}
								if(contains) {
									return i;
								}
							}
							break;
							
						case ABCMultinameKind.GENERIC:
							const generic0:ABCMultinameGeneric = ABCMultinameGeneric(m);
							const generic1:ABCMultinameGeneric = ABCMultinameGeneric(multiname);
							if(generic0.qname.equals(generic1.qname) && generic0.params.length == generic1.params.length) {
								contains = true;
								for(var l:uint=0; l<generic0.params.length; l++) {
									const genericMultiname0:IABCMultiname = generic0.params[l];
									const genericMultiname1:IABCMultiname = generic1.params[l];
									if(!genericMultiname0.equals(genericMultiname1)) {
										contains = false;
										break;
									}
								}
								if(contains) {
									return i;
								}
							}
							break;
						
						default:	
							throw new Error();
					}
				}
			}
			
			return index;
		}
		
		public function getMultinameByIndex(index:uint):IABCMultiname {
			return multinamePool[index];
		}
		
		public function addNamespace(ns:ABCNamespace):void {
			if(getNamespaceIndex(ns) < 0) {
				addString(ns.value);
				namespacePool.push(ns);
			}
		}
		
		public function getNamespaceIndex(ns:ABCNamespace):int {
			var index:int = -1;
			
			const total:uint = namespacePool.length;
			for(var i:uint=0; i<total; i++) {
				const n:ABCNamespace = namespacePool[i];
				
				if(ABCNamespace.isType(n, ns)) {
					index = i;
					break;
				}
			}
			
			return index;
		}
		
		public function getNamespaceByIndex(index:uint):ABCNamespace {
			return namespacePool[index];
		}
		
		public function addNamespaceSet(ns:ABCNamespaceSet):void {
			if(getNamespaceSetIndex(ns) < 0) { 
				ns.abcData = _abcData;
				
				const total:uint = ns.length;
				for(var i:uint=0; i<total; i++) {
					addNamespace(ns.getAt(i));
				}
				
				namespaceSetPool.push(ns);
			}
		}
		
		public function getNamespaceSetIndex(namespaceSet:ABCNamespaceSet):int {
			var index:int = -1;
			
			const total:uint = namespaceSetPool.length;
			for(var i:uint=0; i<total; i++) {
				const ns:ABCNamespaceSet = namespaceSetPool[i];
				if(ns.length == namespaceSet.length) {
					var contains:Boolean = true;
					
					const namespaceSetTotal:uint = namespaceSet.length;
					for(var j:uint=0; j<namespaceSetTotal; j++) {
						const nsNamespace:ABCNamespace = ns.getAt(j);
						if(getNamespaceIndex(nsNamespace) < 0) {
							contains = false;
							break;
						}
					}
					
					if(contains) {
						index = i;
						break;
					}
				}
			}
			
			return index;
		}
		
		public function getNamespaceSetByIndex(index:uint):ABCNamespaceSet {
			return namespaceSetPool[index];
		}
		
		public function getPoolItemByKindAtIndex(kind:ABCConstantKind, index:uint):* {
			var item:*;
			switch(kind) {
				case ABCConstantKind.INT:
					item = getIntegerByIndex(index);
					break;
					
				case ABCConstantKind.UINT:
					item = getUnsignedIntegerByIndex(index);
					break;	
				
				case ABCConstantKind.DOUBLE:
					item = getDoubleByIndex(index);
					break;
				
				case ABCConstantKind.UTF8:
					item = getStringByIndex(index);
					break;
				
				case ABCConstantKind.NAMESPACE:
				case ABCConstantKind.PACKAGE_NAMESPACE:
				case ABCConstantKind.PACKAGE_INTERNAL_NAMESPACE:
				case ABCConstantKind.PROTECTED_NAMESPACE:
				case ABCConstantKind.EXPLICIT_NAMESPACE:
				case ABCConstantKind.STATIC_PROTECTED_NAMESPACE:
				case ABCConstantKind.PRIVATE_NAMESPACE:
					item = getNamespaceByIndex(index);
					break;
				
				case ABCConstantKind.TRUE:
					item = true;
					break;
				
				case ABCConstantKind.FALSE:
					item = false;
					break;
				
				case ABCConstantKind.NULL:
					item = null;
					break;
				
				case ABCConstantKind.UNDEFINED:
					item = undefined;
					break;
			}
			
			return item;
		}
		
		private function calculatePoolTotal(value:uint):uint {
			return value <= 1 ? 0 : value;
		}
		
		public function get name():String { return "ABCConstantsPool"; }
		
		public function toString(indent:uint = 0) : String {
			var i:uint;
			var str:String = ABC.toStringCommon(name, indent);
			
			if(integerPool.length > 0) { 
				str += "\n" + StringUtils.repeat(indent + 2) + "IntegerPool:";
				for(i = 0; i < integerPool.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + integerPool[i].toString();
				}
			}
			if(unsignedIntegerPool.length > 0) { 
				str += "\n" + StringUtils.repeat(indent + 2) + "UnsignedIntegerPool:";
				for(i = 0; i < unsignedIntegerPool.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + unsignedIntegerPool[i].toString();
				}
			}
			if(doublePool.length > 0) { 
				str += "\n" + StringUtils.repeat(indent + 2) + "DoublePool:";
				for(i = 0; i < doublePool.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + doublePool[i].toString();
				}
			}
			if(stringPool.length > 0) { 
				str += "\n" + StringUtils.repeat(indent + 2) + "StringPool:";
				for(i = 0; i < stringPool.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + stringPool[i].toString();
				}
			}
			if(namespacePool.length > 0) { 
				str += "\n" + StringUtils.repeat(indent + 2) + "NamespacePool:";
				for(i = 0; i < namespacePool.length; i++) {
					str += "\n" + namespacePool[i].toString(indent + 4);
				}
			}
			if(namespaceSetPool.length > 0) { 
				str += "\n" + StringUtils.repeat(indent + 2) + "NamespaceSetPool:";
				for(i = 0; i < namespaceSetPool.length; i++) {
					str += "\n" + namespaceSetPool[i].toString(indent + 4);
				}
			}
			
			if(multinamePool.length > 0) { 
				str += "\n" + StringUtils.repeat(indent + 2) + "MultinamePool:";
				for(i = 0; i < multinamePool.length; i++) {
					str += "\n" + multinamePool[i].toString(indent + 4);
				}
			}
			
			return str;
		}
	}
}
