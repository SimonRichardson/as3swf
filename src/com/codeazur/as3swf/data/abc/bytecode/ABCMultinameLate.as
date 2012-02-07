package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCMultinameLate extends ABCBaseMultiname {
		
		public var namespaces:ABCNamespaceSet;

		public function ABCMultinameLate() {}
		
		public static function create(namespaces:ABCNamespaceSet, kind:uint = NaN):ABCMultinameLate{
			const mname:ABCMultinameLate = new ABCMultinameLate();
			mname.namespaces = namespaces;
			mname.kind = isNaN(kind)? ABCMultinameKind.MULTINAME_LATE : ABCMultinameKind.getType(kind);
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
