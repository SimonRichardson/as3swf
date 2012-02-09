package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCInstanceInfo extends ABCSet {
		
		public var qname:IABCMultiname;
		public var superMultiname:IABCMultiname;
		public var protectedNamespace : ABCNamespace;
		public var instanceInitialiser : ABCMethodInfo;
		
		public var traits:Vector.<ABCTraitInfo>;
		public var interfaceMultinames:Vector.<IABCMultiname>;

		public var flags : uint;

		public function ABCInstanceInfo(abcData:ABCData) {
			super(abcData);
			
			traits = new Vector.<ABCTraitInfo>();	
			interfaceMultinames = new Vector.<IABCMultiname>();
		}
		
		public static function create(abcData:ABCData, qname:IABCMultiname, superMultiname:IABCMultiname, flags:uint = 0):ABCInstanceInfo {
			const instance:ABCInstanceInfo = new ABCInstanceInfo(abcData);
			instance.qname = qname;
			instance.superMultiname = superMultiname;
			instance.flags = flags;
			return instance;
		}
		
		override public function parse(data:SWFData):void {
			if(isProtected) {
				const protectedIndex:uint = data.readEncodedU30();
				protectedNamespace = getNamespaceByIndex(protectedIndex);
			}
			
			const interfaceTotal:uint = data.readEncodedU30();
			for(var j:uint=0; j<interfaceTotal; j++) {
				const interfaceIndex:uint = data.readEncodedU30();
				const interfaceMName:IABCMultiname = getMultinameByIndex(interfaceIndex);
				
				interfaceMultinames.push(interfaceMName);
			}
			
			const initialiserIndex:uint = data.readEncodedU30();
			instanceInitialiser = getMethodInfoByIndex(initialiserIndex);
			
			
		}
		
		override public function get name() : String { return "ABCInstanceInfo"; }
		public function get isFinal():Boolean { 
			return ABCInstanceInfoFlags.isType(flags, ABCInstanceInfoFlags.FINAL); 
		}
		public function get isInterface():Boolean {
			return ABCInstanceInfoFlags.isType(flags, ABCInstanceInfoFlags.INTERFACE);
		}
		public function get isProtected():Boolean {
			return ABCInstanceInfoFlags.isType(flags, ABCInstanceInfoFlags.PROTECTED);
		}
		public function get isSealed():Boolean {
			return ABCInstanceInfoFlags.isType(flags, ABCInstanceInfoFlags.SEALED);
		}
		
		override public function toString(indent : uint = 0) : String {
			return super.toString(indent);
		}
	}
}
