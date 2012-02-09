package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCInstanceInfo extends ABCSet {
		
		public var qname:IABCMultiname;
		public var superMultiname:IABCMultiname;
		public var protectedNamespace:ABCNamespace;
		public var instanceInitialiser:ABCMethodInfo;
		
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
			
			const total:uint = data.readEncodedU30();
			for(var i:uint=0; i<total; i++) {
				const interfaceIndex:uint = data.readEncodedU30();
				const interfaceMName:IABCMultiname = getMultinameByIndex(interfaceIndex);
				
				interfaceMultinames.push(interfaceMName);
			}
			
			const initialiserIndex:uint = data.readEncodedU30();
			instanceInitialiser = getMethodInfoByIndex(initialiserIndex);
			
			const traitTotal:uint = data.readEncodedU30();
			for(var j:uint=0; j<traitTotal; j++) {
				const traitIndex:uint = data.readEncodedU30();
				const traitMName:IABCMultiname = getMultinameByIndex(traitIndex);
				const traitQName:IABCMultiname = traitMName.toQualifiedName();
				
				const traitKind:uint = data.readUI8();
				const trait:ABCTraitInfo = ABCTraitInfoFactory.create(abcData, traitKind, traitQName);
				trait.parse(data);
				
				traits.push(trait); 
			}
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
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "QualifiedName: ";
			str += "\n" + qname.toString(indent + 4);
			str += "\n" + StringUtils.repeat(indent + 2) + "SuperMultiname: ";
			str += "\n" + superMultiname.toString(indent + 4);
			
			if(isProtected) {
				str += "\n" + StringUtils.repeat(indent + 2) + "ProtectedNamespace: ";
				str += "\n" + protectedNamespace.toString(indent + 4);
			}
			
			if(interfaceMultinames.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "InterfaceMultinames: ";
				for(var i:uint = 0; i<interfaceMultinames.length; i++) {
					str += "\n" + interfaceMultinames[i].toString(indent + 4);
				}
			}
			
			if(traits.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Traits: ";
				for(var j:uint = 0; j<traits.length; j++) {
					str += "\n" + traits[j].toString(indent + 4);
				}
			}
			
			return str;
		}
	}
}
