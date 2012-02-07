package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCQualifiedName extends ABCNamedMultiname {
		
		public var ns:ABCNamespace;
		
		public function ABCQualifiedName() {}

		public static function create(name:String, ns:ABCNamespace, kind:uint = NaN):ABCQualifiedName {
			const qname : ABCQualifiedName = new ABCQualifiedName();
			qname.label = name;
			qname.ns = ns;
			qname.kind = isNaN(kind)? ABCMultinameKind.QNAME : ABCMultinameKind.getType(kind);
			return qname;
		}
		
		override public function get name():String { return "ABCQualifiedName"; }
		
		override public function toString(indent:uint = 0) : String {
			return ABC.toStringCommon(name, indent) + 
				"Label: " + label + ", " + 
				"Namespace: " + ns + ", " +
				"Kind: " + kind.toString();
		}
	}
}
