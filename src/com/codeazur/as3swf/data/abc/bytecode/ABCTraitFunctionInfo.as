package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.io.ABCScanner;
	import com.codeazur.utils.StringUtils;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCTraitFunctionInfo extends ABCTraitInfo
	{
		
		public var id:uint;
		public var isStatic:Boolean;
		public var methodInfo:ABCMethodInfo;

		public function ABCTraitFunctionInfo(abcData : ABCData) {
			super(abcData);
		}
		
		public static function create(data:ABCData, qname:IABCMultiname, kind:uint, kindType:ABCTraitInfoKind, isStatic:Boolean = false):ABCTraitFunctionInfo {
			const trait:ABCTraitFunctionInfo = new ABCTraitFunctionInfo(data);
			trait.qname = qname;
			trait.kind = kind;
			trait.kindType = kindType;
			trait.isStatic = isStatic;
			return trait;
		}
		
		override public function parse(data:SWFData, scanner:ABCScanner):void {
			super.parse(data, scanner);
			
			id = data.readEncodedU30();
			
			const index:uint = data.readEncodedU30();
			methodInfo = getMethodInfoByIndex(index);
			methodInfo.methodName = ABCQualifiedName(qname).label;
		}

		override public function get name() : String { return "ABCTraitFunctionInfo"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "ID: " + id;
			str += "\n" + StringUtils.repeat(indent + 2) + "Static: " + isStatic;
			str += "\n" + StringUtils.repeat(indent + 2) + "MethodInfo: ";
			str += "\n" + methodInfo.toString(indent + 4);
			
			return str;
		}
	}
}
