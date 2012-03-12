package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCMultinameBuiltin {
		
		public static const ANY:ABCQualifiedName = ABCQualifiedName.create(ANY_NAME, ABCNamespaceType.ASTERISK.ns);
		public static const BOOLEAN:ABCQualifiedName = ABCQualifiedName.create(BOOLEAN_NAME, ABCNamespaceType.PUBLIC.ns);
		public static const DICTIONARY:ABCQualifiedName = ABCQualifiedName.create(DICTIONARY_NAME, ABCNamespaceType.FLASH_UTILS.ns);
		public static const FUNCTION:ABCQualifiedName = ABCQualifiedName.create(FUNCTION_NAME, ABCNamespaceType.PUBLIC.ns);
		public static const INT:ABCQualifiedName = ABCQualifiedName.create(INT_NAME, ABCNamespaceType.PUBLIC.ns);
		public static const NUMBER:ABCQualifiedName = ABCQualifiedName.create(NUMBER_NAME, ABCNamespaceType.PUBLIC.ns);
		public static const OBJECT:ABCQualifiedName = ABCQualifiedName.create(OBJECT_NAME, ABCNamespaceType.PUBLIC.ns);
		public static const STRING:ABCQualifiedName = ABCQualifiedName.create(STRING_NAME, ABCNamespaceType.PUBLIC.ns);
		public static const UINT:ABCQualifiedName = ABCQualifiedName.create(UINT_NAME, ABCNamespaceType.PUBLIC.ns);
		public static const VOID:ABCQualifiedName = ABCQualifiedName.create(VOID_NAME, ABCNamespaceType.PUBLIC.ns);
		
		private static const ANY_NAME:String = "*";
		private static const BOOLEAN_NAME:String = "Boolean";
		private static const DICTIONARY_NAME:String = "Dictionary";
		private static const NUMBER_NAME:String = "Number";
		private static const FUNCTION_NAME:String = "Function";
		private static const INT_NAME:String = "int";
		private static const OBJECT_NAME:String = "Object";
		private static const STRING_NAME:String = "String";
		private static const UINT_NAME:String = "uint";
		private static const VOID_NAME:String = "void";
		
		public static function isBuiltin(multiname:IABCMultiname):Boolean {
			var result:Boolean = false;
			
			const qname:ABCQualifiedName = (multiname is ABCQualifiedName) ? ABCQualifiedName(multiname) : multiname.toQualifiedName();
			if(ABCNamespaceType.isTypeByNamespace(qname.ns, ABCNamespaceType.BUILTIN)) {
				result = true;
				
			} else {
				switch(qname.fullName)
				{
					case ANY_NAME:
					case BOOLEAN_NAME:
					case DICTIONARY_NAME:
					case NUMBER_NAME:
					case FUNCTION_NAME:
					case INT_NAME:
					case OBJECT_NAME:
					case STRING_NAME:
					case UINT_NAME:
					case VOID_NAME:
						result = true;
						break;
				}
			}
			
			return result;
		}
		
		public static function isNameType(name:String, multiname:IABCMultiname):Boolean {
			const qname:ABCQualifiedName = (multiname is ABCQualifiedName) ? ABCQualifiedName(multiname) : multiname.toQualifiedName();
			return qname.fullName == name;
		}
		
		public static function isType(multiname:IABCMultiname, type:ABCQualifiedName):Boolean {
			const qname:ABCQualifiedName = (multiname is ABCQualifiedName) ? ABCQualifiedName(multiname) : multiname.toQualifiedName();
			return qname.label == type.label && qname.ns.kind == type.ns.kind;
		}
	}
}
