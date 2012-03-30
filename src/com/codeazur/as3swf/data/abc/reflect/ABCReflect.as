package com.codeazur.as3swf.data.abc.reflect
{

	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCDataSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.io.ABCReader;
	import com.codeazur.as3swf.tags.ITag;
	import com.codeazur.as3swf.tags.TagDoABC;
	
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflect {
		
		private var _swf:SWF;
		private var _abcDataSet:ABCDataSet;
		
		private var _instances:Vector.<IABCReflectInstance>;
		
		public function ABCReflect(swf:SWF){
			_swf = swf;
			_abcDataSet = new ABCDataSet();
			
			loadABCData();
			populateInstances();
		}
		
		public function getAllInstances():Vector.<IABCReflectInstance> {
			return _instances;
		}
		
		public function getAllClasses():Vector.<ABCReflectClass> {
			const classes:Vector.<ABCReflectClass> = new Vector.<ABCReflectClass>();
			
			const instances:Vector.<IABCReflectInstance> = getAllInstances();
			
			const total:uint = instances.length;
			for(var i:uint=0; i<total; i++) {
				const instance:IABCReflectInstance = instances[i];
				if(ABCReflectKind.isType(instance.kind, ABCReflectKind.CLASS)) {
					classes.push(instance);
				}
			}
			
			return classes;
		}
		
		public function getAllInterfaces():Vector.<ABCReflectInterface> {
			const classes:Vector.<ABCReflectInterface> = new Vector.<ABCReflectInterface>();
			
			const instances:Vector.<IABCReflectInstance> = getAllInstances();
			
			const total:uint = instances.length;
			for(var i:uint=0; i<total; i++) {
				const instance:IABCReflectInstance = instances[i];
				if(ABCReflectKind.isType(instance.kind, ABCReflectKind.INTERFACE)) {
					classes.push(instance);
				}
			}
			
			return classes;
		}
		
		public function getInstanceByQualifiedName(qname:ABCQualifiedName):IABCReflectInstance {
			var result:IABCReflectInstance = null;
			
			const instances:Vector.<IABCReflectInstance> = getAllInstances();
			
			const total:uint = instances.length;
			for(var i:uint=0; i<total; i++) {
				const item:IABCReflectInstance = instances[i];
				if(item.qname.equals(qname)) {
					result = item;
					break;
				}
			}
			
			return result;
		}
		
		private function loadABCData():void {
			const tags:Vector.<ITag> = swf.getTagsByClassType(TagDoABC);
			const total:uint = tags.length;
			for(var i:uint=0; i<total; i++) {
				const tag:TagDoABC = TagDoABC(tags[i]);
				const abcReader:ABCReader = new ABCReader(tag.bytes);
				const abcData:ABCData = new ABCData();
				abcReader.read(abcData);
				
				_abcDataSet.add(abcData);
			}
		}
		
		private function populateInstances():void {
			_instances = new Vector.<IABCReflectInstance>();
			
			const total:uint = _abcDataSet.length;
			for(var i:uint=0; i<total; i++) {
				const data:ABCData = _abcDataSet.getAt(i);
				const classesTotal:uint = data.instanceInfoSet.length;
				for(var j:uint=0; j<classesTotal; j++) {
					const instance:ABCInstanceInfo = data.instanceInfoSet.getAt(j);
					if(instance.isInterface) {
						const reflectInterface:ABCReflectInterface = ABCReflectInterface.create(instance.multiname);
						_instances.push(reflectInterface);
					} else {
						const reflectClass:ABCReflectClass = ABCReflectClass.create(instance.multiname, instance.traits);
						_instances.push(reflectClass);
					}
				}
			}	
		}
		
		public function get swf():SWF { return _swf; }
		public function get abcDataSet():ABCDataSet { return _abcDataSet; }
		
		public function get name():String { return "ABCReflect"; }
		
		public function toString(indent:uint = 0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
