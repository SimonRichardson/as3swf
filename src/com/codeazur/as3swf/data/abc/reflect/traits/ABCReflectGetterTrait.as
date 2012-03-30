package com.codeazur.as3swf.data.abc.reflect.traits
{

	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitMethodInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectGetterTrait extends ABCReflectTrait {

		public function ABCReflectGetterTrait(multiname : IABCMultiname) {
			super(multiname);
		}
		
		public static function create(trait:ABCTraitMethodInfo):ABCReflectGetterTrait {
			const instance:ABCReflectGetterTrait = new ABCReflectGetterTrait(trait.multiname);
			return instance;
		}
		
		override public function get name():String { return "ABCReflectGetterTrait"; }
	}
}
