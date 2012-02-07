package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.utils.StringUtils;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
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
			unsignedIntegerPool = new Vector.<uint>();
			doublePool = new Vector.<Number>();
			stringPool = new Vector.<String>();
			namespacePool = new Vector.<ABCNamespace>();
			namespaceSetPool = new Vector.<ABCNamespaceSet>();
			multinamePool = new Vector.<IABCMultiname>();
		}
		
		public function parse(data : SWFData) : void {
			var ref:uint = 0;
			var index:int = 0;
						
			index = data.readEncodedU32();
			while(--index > 0){
				integerPool.push(data.readEncodedU32());
			}
			
			index = data.readEncodedU32();
			while(--index > 0){
				unsignedIntegerPool.push(data.readEncodedU32());	
			}
			
			index = data.readEncodedU32();
			while(--index > 0){
				doublePool.push(data.readDouble());
			}
			
			index = data.readEncodedU32();
			while(--index > 0){
				const strLength:uint = data.readEncodedU32();
				const str:String = data.readUTFBytes(strLength);
				if (strLength != str.length) {
					throw new Error();	
				}
				stringPool.push(str);
			}
			
			index = data.readEncodedU32();
			while(--index > 0){
				const nsKind:uint = 255 & data.readByte();
				const strPoolIndex:uint = data.readEncodedU32();
				if(strPoolIndex >= stringPool.length){
					throw new Error();
				}
				namespacePool.push(ABCNamespace.create(nsKind, stringPool[strPoolIndex - 1]));
			}
			
			index = data.readEncodedU32();
			while(--index > 0){
				const nsSet:ABCNamespaceSet = ABCNamespaceSet.create();
				
				const nsIndex:uint = data.readEncodedU32(); 
				while(--nsIndex > 0){
					const nsPoolIndex:uint = data.readEncodedU32();
					if(nsPoolIndex >= namespacePool.length){
						throw new Error();
					}
					nsSet.namespaces.push(namespacePool[nsPoolIndex]);
				}
				
				namespaceSetPool.push(nsSet);
			}
			
			index = data.readEncodedU32();
			while(--index > 0) {
				const kind : uint = 255 & data.readByte();
				if(kind == 0x07 || kind == 0x0D){
					ref = data.readEncodedU32();
					const ns:ABCNamespace = namespacePool[ref];
					ref = data.readEncodedU32();
					const name:String = stringPool[ref];
					multinamePool.push(ABCQualifiedName.create(name, ns, kind));
				} else if(kind == 0x0f || kind == 0x10){
					ref = data.readEncodedU32();
					const strRQname:String = stringPool[ref];
					multinamePool.push(ABCRuntimeQualifiedName.create(strRQname, kind));
				} else if(kind == 0x11 || kind == 0x12){
					multinamePool.push(ABCRuntimeQualifiedNameLate.create(kind));
				} else if(kind == 0x09 || kind == 0x0E){
					ref = data.readEncodedU32();
					const strMName:String = stringPool[ref];
					ref = data.readEncodedU32();
					const namespaces:ABCNamespaceSet = namespaceSetPool[ref];
					multinamePool.push(ABCMultiname.create(strMName, namespaces, kind));
				} else if(kind == 0x1B || kind == 0x1C){
					ref = data.readEncodedU32();
					const namespacesLate:ABCNamespaceSet = namespaceSetPool[ref];
					multinamePool.push(ABCMultinameLate.create(namespacesLate, kind));
				} else if(kind == 0x1D){
					ref = data.readEncodedU32();
					const qname:IABCMultiname = multinamePool[ref];
					ref = data.readEncodedU32();
					var paramIndex:int = ref;
					const params:Vector.<IABCMultiname> = new Vector.<IABCMultiname>();
					while(--paramIndex > 0){
						ref = data.readEncodedU32();
						const param:IABCMultiname = multinamePool[ref];
						params.push(param);
					}
					multinamePool.push(ABCMultinameGeneric.create(qname, params));
				}
			}
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
			return str;
		}
	}
}
