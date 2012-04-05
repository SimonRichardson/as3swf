package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCNamedMultiname extends ABCBaseMultiname {
		
		private var _label:String;

		public function ABCNamedMultiname() {}
		
		override public function equals(multiname : IABCMultiname) : Boolean {
			if(this == multiname) {
				return true;
			} else if(multiname is ABCNamedMultiname && _label == ABCNamedMultiname(multiname).label) {
				return super.equals(multiname);
			}
			return false;
		}
		
		public function get label():String { return _label; }
		public function set label(value:String):void { _label = value; }
		
		override public function get fullName() : String { return label; }
		override public function get name():String { return "ABCNamedMultiname"; }
				
		override public function toString(indent:uint = 0):String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Label: ";
			str += "\n" + StringUtils.repeat(indent + 4) + label;
			
			return str;
		}
	}
}
