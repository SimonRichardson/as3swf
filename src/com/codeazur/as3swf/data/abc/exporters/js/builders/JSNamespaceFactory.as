package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.exporters.js.ABCJavascriptExporter;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCMultinameBuiltin;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceKind;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCAttributeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSMultinameArgumentBuilder;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSNamespaceFactory
	{
		
		public static function create(qname:ABCQualifiedName):IABCAttributeBuilder {
			var builder:IABCAttributeBuilder = null;
					
			if(ABCNamespaceKind.isType(qname.ns.kind, ABCNamespaceKind.PRIVATE_NAMESPACE) ||
				ABCNamespaceKind.isType(qname.ns.kind, ABCNamespaceKind.PROTECTED_NAMESPACE)) {
				
				qname.ns.value = getNamespaceValue(qname.ns.kind);
				builder = JSMultinameArgumentBuilder.create(qname);
				
			} else if(ABCNamespaceKind.isType(qname.ns.kind, ABCNamespaceKind.NAMESPACE)) {
				
				if(ABCMultinameBuiltin.isBuiltin(qname)) {
					builder = JSMultinameArgumentBuilder.create(qname);
				} else {
					throw new Error(qname);
				}
				
			} else if(ABCNamespaceKind.isType(qname.ns.kind, ABCNamespaceKind.PACKAGE_NAMESPACE)) {
				// Do nothing
			} else {
				throw new Error(qname.ns.kind);
			}
		
			// Return with a valid builder if none found
			if(!builder) {
				builder = JSMultinameArgumentBuilder.create(qname);
			}
			
			return builder;
		}
		
		private static function getNamespaceValue(kind:ABCNamespaceKind):String {
			var result:String;
			if(ABCNamespaceKind.isType(kind, ABCNamespaceKind.PRIVATE_NAMESPACE)) {
				result = ABCJavascriptExporter.NAMESPACE_PRIVATE_PREFIX;
			} else if(ABCNamespaceKind.isType(kind, ABCNamespaceKind.PROTECTED_NAMESPACE)) {
				result = ABCJavascriptExporter.NAMESPACE_PROTECTED_PREFIX;
			} else {
				throw new Error('Missing implementation');
			}
			
			return result;
		}
	}
}
