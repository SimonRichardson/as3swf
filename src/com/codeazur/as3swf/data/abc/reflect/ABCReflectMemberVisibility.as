package com.codeazur.as3swf.data.abc.reflect
{

	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceKind;
	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectMemberVisibility {
		
		public static const ALL:ABCReflectMemberVisibility = new ABCReflectMemberVisibility(0x00);
		public static const EXPLICIT:ABCReflectMemberVisibility = new ABCReflectMemberVisibility(0x01);
		public static const INTERNAL:ABCReflectMemberVisibility = new ABCReflectMemberVisibility(0x02);
		public static const NAMESPACE:ABCReflectMemberVisibility = new ABCReflectMemberVisibility(0x03);
		public static const PUBLIC:ABCReflectMemberVisibility = new ABCReflectMemberVisibility(0x04);
		public static const PRIVATE:ABCReflectMemberVisibility = new ABCReflectMemberVisibility(0x05);
		public static const PROTECTED:ABCReflectMemberVisibility = new ABCReflectMemberVisibility(0x06);
		
		private var _type:int;

		public function ABCReflectMemberVisibility(type:int){
			_type = type;
		}
		
		public static function getType(type:ABCNamespaceKind):ABCReflectMemberVisibility {
			var result:ABCReflectMemberVisibility;
			
			switch(type) {
				case ABCNamespaceKind.EXPLICIT_NAMESPACE:
					result = EXPLICIT;
					break;
				case ABCNamespaceKind.NAMESPACE:
					result = NAMESPACE;
					break;
				case ABCNamespaceKind.PACKAGE_NAMESPACE:
					result = PUBLIC;
					break;
				case ABCNamespaceKind.PROTECTED_NAMESPACE:
					result = PROTECTED;
					break;
				case ABCNamespaceKind.PRIVATE_NAMESPACE:
					result = PRIVATE;
					break;
				case ABCNamespaceKind.PACKAGE_INTERNAL_NAMESPACE:
					result = INTERNAL;
					break;
				default:
					throw new Error('Unkown type (type:' + type + ')');
			}
			
			return result;
		}
		
		public static function isType(type:ABCReflectMemberVisibility, kind:ABCReflectMemberVisibility):Boolean {
			if(type == ALL || kind == ALL) {
				return true;
			}
			return type.type == kind.type;
		}
		
		public function get type():uint { return _type; }
		public function get name():String { return "ABCReflectMemberVisibility"; }
		
		public function toString(indent:uint = 0):String {
			return ABC.toStringCommon(name, indent) + 
				"Type: " + type; 
		}
	}
}
