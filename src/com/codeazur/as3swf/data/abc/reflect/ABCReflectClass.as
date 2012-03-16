package com.codeazur.as3swf.data.abc.reflect
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectClass {
		
		public var qname:IABCMultiname;
		
		public function ABCReflectClass(){
		}
		
		public static function create(qname:IABCMultiname):ABCReflectClass{
			const instance:ABCReflectClass = new ABCReflectClass();
			instance.qname = qname;
			return instance;
		}
		
		public function get name():String { return "ABCReflectClass"; }
		
		public function toString(indent:uint = 0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "QName:";
			str += "\n" + qname.toString(indent + 4);
			
			return str;
		}
	}
}
