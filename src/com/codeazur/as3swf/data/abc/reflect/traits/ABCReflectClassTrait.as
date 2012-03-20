package com.codeazur.as3swf.data.abc.reflect.traits
{

	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitClassInfo;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectClassTrait extends ABCReflectTrait {

		public function ABCReflectClassTrait(qname : IABCMultiname) {
			super(qname);
		}
		
		public static function create(trait:ABCTraitClassInfo):ABCReflectClassTrait {
			const instance:ABCReflectClassTrait = new ABCReflectClassTrait(trait.qname);
			return instance;
		}
		
		override public function get name():String { return "ABCReflectClassTrait"; }
	}
}
