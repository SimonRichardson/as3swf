package com.codeazur.as3swf.data.abc.bytecode.multiname
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespaceType;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCBaseMultiname implements IABCMultiname {
		
		private var _kind:ABCMultinameKind;
		
		public function ABCBaseMultiname() {}

		public static function equals(qname0:IABCMultiname, qname1:IABCMultiname):Boolean {
			return qname0.kind.type == qname1.kind.type && qname0.fullName == qname1.fullName; 
		}

		public function get kind():ABCMultinameKind { return _kind; }
		public function set kind(value:ABCMultinameKind):void { _kind = value; }
		public function get name():String { return "ABCMultiname"; }
		public function get fullName():String {
			return ABCNamespaceType.getType(ABCNamespaceType.ASTERISK).value;
		}
		
		public function toQualifiedName():ABCQualifiedName {
			return null;
		}
		
		public function toString(indent:uint = 0) : String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
