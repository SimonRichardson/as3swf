package com.codeazur.as3swf.data.abc.reflect
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectInstance implements IABCReflectInstance {

		private var _multiname:IABCMultiname;

		public function ABCReflectInstance(multiname:IABCMultiname) {
			_multiname = multiname;
		}
		
		public function get kind():ABCReflectKind { return null; }
		public function get multiname():IABCMultiname { return _multiname; }
		public function get name():String { return "ABCReflectInstance"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Multiname:";
			str += "\n" + multiname.toString(indent + 4);
			
			return str;
		}
	}
}
