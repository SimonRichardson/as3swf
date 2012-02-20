package com.codeazur.as3swf.data.abc.bytecode.multiname
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespaceSet;
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
		
		override public function get name():String { return "ABCMultinameLate"; }
		
		override public function toString(indent:uint = 0) : String {
			return ABC.toStringCommon(name, indent) +
				"NamespaceSet: " + namespaces + ", " +
				"Kind: " + kind;
		}
		
	}
}
