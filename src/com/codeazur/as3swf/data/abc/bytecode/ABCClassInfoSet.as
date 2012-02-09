package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCClassInfoSet extends ABCSet {
		
		public var classInfos:Vector.<ABCClassInfo>;
		
		public function ABCClassInfoSet(abcData:ABCData) {
			super(abcData);
			
			classInfos = new Vector.<ABCClassInfo>();
		}
		
		override public function parse(data : SWFData) : void
		{
			const total:uint = abcData.instanceInfoSet.length;
			for(var i:uint=0; i<total; i++) {
				const instanceInfo:ABCInstanceInfo = getInstanceInfoByIndex(i);
				
				const classQName:IABCMultiname = instanceInfo.qname;
				
				const staticIndex:uint = data.readEncodedU30();
				const staticInitialiser:ABCMethodInfo = getMethodInfoByIndex(staticIndex);
				
				const classInfo:ABCClassInfo = ABCClassInfo.create(abcData, classQName, staticInitialiser);
				classInfo.parse(data);
				
				instanceInfo.classInfo = classInfo;
				classInfos.push(classInfo);
			}
		}
		
		public function getAt(index:uint):ABCClassInfo {
			return classInfos[index];
		}
		
		override public function get name():String { return "ABCClassInfoSet"; }
		override public function get length():uint { return classInfos.length; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			if(classInfos.length > 0) {
				for(var i:uint=0; i<classInfos.length; i++) {
					str += "\n" + classInfos[i].toString(indent + 4);
				}
			}
			
			return str;
		}
	}
}
