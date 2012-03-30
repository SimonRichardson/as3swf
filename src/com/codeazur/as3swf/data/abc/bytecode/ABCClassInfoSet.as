package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	import com.codeazur.as3swf.data.abc.io.ABCScanner;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCClassInfoSet extends ABCSet {
		
		public var classInfos:Vector.<ABCClassInfo>;
		
		public function ABCClassInfoSet(abcData:ABCData) {
			super(abcData);
			
			classInfos = new Vector.<ABCClassInfo>();
		}
		
		public function merge(classInfoSet:ABCClassInfoSet):void {
			classInfoSet.abcData = abcData;
			
			const total:uint = classInfoSet.classInfos.length;
			for(var i:uint=0; i<total; i++) {
				const info:ABCClassInfo = classInfoSet.classInfos[i];
				info.abcData = abcData;
				
				classInfos.push(info);
			}
		}
		
		public function read(data:SWFData, scanner:ABCScanner):void {
			const position:uint = scanner.getClassInfo();
			if(data.position != position) {
				throw new Error('Invalid position (Expected: ' + data.position + ', Recieved: ' + position + ')');
			}
			
			data.position = position;
			
			const total:uint = abcData.instanceInfoSet.length;
			for(var i:uint=0; i<total; i++) {
				data.position = scanner.getClassInfoByIndex(i);
				
				const instanceInfo:ABCInstanceInfo = getInstanceInfoByIndex(i);
				
				const classQName:IABCMultiname = instanceInfo.multiname;
				
				const staticIndex:uint = data.readEncodedU30();
				const staticInitialiser:ABCMethodInfo = getMethodInfoByIndex(staticIndex);
				
				const classInfo:ABCClassInfo = ABCClassInfo.create(abcData, classQName, staticInitialiser);
				const classTraitPositions:Vector.<uint> = scanner.getClassTraitInfoAtIndex(i);
				classInfo.read(data, scanner, classTraitPositions);
				
				instanceInfo.classInfo = classInfo;
				classInfos.push(classInfo);
			}
		}
		
		public function write(bytes:SWFData):void {
			const total:uint = classInfos.length;
			for(var i:uint=0; i<total; i++) {
				const classInfo:ABCClassInfo = classInfos[i];
				bytes.writeEncodedU32(getMethodInfoIndex(classInfo.staticInitialiser));
				classInfo.write(bytes);
			}
		}
		
		public function getAt(index:uint):ABCClassInfo {
			return classInfos[index];
		}
		
		override public function get name():String { return "ABCClassInfoSet"; }
		override public function get length():uint { return classInfos.length; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Number ClassInfo: ";
			str += classInfos.length;
			
			if(classInfos.length > 0) {
				for(var i:uint=0; i<classInfos.length; i++) {
					str += "\n" + classInfos[i].toString(indent + 4);
				}
			}
			
			return str;
		}
	}
}
