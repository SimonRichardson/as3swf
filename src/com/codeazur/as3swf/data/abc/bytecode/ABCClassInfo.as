package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCTraitSet;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCClassInfo extends ABCTraitSet
	{

		public var qname:IABCMultiname;
		public var staticInitialiser:ABCMethodInfo;

		public function ABCClassInfo(abcData:ABCData) {
			super(abcData);
			
			isStatic = true;
		}
		
		public static function create(abcData:ABCData, qname:IABCMultiname, staticInitialiser:ABCMethodInfo):ABCClassInfo {
			const classInfo:ABCClassInfo = new ABCClassInfo(abcData);
			classInfo.qname = qname;
			classInfo.staticInitialiser = staticInitialiser;
			return classInfo;
		}
				
		override public function get name() : String { return "ABCClassInfo"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "QualifiedName: ";
			str += "\n" + qname.toString(indent + 4);
			str += "\n" + StringUtils.repeat(indent + 2) + "Number Traits: ";
			str += traits.length;
			
			if(traits.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Traits: ";
				for(var j:uint = 0; j<traits.length; j++) {
					str += "\n" + traits[j].toString(indent + 4);
				}
			}
			
			return str;
		}

	}
}
