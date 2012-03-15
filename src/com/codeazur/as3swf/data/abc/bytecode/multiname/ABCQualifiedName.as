package com.codeazur.as3swf.data.abc.bytecode.multiname
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCQualifiedName extends ABCNamedMultiname {
		
		public var ns:ABCNamespace;
		
		public function ABCQualifiedName() {}

		public static function create(label:String, ns:ABCNamespace, kind:int = -1):ABCQualifiedName {
			const qname : ABCQualifiedName = new ABCQualifiedName();
			qname.label = label;
			qname.ns = ns;
			qname.kind = kind < 0 ? ABCMultinameKind.QNAME : ABCMultinameKind.getType(kind);
			return qname;
		}
		
		public function get hasValidNamespace():Boolean {
			return 	(ns == null) || 
					(ns != null && ns.value == ABCNamespaceType.getType(ABCNamespaceType.ASTERISK).value) ||
					(ns != null && ns.value != null && ns.value.length < 1);
		}
		
		override public function get name():String { return "ABCQualifiedName"; }
		override public function get fullName():String {
			var result:String;
			if(label != ABCNamespaceType.getType(ABCNamespaceType.ASTERISK).value) {
				if(hasValidNamespace) {
					result = label;
				} else {
					result = ns.value + "." + label;
				}
			} else {
				result = super.fullName;
			}
			
			return result;
		}
		
		override public function toQualifiedName():ABCQualifiedName { 
			const qname:ABCQualifiedName = new ABCQualifiedName();
			qname.label = label;
			qname.kind = kind;
			qname.ns = ns.clone();
			qname.byte = byte;
			return qname; 
		}
		
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
