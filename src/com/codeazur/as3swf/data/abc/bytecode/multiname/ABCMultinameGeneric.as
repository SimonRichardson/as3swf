package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCMultinameGeneric extends ABCBaseMultiname {

		public var qname:IABCMultiname;
		public var params:Vector.<IABCMultiname>;

		public function ABCMultinameGeneric() {}

		public static function create(qname:IABCMultiname, params:Vector.<IABCMultiname>, kind:int = -1):ABCMultinameGeneric {
			const mname:ABCMultinameGeneric = new ABCMultinameGeneric();
			mname.qname = qname;
			mname.params = params;
			mname.kind = kind < 0? ABCMultinameKind.GENERIC : ABCMultinameKind.getType(kind);
			return mname;
		}

		public function get length():uint { return params.length; }
		
		override public function get name():String { return "ABCMultinameGeneric"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "QName: ";
			str += "\n" + qname.toString(indent + 4);
			
			if(params) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Params: ";
				
				for(var i:int=0; i<params.length; i++) {
					 str += "\n" + params[i].toString(indent + 4);
				}
			}
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Kind: ";
			str += "\n" + kind.toString(indent + 4);
			
			return str;
		}
		
	}
}
