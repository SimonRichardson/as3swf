package com.codeazur.as3swf.data.abc.utils
{
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespace;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceKind;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getQualifiedNameFullPath(ns:ABCNamespace, methodName:String):String {
		var result:String = ns.value + NAMESPACE_METHOD_SEPARATOR;
		
		var methodNamespace:String = "";
		switch(ns.kind) {
			case ABCNamespaceKind.PACKAGE_NAMESPACE:
				break;
				
			case ABCNamespaceKind.EXPLICIT_NAMESPACE:
				methodNamespace = ABCNamespaceKind.getName(ns.kind) + NAMESPACE_SEPARATOR;
				// Replace the exlicit namespace identifier
				const replace:String = StringUtils.isEmpty(ns.explicit) ? "" : ns.explicit;
				methodNamespace = methodNamespace.replace(EXPLICIT_NAMESPACE_IDENTIFIER, replace);
				break;
				
			case ABCNamespaceKind.PRIVATE_NAMESPACE:
			case ABCNamespaceKind.PROTECTED_NAMESPACE:
				methodNamespace = ABCNamespaceKind.getName(ns.kind) + NAMESPACE_SEPARATOR;
				break;
			
			default:
				throw new Error("Unknown namespace kind (" + ns.kind + ")");
		}
		
		return result + methodNamespace + methodName;
	}
}
