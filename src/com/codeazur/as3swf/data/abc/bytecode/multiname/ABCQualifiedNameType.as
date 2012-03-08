package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespace;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespaceKind;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCQualifiedNameType {
		
		public static const FLOAT:ABCQualifiedNameType = new ABCQualifiedNameType(ABCQualifiedName.create(FLOAT_NAME, ABCNamespace.create(ABCNamespaceKind.PACKAGE_NAMESPACE.type, "")));
		public static const INT:ABCQualifiedNameType = new ABCQualifiedNameType(ABCQualifiedName.create(INT_NAME, ABCNamespace.create(ABCNamespaceKind.PACKAGE_NAMESPACE.type, "")));
		public static const OBJECT:ABCQualifiedNameType = new ABCQualifiedNameType(ABCQualifiedName.create(OBJECT_NAME, ABCNamespace.create(ABCNamespaceKind.PACKAGE_NAMESPACE.type, "")));
		public static const STRING:ABCQualifiedNameType = new ABCQualifiedNameType(ABCQualifiedName.create(STRING_NAME, ABCNamespace.create(ABCNamespaceKind.PACKAGE_NAMESPACE.type, "")));
		public static const UINT:ABCQualifiedNameType = new ABCQualifiedNameType(ABCQualifiedName.create(UINT_NAME, ABCNamespace.create(ABCNamespaceKind.PACKAGE_NAMESPACE.type, "")));
		
		public static const BUILTIN_NAME:String = "http://adobe.com/AS3/2006/builtin";
		
		private static const FLOAT_NAME:String = "Number";
		private static const INT_NAME:String = "int";
		private static const OBJECT_NAME:String = "Object";
		private static const STRING_NAME:String = "String";
		private static const UINT_NAME:String = "uint";
		
		private var _type:ABCQualifiedName;

		public function ABCQualifiedNameType(type:ABCQualifiedName) {
			_type = type;
		}
		
		public static function isType(name:IABCMultiname, type:ABCQualifiedNameType):Boolean {
			return name.fullName == type.type.fullName && name.kind.type == type.type.kind.type;
		}
		
		public static function isBuiltin(name:ABCQualifiedName):Boolean {
			return name.ns.value == BUILTIN_NAME;
		}
		
		public function get type():ABCQualifiedName { return _type; }

	}
}
