package com.codeazur.as3swf.data.abc.bytecode
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCQualifiedNameType {
		
		public static const APPLY:ABCQualifiedNameType = new ABCQualifiedNameType(ABCQualifiedName.create(APPLY_NAME, ABCNamespace.create(ABCNamespaceKind.NAMESPACE.type, "http://adobe.com/AS3/2006/builtin")));
		public static const STRING:ABCQualifiedNameType = new ABCQualifiedNameType(ABCQualifiedName.create(STRING_NAME, ABCNamespace.create(ABCNamespaceKind.PACKAGE_NAMESPACE.type, "")));
		
		private static const APPLY_NAME:String = "apply";
		private static const STRING_NAME:String = "String";
		
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
