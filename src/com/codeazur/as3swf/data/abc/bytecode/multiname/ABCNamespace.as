package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	import com.codeazur.utils.StringUtils;
	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCNamespace {

		public var kind:ABCNamespaceKind;
		public var value:String;
		public var byte:int;
		
		public var explicit:String;

		public function ABCNamespace(initKind:ABCNamespaceKind = null, initValue:String = "") {
			kind = initKind;
			value = initValue;
			byte = -1;
		}
		
		public static function create(type:uint, value:String = ""):ABCNamespace {
			const ns:ABCNamespace = new ABCNamespace();
			ns.kind = ABCNamespaceKind.getType(type);
			ns.value = value;
			return ns;
		}
		
		public static function isType(type:ABCNamespace, ns:ABCNamespace):Boolean {
			return type.equals(ns);
		}
		
		public static function getType(type:ABCNamespaceType):ABCNamespace {
			return ABCNamespaceType.getType(type);
		}
		
		public function equals(ns:ABCNamespace):Boolean {
			if(this == ns) {
				return true;
			} else if(byte == ns.byte && value == ns.value && kind.equals(ns.kind)) {
				return true;
			}
			return false;
		}
		
		public function clone():ABCNamespace {
			const ns:ABCNamespace = new ABCNamespace(kind, value);
			ns.byte = byte;
			return ns;
		}
		
		public function get name():String { return "ABCNamespace"; }
		
		public function toString(indent:uint = 0):String {
			return ABC.toStringCommon(name, indent) +
				"\n" + StringUtils.repeat(indent + 2) + "Type:" +
				"\n" + kind.toString(indent + 4) + "" +
				"\n" + StringUtils.repeat(indent + 2) + "Value:" + 
				" " + value; 
		}
	}
}
