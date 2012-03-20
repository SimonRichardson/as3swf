package com.codeazur.as3swf.data.abc.reflect
{

	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectClass extends ABCReflectInstance {
		
		public function ABCReflectClass(qname:IABCMultiname){
			super(qname);
		}
		
		public static function create(qname:IABCMultiname):ABCReflectClass{
			return new ABCReflectClass(qname);
		}
		
		override public function get name():String { return "ABCReflectClass"; }
		override public function get kind():ABCReflectKind { return ABCReflectKind.CLASS; }
	}
}
