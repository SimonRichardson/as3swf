package com.codeazur.as3swf.data.abc.reflect
{

	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceKind;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfo;
	import com.codeazur.as3swf.data.abc.reflect.traits.ABCReflectConstTrait;
	import com.codeazur.as3swf.data.abc.reflect.traits.ABCReflectTraitFactory;
	import com.codeazur.as3swf.data.abc.reflect.traits.IABCReflectTrait;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectClass extends ABCReflectInstance {
		
		private var _traits:Vector.<IABCReflectTrait>;		
		private var _instanceTraits:Vector.<ABCTraitInfo>;
		
		public function ABCReflectClass(qname:IABCMultiname, instanceTraits:Vector.<ABCTraitInfo>){
			super(qname);
			
			_instanceTraits = instanceTraits;
			
			populateTraits();
		}
		
		public static function create(qname:IABCMultiname, instanceTraits:Vector.<ABCTraitInfo>):ABCReflectClass {
			return new ABCReflectClass(qname, instanceTraits);
		}
		
		public function getInstanceTraits():Vector.<IABCReflectTrait> {
			return _traits;
		}
		
		public function getConstTraits(visiblity:ABCReflectMemberVisibility=null):Vector.<ABCReflectConstTrait> {
			visiblity = visiblity || ABCReflectMemberVisibility.ALL;
			
			const instances:Vector.<ABCReflectConstTrait> = new Vector.<ABCReflectConstTrait>();
			
			const traits:Vector.<IABCReflectTrait> = getInstanceTraits();
			const total:uint = traits.length;
			for(var i:uint=0; i<total; i++) {
				const trait:IABCReflectTrait = traits[i];
				if(trait is ABCReflectConstTrait) {
					const traitQName:ABCQualifiedName = trait.qname.toQualifiedName();
					if(ABCReflectMemberVisibility.isType(visiblity, ABCReflectMemberVisibility.ALL)) {
						instances.push(trait);
						
					} else if(	ABCReflectMemberVisibility.isType(visiblity, ABCReflectMemberVisibility.PRIVATE) && 
								ABCNamespaceKind.isType(traitQName.ns.kind, ABCNamespaceKind.PRIVATE_NAMESPACE)) {
						instances.push(trait);
						
					} else if(	ABCReflectMemberVisibility.isType(visiblity, ABCReflectMemberVisibility.PROTECTED) && 
								ABCNamespaceKind.isType(traitQName.ns.kind, ABCNamespaceKind.PROTECTED_NAMESPACE)) {
						instances.push(trait);
						
					} else if(	ABCReflectMemberVisibility.isType(visiblity, ABCReflectMemberVisibility.PUBLIC) && 
								ABCNamespaceKind.isType(traitQName.ns.kind, ABCNamespaceKind.PACKAGE_NAMESPACE)) {
						instances.push(trait);
					} else {
						throw new Error();
					}
				}
			}
			
			return instances;
		}
		
		private function populateTraits():void {
			_traits = new Vector.<IABCReflectTrait>();
			
			const total:uint = _instanceTraits.length;
			for(var i:uint=0; i<total; i++) {
				const instanceTrait:ABCTraitInfo = _instanceTraits[i];
				const trait:IABCReflectTrait = ABCReflectTraitFactory.create(instanceTrait);
				_traits.push(trait);
			}
		}
		
		override public function get name():String { return "ABCReflectClass"; }
		override public function get kind():ABCReflectKind { return ABCReflectKind.CLASS; }
	}
}
