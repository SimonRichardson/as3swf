package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCMultiname extends ABCNamedMultiname {

		public var namespaces:ABCNamespaceSet;

		public function ABCMultiname() {}
		
		public static function create(name:String, namespaces:ABCNamespaceSet, kind:int = -1):ABCMultiname {
			const mname:ABCMultiname = new ABCMultiname();
			mname.label = name;
			mname.namespaces = namespaces;
			mname.kind = kind < 0? ABCMultinameKind.MULTINAME : ABCMultinameKind.getType(kind);
			return mname;
		}
		
		override public function get name() : String { return "ABCMultiname"; }
		
		override public function toQualifiedName():ABCQualifiedName {
			var result:ABCQualifiedName;
			
			// Walk the namespaces to see if we're a built-in
			const total:uint = namespaces.length;
			for(var i:int=0; i<total; i++) {
				const ns:ABCNamespace = namespaces.getAt(i);
				if(ABCNamespaceType.isTypeByNamespace(ns, ABCNamespaceType.BUILTIN)) {
					result = ABCQualifiedName.create(label, ns);
					break;
				}
			}
			
			if(null == ns) {
				if(total > 0) {
					result = ABCQualifiedName.create(label, ns);
				} else {
					result = super.toQualifiedName();
				}
			}
			
			return result;
		}
		
		override public function toString(indent:uint = 0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Label: ";
			str += "\n" + StringUtils.repeat(indent + 4) + label;
			
			str += "\n" + StringUtils.repeat(indent + 2) + "NamespaceSet: ";
			str += "\n" + namespaces.toString(indent + 4);  
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Kind: ";
			str += "\n" + kind.toString(indent + 4);  
			
			return str;
		}
	}
}
