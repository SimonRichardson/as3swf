package com.codeazur.as3swf.data.abc.reflect
{

	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectInterface extends ABCReflectInstance {
		
		public function ABCReflectInterface(multiname:IABCMultiname){
			super(multiname);
		}
		
		public static function create(multiname:IABCMultiname):ABCReflectInterface{
			return new ABCReflectInterface(multiname);
		}
		
		override public function get name():String { return "ABCReflectInterface"; }
		override public function get kind():ABCReflectKind { return ABCReflectKind.INTERFACE; }
	}
}
