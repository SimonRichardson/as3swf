package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCBaseMultiname implements IABCMultiname {
		
		private var _byte:int;
		private var _kind:ABCMultinameKind;
		
		private var _fullName:String;
		
		public function ABCBaseMultiname() {
			_byte = 0;
			_fullName = ABCNamespaceType.getType(ABCNamespaceType.ASTERISK).value;
		}

		public function equals(multiname:IABCMultiname):Boolean {
			return kind.equals(multiname.kind); 
		}

		public function get kind():ABCMultinameKind { return _kind; }
		public function set kind(value:ABCMultinameKind):void { _kind = value; }
		
		public function get byte() : int { return _byte; }
		public function set byte(value : int) : void { _byte = value; }
		
		public function get name():String { return "ABCMultiname"; }
		
		public function get fullName():String { return _fullName; }
		public function get fullPath():String { return _fullName; }
		
		public function toQualifiedName():ABCQualifiedName {
			return null;
		}
		
		public function toString(indent:uint = 0) : String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Kind: ";
			str += "\n" + kind.toString(indent + 4);
			
			return str;
		}
	}
}
