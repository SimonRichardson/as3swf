package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCNamespaceKindFactory {
		
		public static function create(value:String):ABCNamespaceKind {
			var type:uint;
			
			switch(value) {
				case "internal":
					type = ABCNamespaceKind.PACKAGE_INTERNAL_NAMESPACE.type; 
					break;
				case "private":
					type = ABCNamespaceKind.PRIVATE_NAMESPACE.type; 
					break;
				case "protected":
					type = ABCNamespaceKind.PROTECTED_NAMESPACE.type; 
					break;
				case "":
				case "public":
					type = ABCNamespaceKind.PACKAGE_NAMESPACE.type;
					break;
				default:
					type = ABCNamespaceKind.EXPLICIT_NAMESPACE.type; 
					break;
			}
			
			return ABCNamespaceKind.getType(type);
		}
	}
}
