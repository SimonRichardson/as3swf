package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	import com.codeazur.utils.StringUtils;
	import com.codeazur.as3swf.data.abc.utils.getMethodName;
	import com.codeazur.as3swf.data.abc.utils.getMethodNamespace;
	import com.codeazur.as3swf.data.abc.utils.getScopeName;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCQualifiedNameBuilder {
		
		public static function create(label:String, type:int=-1):ABCQualifiedName {
			const scopeName:String = getScopeName(label);
			const methodName:String = getMethodName(label);
			const methodNamespace:String = getMethodNamespace(label);
			
			const defaultNs:ABCNamespaceKind = StringUtils.isEmpty(methodNamespace) ? 
												ABCNamespaceKind.PACKAGE_NAMESPACE : 
												ABCNamespaceKind.EXPLICIT_NAMESPACE;
			
			const nsType:ABCNamespaceKind = type>0 ? ABCNamespaceKind.getType(type) : defaultNs;
			const ns:ABCNamespace = ABCNamespace.create(nsType.type, scopeName);
			
			if(nsType == ABCNamespaceKind.EXPLICIT_NAMESPACE) {
				ns.explicit = methodNamespace;
			}
			
			const qname:ABCQualifiedName = ABCQualifiedName.create(methodName, ns);
			qname.byte = ABCMultinameKind.QNAME.type;
			qname.ns.byte = nsType.type;
			return qname;
		}
	}
}
