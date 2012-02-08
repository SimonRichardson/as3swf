package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCQualifiedName extends ABCNamedMultiname {
		
		public var ns:ABCNamespace;
		
		public function ABCQualifiedName() {}

		public static function create(name:String, ns:ABCNamespace, kind:int = -1):ABCQualifiedName {
			const qname : ABCQualifiedName = new ABCQualifiedName();
			qname.label = name;
			qname.ns = ns;
			qname.kind = kind < 0 ? ABCMultinameKind.QNAME : ABCMultinameKind.getType(kind);
			return qname;
		}
		
		override public function get name():String { return "ABCQualifiedName"; }
		
		override public function toQualifiedName():ABCQualifiedName { return this; }
		
		override public function toString(indent:uint = 0) : String {
			return ABC.toStringCommon(name, indent) + 
				"Label: " + label + ", " +
				"\n" + StringUtils.repeat(indent + 2) + 
				"Kind: \n" + kind.toString(indent + 4) + ", " +
				"\n" + StringUtils.repeat(indent + 2) + 
				"Namespace: " +
				"\n" + ns.toString(indent + 4);
		}
	}
}
