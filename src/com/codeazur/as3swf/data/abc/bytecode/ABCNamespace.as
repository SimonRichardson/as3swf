package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.utils.StringUtils;
	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCNamespace {

		public var kind : ABCNamespaceKind;
		public var value : String;

		public function ABCNamespace() {
		}
		
		public static function create(type:uint, value:String):ABCNamespace {
			const ns:ABCNamespace = new ABCNamespace();
			ns.kind = ABCNamespaceKind.getType(type);
			ns.value = value;
			return ns;
		}
		
		public function get name():String { return "ABCNamespace"; }
		
		public function toString(indent:uint = 0):String {
			return ABC.toStringCommon(name, indent) +
				"\n" + StringUtils.repeat(indent + 2) + "Type:" +
				"\n" + kind.toString(indent + 4) + "" +
				"\n" + StringUtils.repeat(indent + 2) + "Value: " + 
				" " + value; 
		}
	}
}
