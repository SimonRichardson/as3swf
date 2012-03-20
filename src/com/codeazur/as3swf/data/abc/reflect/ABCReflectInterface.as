package com.codeazur.as3swf.data.abc.reflect
{

	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectInterface extends ABCReflectInstance {
		
		public function ABCReflectInterface(qname:IABCMultiname){
			super(qname);
		}
		
		public static function create(qname:IABCMultiname):ABCReflectInterface{
			return new ABCReflectInterface(qname);
		}
		
		override public function get name():String { return "ABCReflectInterface"; }
		override public function get kind():ABCReflectKind { return ABCReflectKind.INTERFACE; }
	}
}
