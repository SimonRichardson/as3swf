package com.codeazur.as3swf.data.abc.reflect
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectClass extends ABCReflectInstance {
		
		private var _instance:ABCInstanceInfo;
		private var _methods:Vector.<ABCReflectMethod>;
		
		private var _instanceTraits:Vector.<ABCTraitInfo>;
		private var _instanceMethods:Vector.<ABCMethodInfo>;
		
		public function ABCReflectClass(instance:ABCInstanceInfo, methods:Vector.<ABCMethodInfo>){
			super(instance.multiname);
			
			_instance = instance;
			_instanceTraits = instance.traits;
			_instanceMethods = methods;
		}
		
		public static function create(instance:ABCInstanceInfo, methods:Vector.<ABCMethodInfo>):ABCReflectClass {
			return new ABCReflectClass(instance, methods);
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

		override public function get name():String { return "ABCReflectClass"; }
		override public function get kind():ABCReflectKind { return ABCReflectKind.CLASS; }
		
		public function get isFinal():Boolean { return _instance.isFinal; }
		public function get isProtected():Boolean { return _instance.isProtected; }
		public function get isSealed():Boolean { return _instance.isSealed; }
	}
}
