package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.utils.StringUtils;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCTraitMethodInfo extends ABCTraitInfo
	{
		
		public var id:uint;
		public var isStatic:Boolean;
		public var methodInfo:ABCMethodInfo;
		
		public function ABCTraitMethodInfo(abcData : ABCData) {
			super(abcData);
		}
		
		public static function create(data:ABCData, qname:IABCMultiname, kind:ABCTraitInfoKind, isStatic:Boolean = false):ABCTraitMethodInfo {
			const trait:ABCTraitMethodInfo = new ABCTraitMethodInfo(data);
			trait.qname = qname;
			trait.kind = kind;
			trait.isStatic = isStatic;
			return trait;
		}
		
		override public function parse(data : SWFData) : void {
			super.parse(data);
			
			id = data.readEncodedU30();
			
			const index:uint = data.readEncodedU30();
			methodInfo = getMethodInfoByIndex(index);
		}

		override public function get name() : String { return "ABCTraitMethodInfo"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "ID: " + id;
			str += "\n" + StringUtils.repeat(indent + 2) + "Static: " + isStatic;
			
			if(methodInfo) {
				str += "\n" + StringUtils.repeat(indent + 2) + "MethodInfo: ";
				str += "\n" + methodInfo.toString(indent + 4);
			}
			
			return str;
		}
	}
}
