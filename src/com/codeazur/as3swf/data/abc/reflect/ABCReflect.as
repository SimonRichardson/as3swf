package com.codeazur.as3swf.data.abc.reflect
{
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCDataSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.io.ABCReader;
	import com.codeazur.as3swf.tags.ITag;
	import com.codeazur.as3swf.tags.TagDoABC;
	
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflect {
		
		private var _swf:SWF;
		private var _abcDataSet:ABCDataSet;
		
		public function ABCReflect(swf:SWF){
			_swf = swf;
			_abcDataSet = new ABCDataSet();
			
			loadABCData();
		}
				
		public function getAllClasses():Vector.<ABCReflectClass> {
			const classes:Vector.<ABCReflectClass> = new Vector.<ABCReflectClass>();
			
			const total:uint = _abcDataSet.length;
			for(var i:uint=0; i<total; i++) {
				const data:ABCData = _abcDataSet.getAt(i);
				const classesTotal:uint = data.instanceInfoSet.length;
				for(var j:uint=0; j<classesTotal; j++) {
					const instance:ABCInstanceInfo = data.instanceInfoSet.getAt(j);
					
					const reflect:ABCReflectClass = ABCReflectClass.create(instance.qname);
					classes.push(reflect);
				}
			}
			
			return classes;
		}
		
		private function loadABCData():void {
			const tags:Vector.<ITag> = swf.getTagsByClassType(TagDoABC);
			const total:uint = tags.length;
			for(var i:uint=0; i<total; i++) {
				const tag:TagDoABC = TagDoABC(tags[i]);
				
				trace(i, tag);
				
				const abcReader:ABCReader = new ABCReader(tag.bytes);
				const abcData:ABCData = new ABCData();
				abcReader.read(abcData);
				
				_abcDataSet.add(abcData);
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
