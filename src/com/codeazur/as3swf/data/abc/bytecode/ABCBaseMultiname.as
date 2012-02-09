package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCBaseMultiname implements IABCMultiname {
		
		private var _kind:ABCMultinameKind;
		
		public function ABCBaseMultiname() {}

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
