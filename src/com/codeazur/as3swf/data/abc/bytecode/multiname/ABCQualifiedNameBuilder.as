package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	import com.codeazur.as3swf.data.abc.utils.NAMESPACE_SEPARATOR;
	import com.codeazur.as3swf.data.abc.utils.normaliseInstanceName;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCQualifiedNameBuilder {
		
		public static function create(label:String, type:int=-1):ABCQualifiedName {
			const parts:Array = normaliseInstanceName(label).split(NAMESPACE_SEPARATOR);
			const name:String = parts.pop();
			const nsType:ABCNamespaceKind = type>0 ? ABCNamespaceKind.getType(type) : ABCNamespaceKind.PACKAGE_NAMESPACE;
			const ns:ABCNamespace = ABCNamespace.create(nsType.type, parts.join(NAMESPACE_SEPARATOR));
			const qname:ABCQualifiedName = ABCQualifiedName.create(name, ns);
			qname.byte = ABCMultinameKind.QNAME.type;
			qname.ns.byte = nsType.type;
			return qname;
		}
	}
}
