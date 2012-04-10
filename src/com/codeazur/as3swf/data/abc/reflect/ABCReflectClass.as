package com.codeazur.as3swf.data.abc.reflect
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitConstInfo;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfo;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfoKind;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitSlotInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectClass extends ABCReflectInstance {
		
		private var _instance:ABCInstanceInfo;
		private var _constants:Vector.<ABCReflectConstant>;
		private var _variables:Vector.<ABCReflectVariable>;
		private var _methods:Vector.<ABCReflectMethod>;
		private var _getters:Vector.<ABCReflectGetter>;
		private var _setters:Vector.<ABCReflectSetter>;
		
		private var _instanceTraits:Vector.<ABCTraitInfo>;
		private var _instanceMethods:Vector.<ABCMethodInfo>;
		private var _instanceGetters:Vector.<ABCMethodInfo>;
		private var _instanceSetters:Vector.<ABCMethodInfo>;
		
		public function ABCReflectClass(instance:ABCInstanceInfo, 
										methods:Vector.<ABCMethodInfo>,
										getters:Vector.<ABCMethodInfo>,
										setters:Vector.<ABCMethodInfo>){
			super(instance.multiname);
			
			_instance = instance;
			_instanceTraits = instance.traits;
			_instanceMethods = methods;
			_instanceGetters = getters;
			_instanceSetters = setters;
		}
		
		public static function create(instance:ABCInstanceInfo, 
										methods:Vector.<ABCMethodInfo>,
										getters:Vector.<ABCMethodInfo>,
										setters:Vector.<ABCMethodInfo>):ABCReflectClass {
			return new ABCReflectClass(instance, methods, getters, setters);
		}
		
		public function getConstants(visbility:ABCReflectMemberVisibility=null):Vector.<ABCReflectConstant> {
			visbility = visbility || ABCReflectMemberVisibility.ALL;
						
			const instances:Vector.<ABCReflectConstant> = new Vector.<ABCReflectConstant>();
			
			if(!_constants) {
				populateConstants();
			}
			
			const total:uint = _constants.length;
			for(var i:uint=0; i<total; i++) {
				const constant:ABCReflectConstant = _constants[i];
				if(constant.multiname && constant.multiname is ABCQualifiedName) {
					const qname:ABCQualifiedName = ABCQualifiedName(constant.multiname);
					if(qname.ns) {
						const constVisbility:ABCReflectMemberVisibility = ABCReflectMemberVisibility.getType(qname.ns.kind);
						if(ABCReflectMemberVisibility.isType(constVisbility, visbility)) {
							instances.push(constant);
						}
					}
				}
			}
			return instances;
		}
		
		public function getVariables(visbility:ABCReflectMemberVisibility=null):Vector.<ABCReflectVariable> {
			visbility = visbility || ABCReflectMemberVisibility.ALL;
						
			const instances:Vector.<ABCReflectVariable> = new Vector.<ABCReflectVariable>();
			
			if(!_variables) {
				populateVariables();
			}
			
			const total:uint = _variables.length;
			for(var i:uint=0; i<total; i++) {
				const variable:ABCReflectVariable = _variables[i];
				if(variable.multiname && variable.multiname is ABCQualifiedName) {
					const qname:ABCQualifiedName = ABCQualifiedName(variable.multiname);
					if(qname.ns) {
						const constVisbility:ABCReflectMemberVisibility = ABCReflectMemberVisibility.getType(qname.ns.kind);
						if(ABCReflectMemberVisibility.isType(constVisbility, visbility)) {
							instances.push(variable);
						}
					}
				}
			}
			return instances;
		}
				
		public function getMethods(visbility:ABCReflectMemberVisibility=null):Vector.<ABCReflectMethod> {
			visbility = visbility || ABCReflectMemberVisibility.ALL;
						
			const instances:Vector.<ABCReflectMethod> = new Vector.<ABCReflectMethod>();
			
			if(!_methods) {
				populateMethods();
			}
			
			const total:uint = _methods.length;
			for(var i:uint=0; i<total; i++) {
				const method:ABCReflectMethod = _methods[i];
				if(method.multiname && method.multiname is ABCQualifiedName) {
					const qname:ABCQualifiedName = ABCQualifiedName(method.multiname);
					if(qname.ns) {
						const methodVisbility:ABCReflectMemberVisibility = ABCReflectMemberVisibility.getType(qname.ns.kind);
						if(ABCReflectMemberVisibility.isType(methodVisbility, visbility)) {
							instances.push(method);
						}
					}
				}
			}
			return instances;
		}
		
		public function getGetters(visbility:ABCReflectMemberVisibility=null):Vector.<ABCReflectGetter> {
			visbility = visbility || ABCReflectMemberVisibility.ALL;
			
			const instances:Vector.<ABCReflectGetter> = new Vector.<ABCReflectGetter>();
			
			if(!_getters) {
				populateGetters();
			}
			
			const total:uint = _getters.length;
			for(var i:uint=0; i<total; i++) {
				const getter:ABCReflectGetter = _getters[i];
				if(getter.multiname && getter.multiname is ABCQualifiedName) {
					const qname:ABCQualifiedName = ABCQualifiedName(getter.multiname);
					if(qname.ns) {
						const getterVisbility:ABCReflectMemberVisibility = ABCReflectMemberVisibility.getType(qname.ns.kind);
						if(ABCReflectMemberVisibility.isType(getterVisbility, visbility)) {
							instances.push(getter);
						}
					}
				}
			}
			return instances;
		}
		
		public function getSetters(visbility:ABCReflectMemberVisibility=null):Vector.<ABCReflectSetter> {
			visbility = visbility || ABCReflectMemberVisibility.ALL;
			
			const instances:Vector.<ABCReflectSetter> = new Vector.<ABCReflectSetter>();
			
			if(!_setters) {
				populateSetters();
			}
			
			const total:uint = _setters.length;
			for(var i:uint=0; i<total; i++) {
				const setter:ABCReflectSetter = _setters[i];
				if(setter.multiname && setter.multiname is ABCQualifiedName) {
					const qname:ABCQualifiedName = ABCQualifiedName(setter.multiname);
					if(qname.ns) {
						const setterVisbility:ABCReflectMemberVisibility = ABCReflectMemberVisibility.getType(qname.ns.kind);
						if(ABCReflectMemberVisibility.isType(setterVisbility, visbility)) {
							instances.push(setter);
						}
					}
				}
			}
			return instances;
		}
		
		private function populateConstants():void {
			_constants = new Vector.<ABCReflectConstant>();
			
			const total:uint = _instanceTraits.length;
			for(var i:uint=0; i<total; i++) {
				const traitInfo:ABCTraitInfo = _instanceTraits[i];
				if(ABCTraitInfoKind.isType(traitInfo.kind, ABCTraitInfoKind.CONST)) {
					const constInfo:ABCTraitConstInfo = ABCTraitConstInfo(traitInfo);
					if(constInfo.multiname) {
						_constants.push(ABCReflectConstant.create(constInfo));
					} else {
						throw new Error("Invalid const name (multiname: " + constInfo.multiname + ")");
					}
				}
			}
		}
		
		private function populateVariables():void {
			_variables = new Vector.<ABCReflectVariable>();
			
			const total:uint = _instanceTraits.length;
			for(var i:uint=0; i<total; i++) {
				const traitInfo:ABCTraitInfo = _instanceTraits[i];
				if(ABCTraitInfoKind.isType(traitInfo.kind, ABCTraitInfoKind.SLOT)) {
					const slotInfo:ABCTraitSlotInfo = ABCTraitSlotInfo(traitInfo);
					if(slotInfo.multiname) {
						_variables.push(ABCReflectVariable.create(slotInfo));
					} else {
						throw new Error("Invalid variable name (multiname: " + slotInfo.multiname + ")");
					}
				}
			}
		}
		
		private function populateMethods():void {
			_methods = new Vector.<ABCReflectMethod>();
			
			const total:uint = _instanceMethods.length;
			for(var i:uint=0; i<total; i++) {
				const method:ABCMethodInfo = _instanceMethods[i];
				// TODO (Simon) What do we do for invalid names
				if(method.multiname) {
					_methods.push(ABCReflectMethod.create(method));
				}
			}
		}
		
		private function populateGetters():void {
			_getters = new Vector.<ABCReflectGetter>();
			
			const total:uint = _instanceGetters.length;
			for(var i:uint=0; i<total; i++) {
				const getter:ABCMethodInfo = _instanceGetters[i];
				if(getter.multiname) {
					_getters.push(ABCReflectGetter.create(getter));
				} else {
					throw new Error("Invalid getter name (multiname: " + getter.multiname + ")");
				}
			}
		}
		
		private function populateSetters():void {
			_setters = new Vector.<ABCReflectSetter>();
			
			const total:uint = _instanceSetters.length;
			for(var i:uint=0; i<total; i++) {
				const setter:ABCMethodInfo = _instanceSetters[i];
				if(setter.multiname) {
					_setters.push(ABCReflectSetter.create(setter));
				} else {
					throw new Error("Invalid setter name (multiname: " + setter.multiname + ")");
				}
			}
		}

		override public function get name():String { return "ABCReflectClass"; }
		override public function get kind():ABCReflectKind { return ABCReflectKind.CLASS; }
		
		public function get isFinal():Boolean { return _instance.isFinal; }
		public function get isProtected():Boolean { return _instance.isProtected; }
		public function get isSealed():Boolean { return _instance.isSealed; }
	}
}
