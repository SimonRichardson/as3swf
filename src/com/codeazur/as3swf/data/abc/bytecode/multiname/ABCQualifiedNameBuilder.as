package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCQualifiedNameBuilder {
		
		public static function create(label:String, type:int=-1):ABCQualifiedName {
			const parts:Array = normalise(label).split('.');
			const name:String = parts.pop();
			const nsType:ABCNamespaceKind = type>0 ? ABCNamespaceKind.getType(type) : ABCNamespaceKind.PACKAGE_NAMESPACE;
			const ns:ABCNamespace = ABCNamespace.create(nsType.type, parts.join('.'));
			return ABCQualifiedName.create(name, ns);
		}
		
		private static function normalise(label:String):String {
			label = label.replace(/::/g, ':');
			return label.replace(/:/g, '.');
		}
	}
}
