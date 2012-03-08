package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCMultinameGeneric;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCMultinameLate;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamedMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCRuntimeQualifiedName;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCRuntimeQualifiedNameLate;
	import com.codeazur.as3swf.data.abc.io.ABCScanner;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCConstantsPool
	{
		
		public var integerPool:Vector.<int>;
		public var unsignedIntegerPool:Vector.<uint>;
		public var doublePool:Vector.<Number>;
		public var stringPool:Vector.<String>;
		public var namespacePool:Vector.<ABCNamespace>;
		public var namespaceSetPool:Vector.<ABCNamespaceSet>;
		public var multinamePool:Vector.<IABCMultiname>;
		
		public function ABCConstantsPool() {
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
					throw new Error();	
				}
				stringPool.push(str);
			}
			
			data.position = scanner.getConstantNamespace();
			index = data.readEncodedU32();
			sIndex = 1;
			while(--index > 0){
				data.position = scanner.getConstantNamespaceAtIndex(sIndex++); 
				
				const nsKind:uint = 255 & data.readByte();
				const strPoolIndex:uint = data.readEncodedU32();
				if(strPoolIndex >= stringPool.length){
					throw new Error();
				}
				const nsName:String = getStringByIndex(strPoolIndex);
				namespacePool.push(ABCNamespace.create(nsKind, nsName));
			}
			
			data.position = scanner.getConstantNamespaceSet();
			index = data.readEncodedU32();
			sIndex = 1;
			while(--index > 0){
				data.position = scanner.getConstantNamespaceSetAtIndex(sIndex++); 
				
				const nsSet:ABCNamespaceSet = ABCNamespaceSet.create();
				
				const nsIndex:uint = data.readEncodedU32(); 
				while(--nsIndex > 0){
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
				
				const kind : uint = 255 & data.readByte();
				if(kind == 0x07 || kind == 0x0D){
					ref = data.readEncodedU32();
					const ns:ABCNamespace = getNamespaceByIndex(ref);
					ref = data.readEncodedU32();
					const name:String = getStringByIndex(ref);
					multinamePool.push(ABCQualifiedName.create(name, ns, kind));
				} else if(kind == 0x0f || kind == 0x10){
					ref = data.readEncodedU32();
					const strRQname:String = getStringByIndex(ref);
					multinamePool.push(ABCRuntimeQualifiedName.create(strRQname, kind));
				} else if(kind == 0x11 || kind == 0x12){
					multinamePool.push(ABCRuntimeQualifiedNameLate.create(kind));
				} else if(kind == 0x09 || kind == 0x0E){
					ref = data.readEncodedU32();
					const strMName:String = getStringByIndex(ref);
					ref = data.readEncodedU32();
					const namespaces:ABCNamespaceSet = getNamespaceSetByIndex(ref);
					multinamePool.push(ABCMultiname.create(strMName, namespaces, kind));
				} else if(kind == 0x1B || kind == 0x1C){
					ref = data.readEncodedU32();
					const namespacesLate:ABCNamespaceSet = getNamespaceSetByIndex(ref);
					multinamePool.push(ABCMultinameLate.create(namespacesLate, kind));
				} else if(kind == 0x1D){
					ref = data.readEncodedU32();
					const qname:IABCMultiname = getMultinameByIndex(ref);
					ref = data.readEncodedU32();
					var paramIndex:int = ref;
					const params:Vector.<IABCMultiname> = new Vector.<IABCMultiname>();
					while(--paramIndex > 0){
						ref = data.readEncodedU32();
						const param:IABCMultiname = getMultinameByIndex(ref);
						params.push(param);
					}
					multinamePool.push(ABCMultinameGeneric.create(qname, params));
				}
			}
		}
		
		public function getIntegerByIndex(index:uint):int {
			return integerPool[index];
		}
		
		public function getUnsignedIntegerByIndex(index:uint):uint {
			return unsignedIntegerPool[index];
		}
		
		public function getDoubleByIndex(index:uint):Number {
			return doublePool[index];
		}
		
		public function addString(string:String):void {
			if(stringPool.indexOf(string) < 0) {
				stringPool.push(string);
			}
		}
		
		public function getStringByIndex(index:uint):String {
			return stringPool[index];
		}
		
		public function addMultiname(multiname:IABCMultiname):void {
			if(multiname is ABCNamedMultiname) {
				const nmname:ABCNamedMultiname = ABCNamedMultiname(multiname);
				addString(nmname.label);
			}
			
			if(multiname is ABCQualifiedName) {
				const qname:ABCQualifiedName = multiname.toQualifiedName();
				addNamespace(qname.ns);
			}
			
			if(multiname is ABCMultinameGeneric) {
				const gmname:ABCMultinameGeneric = ABCMultinameGeneric(multiname);
				addMultiname(gmname.qname);
				
				const total:uint = gmname.params.length;
				for(var i:uint=0; i<total; i++) {
					const qnameParam:ABCQualifiedName = gmname.params[i].toQualifiedName();
					addMultiname(qnameParam);
				}
			}
		}
		
		public function getMultinameByIndex(index:uint):IABCMultiname {
			return multinamePool[index];
		}
		
		public function addNamespace(ns:ABCNamespace):void {
			if(namespacePool.indexOf(ns) < 0) {
				namespacePool.push(ns);
			}
		}
		
		public function getNamespaceByIndex(index:uint):ABCNamespace {
			return namespacePool[index];
		}
		
		public function addNamespaceSet(ns:ABCNamespaceSet):void {
			if(namespaceSetPool.indexOf(ns) < 0) {
				namespaceSetPool.push(ns);
			}
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
