package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCNamespaceSet {
		
		public var namespaces : Vector.<ABCNamespace>;

		public function ABCNamespaceSet() {
		}
		
		public static function create(namespaces:Vector.<ABCNamespace> = null):ABCNamespaceSet {
			const nsSet:ABCNamespaceSet = new ABCNamespaceSet();
			nsSet.namespaces = namespaces || new Vector.<ABCNamespace>();
			return nsSet; 
		}
		
		public function get name():String { return "ABCNamespaceSet"; }
		
		public function toString(indent:uint = 0) : String {
			var str:String = ABC.toStringCommon(name, indent);
			if(namespaces.length > 0) { 
				str += "\n" + StringUtils.repeat(indent + 2) + "NamespacePool:";
				for(var i:uint = 0; i < namespaces.length; i++) {
					str += "\n" + namespaces[i].toString(indent + 4);
				}
			}
			return str;
		}
	}
}
