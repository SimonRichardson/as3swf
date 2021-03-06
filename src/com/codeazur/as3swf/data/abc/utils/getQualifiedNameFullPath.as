package com.codeazur.as3swf.data.abc.utils
{
	import com.codeazur.as3swf.data.abc.abc_namespace;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceType;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespace;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceKind;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getQualifiedNameFullPath(ns : ABCNamespace, name : String) : String {
		use namespace abc_namespace;
		
		var result:String = "";
		if(!StringUtils.isEmpty(ns.value)) {
			result = ns.value.replace(ABCNamespaceType.BUILTIN.ns.value, "");
			if(result.length > 0) {
				result += NAMESPACE_METHOD_SEPARATOR;
			}
		}
				
		var methodNamespace:String = "";
		switch(ns.kind) {
			case ABCNamespaceKind.PACKAGE_NAMESPACE:
				break;
				
			case ABCNamespaceKind.EXPLICIT_NAMESPACE:
				methodNamespace = ABCNamespaceKind.getName(ns.kind) + NAMESPACE_SEPARATOR;
				// Replace the exlicit namespace identifier
				methodNamespace = methodNamespace.replace(EXPLICIT_NAMESPACE_IDENTIFIER, ns.explicit);
				break;
				
			case ABCNamespaceKind.NAMESPACE:
				methodNamespace = ABCNamespaceKind.getName(ns.kind);
				// Replace the namespace identifier
				methodNamespace = methodNamespace.replace(NAMESPACE_IDENTIFIER, ns.explicit);
				methodNamespace = methodNamespace.replace(ABCNamespaceType.BUILTIN.ns.value, "");
				// Add the separator after the fact
				if(!StringUtils.isEmpty(methodNamespace)) {
					methodNamespace += NAMESPACE_SEPARATOR;
				}
				break;
				
			case ABCNamespaceKind.PRIVATE_NAMESPACE:
			case ABCNamespaceKind.PROTECTED_NAMESPACE:
			case ABCNamespaceKind.PACKAGE_INTERNAL_NAMESPACE:
				methodNamespace = ABCNamespaceKind.getName(ns.kind) + NAMESPACE_SEPARATOR;
				break;
			
			default:
				throw new Error("Unknown namespace kind (" + ns.kind + ")");
		}
		
		// Add getters and setters
		const post:String = StringUtils.isNotEmpty(ns.type) ? NAMESPACE_METHOD_SEPARATOR + ns.type : "";
		return result + methodNamespace + name + post;
	}
}
