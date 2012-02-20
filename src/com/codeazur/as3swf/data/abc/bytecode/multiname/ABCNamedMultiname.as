package com.codeazur.as3swf.data.abc.bytecode.multiname
{

	import com.codeazur.utils.StringUtils;
	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCNamedMultiname extends ABCBaseMultiname {
		
		private var _label:String;

		public function ABCNamedMultiname() {}
		
		override public function get name():String { return "ABCNamedMultiname"; }
		public function get label():String { return _label; }
		public function set label(value:String):void { _label = StringUtils.clean(value); }
				
		override public function toString(indent:uint = 0):String {
			return ABC.toStringCommon(name, indent);
		}

	}
}
