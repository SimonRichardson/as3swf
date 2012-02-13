package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.utils.StringUtils;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCTraitClassInfo extends ABCTraitInfo
	{
		
		public var id:uint;
		public var index:uint;
		public var classInfo:ABCClassInfo;

		public function ABCTraitClassInfo(abcData : ABCData) {
			super(abcData);
		}
		
		public static function create(data:ABCData, qname:IABCMultiname, kind:ABCTraitInfoKind):ABCTraitClassInfo {
			const classInfo:ABCTraitClassInfo = new ABCTraitClassInfo(data);
			classInfo.qname = qname;
			classInfo.kind = kind;
			return classInfo;
		}
		
		override public function parse(data : SWFData, scanner:ABCScanner) : void {
			super.parse(data, scanner);
			
			id = data.readEncodedU30();
			index = data.readEncodedU30();
			
			classInfo = getClassInfoByIndex(index);
		}

		override public function get name() : String { return "ABCTraitClassInfo"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "ID: " + id;
			str += "\n" + StringUtils.repeat(indent + 2) + "Index: " + index;
			str += "\n" + StringUtils.repeat(indent + 2) + "ClassInfo: ";
			str += "\n" + classInfo.toString(indent + 4);
			
			return str;
		}
	}
}
