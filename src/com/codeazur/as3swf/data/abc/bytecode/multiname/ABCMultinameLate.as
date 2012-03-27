package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCMultinameLate extends ABCBaseMultiname {
		
		public var namespaces:ABCNamespaceSet;

		public function ABCMultinameLate() {}
		
		public static function create(namespaces:ABCNamespaceSet, kind:int = -1):ABCMultinameLate{
			const mname:ABCMultinameLate = new ABCMultinameLate();
			mname.namespaces = namespaces;
			mname.kind = kind < 0? ABCMultinameKind.MULTINAME_LATE : ABCMultinameKind.getType(kind);
			return mname;
		}
		
		override public function equals(multiname : IABCMultiname) : Boolean {
			if(this == multiname) {
				return true;
			} else if(multiname is ABCMultinameLate && namespaces.equals(ABCMultinameLate(multiname).namespaces)) {
				return super.equals(multiname);
			}
			return false;
		}
		
		override public function get name():String { return "ABCMultinameLate"; }
		
		override public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "NamespaceSet: ";
			str += "\n" + namespaces.toString(indent + 4);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Kind: ";
			str += "\n" + kind.toString(indent + 4);
			
			return str;
		}
	}
}
