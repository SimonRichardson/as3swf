package com.codeazur.as3swf.data.abc.utils
{
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceType;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceKind;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getMethodNamespaceKind(value:String):ABCNamespaceKind {
		var result:ABCNamespaceKind;
		
		switch(value) {
			case "private":
				result = ABCNamespaceKind.PRIVATE_NAMESPACE;
				break;
			case "protected":
				result = ABCNamespaceKind.PROTECTED_NAMESPACE;
				break;
			case "internal":
				result = ABCNamespaceKind.PACKAGE_INTERNAL_NAMESPACE;
				break;
			case "public":
			case "":
				result = ABCNamespaceKind.PACKAGE_NAMESPACE;
				break;
			case ABCNamespaceType.BUILTIN.ns.value:
				result = ABCNamespaceKind.NAMESPACE;
				break;
			default:
				result = ABCNamespaceKind.EXPLICIT_NAMESPACE;
				break;
		}
		
		return result;								
	}
}
