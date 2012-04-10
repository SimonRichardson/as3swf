package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	import com.codeazur.as3swf.data.abc.abc_namespace;
	import com.codeazur.as3swf.data.abc.utils.getMethodName;
	import com.codeazur.as3swf.data.abc.utils.getMethodNamespace;
	import com.codeazur.as3swf.data.abc.utils.getMethodNamespaceKind;
	import com.codeazur.as3swf.data.abc.utils.getMethodType;
	import com.codeazur.as3swf.data.abc.utils.getScopeName;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCQualifiedNameBuilder {
		
		public static function create(label : String, type : int = -1):ABCQualifiedName {
			use namespace abc_namespace;
			
			const scopeName:String = getScopeName(label);
			const methodName:String = getMethodName(label);
			const methodNamespace:String = getMethodNamespace(label);
			const methodType:String = getMethodType(label);
			
			const defaultNs:ABCNamespaceKind = getMethodNamespaceKind(methodNamespace);
			
			const nsType:ABCNamespaceKind = type>0 ? ABCNamespaceKind.getType(type) : defaultNs;
			const ns:ABCNamespace = ABCNamespace.create(nsType.type, scopeName);
			ns.explicit = methodNamespace;
			ns.type = methodType;
			
			const qname:ABCQualifiedName = ABCQualifiedName.create(methodName, ns);
			qname.byte = ABCMultinameKind.QNAME.type;
			qname.ns.byte = nsType.type;
			return qname;
		}
	}
}
