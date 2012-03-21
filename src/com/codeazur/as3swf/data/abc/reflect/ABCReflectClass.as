package com.codeazur.as3swf.data.abc.reflect
{

	import com.codeazur.as3swf.data.abc.reflect.traits.ABCReflectMethodTrait;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceKind;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfo;
	import com.codeazur.as3swf.data.abc.reflect.traits.ABCReflectConstTrait;
	import com.codeazur.as3swf.data.abc.reflect.traits.ABCReflectGetterTrait;
	import com.codeazur.as3swf.data.abc.reflect.traits.ABCReflectSetterTrait;
	import com.codeazur.as3swf.data.abc.reflect.traits.ABCReflectSlotTrait;
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
					const visibiltyTrait:IABCReflectTrait = getTraitItemForVisibilty(trait, visiblity);
					if(visibiltyTrait) {
						instances.push(visibiltyTrait);
					}
				}
			}
			
			return instances;
		}
		
		public function getSlotTraits(visiblity:ABCReflectMemberVisibility=null):Vector.<ABCReflectSlotTrait> {
			visiblity = visiblity || ABCReflectMemberVisibility.ALL;
			
			const instances:Vector.<ABCReflectSlotTrait> = new Vector.<ABCReflectSlotTrait>();
			
			const traits:Vector.<IABCReflectTrait> = getInstanceTraits();
			const total:uint = traits.length;
			for(var i:uint=0; i<total; i++) {
				const trait:IABCReflectTrait = traits[i];
				if(trait is ABCReflectSlotTrait) {
					const visibiltyTrait:IABCReflectTrait = getTraitItemForVisibilty(trait, visiblity);
					if(visibiltyTrait) {
						instances.push(visibiltyTrait);
					}
				}
			}
			
			return instances;
		}
		
		public function getGetterTraits(visiblity:ABCReflectMemberVisibility=null):Vector.<ABCReflectGetterTrait> {
			visiblity = visiblity || ABCReflectMemberVisibility.ALL;
			
			const instances:Vector.<ABCReflectGetterTrait> = new Vector.<ABCReflectGetterTrait>();
			
			const traits:Vector.<IABCReflectTrait> = getInstanceTraits();
			const total:uint = traits.length;
			for(var i:uint=0; i<total; i++) {
				const trait:IABCReflectTrait = traits[i];
				if(trait is ABCReflectGetterTrait) {
					const visibiltyTrait:IABCReflectTrait = getTraitItemForVisibilty(trait, visiblity);
					if(visibiltyTrait) {
						instances.push(visibiltyTrait);
					}
				}
			}
			
			return instances;
		}
		
		public function getSetterTraits(visiblity:ABCReflectMemberVisibility=null):Vector.<ABCReflectSetterTrait> {
			visiblity = visiblity || ABCReflectMemberVisibility.ALL;
			
			const instances:Vector.<ABCReflectSetterTrait> = new Vector.<ABCReflectSetterTrait>();
			
			const traits:Vector.<IABCReflectTrait> = getInstanceTraits();
			const total:uint = traits.length;
			for(var i:uint=0; i<total; i++) {
				const trait:IABCReflectTrait = traits[i];
				if(trait is ABCReflectSetterTrait) {
					const visibiltyTrait:IABCReflectTrait = getTraitItemForVisibilty(trait, visiblity);
					if(visibiltyTrait) {
						instances.push(visibiltyTrait);
					}
				}
			}
			
			return instances;
		}
		
		public function getMethodTraits(visiblity:ABCReflectMemberVisibility=null):Vector.<ABCReflectMethodTrait> {
			visiblity = visiblity || ABCReflectMemberVisibility.ALL;
			
			const instances:Vector.<ABCReflectMethodTrait> = new Vector.<ABCReflectMethodTrait>();
			
			const traits:Vector.<IABCReflectTrait> = getInstanceTraits();
			const total:uint = traits.length;
			for(var i:uint=0; i<total; i++) {
				const trait:IABCReflectTrait = traits[i];
				if(trait is ABCReflectMethodTrait) {
					const visibiltyTrait:IABCReflectTrait = getTraitItemForVisibilty(trait, visiblity);
					if(visibiltyTrait) {
						instances.push(visibiltyTrait);
					}
				}
			}
			
			return instances;
		}
		
		public function getTraitByQualifiedName(qname:ABCQualifiedName):IABCReflectTrait {
			if(qname.ns && (qname.ns.value == super.qname.fullName || qname.ns.value.length == 0)) {
				const label:String = qname.label;
				
				const traits:Vector.<IABCReflectTrait> = getInstanceTraits();
				const total:uint = traits.length;
				for(var i:uint=0; i<total; i++) {
					const trait:IABCReflectTrait = traits[i];
					const traitQName:ABCQualifiedName = trait.qname.toQualifiedName();
					if(traitQName && (traitQName.label == label || traitQName.fullName == qname.fullName)) {
						return trait;
					}
				}
			}
			return null;
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
		
		private function getTraitItemForVisibilty(trait:IABCReflectTrait, visiblity:ABCReflectMemberVisibility):IABCReflectTrait {
			var instance:IABCReflectTrait = null;
			const traitQName:ABCQualifiedName = trait.qname.toQualifiedName();
			if(traitQName.ns && traitQName.ns.kind) {
				if(ABCReflectMemberVisibility.isType(visiblity, ABCReflectMemberVisibility.ALL)) {
					instance = trait;
					
				} else if(	ABCReflectMemberVisibility.isType(visiblity, ABCReflectMemberVisibility.INTERNAL) && 
							ABCNamespaceKind.isType(traitQName.ns.kind, ABCNamespaceKind.PACKAGE_INTERNAL_NAMESPACE)) {
					instance = trait;
					
				} else if(	ABCReflectMemberVisibility.isType(visiblity, ABCReflectMemberVisibility.NAMESPACE) && 
							ABCNamespaceKind.isType(traitQName.ns.kind, ABCNamespaceKind.NAMESPACE)) {
					instance = trait;
					
				} else if(	ABCReflectMemberVisibility.isType(visiblity, ABCReflectMemberVisibility.PUBLIC) && 
							ABCNamespaceKind.isType(traitQName.ns.kind, ABCNamespaceKind.PACKAGE_NAMESPACE)) {
					instance = trait;
					
				} else if(	ABCReflectMemberVisibility.isType(visiblity, ABCReflectMemberVisibility.PRIVATE) && 
							ABCNamespaceKind.isType(traitQName.ns.kind, ABCNamespaceKind.PRIVATE_NAMESPACE)) {
					instance = trait;
					
				} else if(	ABCReflectMemberVisibility.isType(visiblity, ABCReflectMemberVisibility.PROTECTED) && 
							ABCNamespaceKind.isType(traitQName.ns.kind, ABCNamespaceKind.PROTECTED_NAMESPACE)) {
					instance = trait;
					
				}
			}
			
			return instance;
		}
		
		override public function get name():String { return "ABCReflectClass"; }
		override public function get kind():ABCReflectKind { return ABCReflectKind.CLASS; }
	}
}
