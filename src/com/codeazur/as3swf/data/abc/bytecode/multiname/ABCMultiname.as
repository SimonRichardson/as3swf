package com.codeazur.as3swf.data.abc.bytecode.multiname
{

	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCMultiname extends ABCNamedMultiname {

		public var namespaces:ABCNamespaceSet;

		public function ABCMultiname() {}
		
		public static function create(name:String, namespaces:ABCNamespaceSet, kind:int = -1):ABCMultiname {
			const mname:ABCMultiname = new ABCMultiname();
			mname.label = name;
			mname.namespaces = namespaces;
			mname.kind = kind < 0? ABCMultinameKind.MULTINAME : ABCMultinameKind.getType(kind);
			return mname;
		}
		
		override public function get name() : String { return "ABCMultiname"; }
		
		override public function toQualifiedName():ABCQualifiedName {
			var result:ABCQualifiedName = super.toQualifiedName();
			if(namespaces.namespaces.length == 1) {
				result = ABCQualifiedName.create(name, namespaces.namespaces[0]);
			}
			return result;
		}
		
		override public function toString(indent:uint = 0):String {
			return ABC.toStringCommon(name, indent) + 
				"Label: " + label + ", " +
				"NamespaceSet: " + namespaces + ", " +
				"Kind: " + kind;
		}
	}
}
