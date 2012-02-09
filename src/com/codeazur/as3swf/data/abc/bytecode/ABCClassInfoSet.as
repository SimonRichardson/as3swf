package com.codeazur.as3swf.data.abc.bytecode
{
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
		
		public function getAt(index:uint):ABCClassInfo {
			return classInfos[index];
		}
		
		override public function get name() : String { return "ABCClassInfoSet"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			return str;
		}
	}
}
