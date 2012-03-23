package com.codeazur.as3swf.data.abc.reflect.traits
{

	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitConstInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectConstTrait extends ABCReflectTrait {

		public function ABCReflectConstTrait(qname : IABCMultiname) {
			super(qname);
		}
		
		public static function create(trait:ABCTraitConstInfo):ABCReflectConstTrait {
			const instance:ABCReflectConstTrait = new ABCReflectConstTrait(trait.multiname);
			return instance;
		}
		
		override public function get name():String { return "ABCReflectConstTrait"; }
	}
}
