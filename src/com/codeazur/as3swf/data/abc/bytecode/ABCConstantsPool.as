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
		
		public function ABCConstantsPool() {
			integerPool = new Vector.<int>();
			unsignedIntegerPool = new Vector.<uint>();
			doublePool = new Vector.<Number>();
			stringPool = new Vector.<String>();
			namespacePool = new Vector.<ABCNamespace>();
		}
		
		public function parse(data : SWFData) : void {
			var index:int = 0;
			var length:int = 0;
			
			length = data.readEncodedU32();
			index = (length > 0) ? --length : 0;
			while(index--){
				integerPool.push(data.readEncodedU32());
			}
			
			length = data.readEncodedU32();
			index = (length > 0) ? --length : 0;
			while(index--){
				unsignedIntegerPool.push(data.readEncodedU32());	
			}
			
			length = data.readEncodedU32();
			index = (length > 0) ? --length : 0;
			while(index--){
				doublePool.push(data.readDouble());
			}
			
			length = data.readEncodedU32();
			index = (length > 0) ? --length : 0;
			while(index--){
				length = data.readEncodedU32();
				stringPool.push(data.readUTFBytes(length));
			}
			
			length = data.readEncodedU32();
			index = (length > 0) ? --length : 0;
			while(index--){
				const nsType:uint = 255 & data.readByte();
				length = data.readEncodedU32();
				namespacePool.push(ABCNamespace.create(nsType, stringPool[length]));
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
			return str;
		}
	}
}
