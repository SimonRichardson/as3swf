package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespace;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespaceKind;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCQualifiedNameType {
		
		
		public static const APPLY:ABCQualifiedNameType = new ABCQualifiedNameType(ABCQualifiedName.create(APPLY_NAME, ABCNamespace.create(ABCNamespaceKind.NAMESPACE.type, BUILTIN_NAME)));
		public static const TO_STRING:ABCQualifiedNameType = new ABCQualifiedNameType(ABCQualifiedName.create(TO_STRING_NAME, ABCNamespace.create(ABCNamespaceKind.NAMESPACE.type, BUILTIN_NAME)));
		
		public static const INT:ABCQualifiedNameType = new ABCQualifiedNameType(ABCQualifiedName.create(INT_NAME, ABCNamespace.create(ABCNamespaceKind.PACKAGE_NAMESPACE.type, "")));
		public static const STRING:ABCQualifiedNameType = new ABCQualifiedNameType(ABCQualifiedName.create(STRING_NAME, ABCNamespace.create(ABCNamespaceKind.PACKAGE_NAMESPACE.type, "")));
		public static const UINT:ABCQualifiedNameType = new ABCQualifiedNameType(ABCQualifiedName.create(UINT_NAME, ABCNamespace.create(ABCNamespaceKind.PACKAGE_NAMESPACE.type, "")));
		
		public static const BUILTIN_NAME:String = "http://adobe.com/AS3/2006/builtin";
		
		private static const APPLY_NAME:String = "apply";
		private static const TO_STRING_NAME:String = "toString";
		
		private static const INT_NAME:String = "int";
		private static const STRING_NAME:String = "String";
		private static const UINT_NAME:String = "uint";
		
		private var _type:ABCQualifiedName;

		public function ABCQualifiedNameType(type:ABCQualifiedName) {
			_type = type;
		}
		
		public static function isType(name:ABCQualifiedName, type:ABCQualifiedNameType):Boolean {
			return name.fullName == type.type.fullName && name.kind.type == type.type.kind.type;
		}
		
		public function get type():ABCQualifiedName { return _type; }

	}
}
