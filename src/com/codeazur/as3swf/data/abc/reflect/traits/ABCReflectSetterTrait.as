package com.codeazur.as3swf.data.abc.reflect.traits
{

	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitMethodInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectSetterTrait extends ABCReflectTrait {

		public function ABCReflectSetterTrait(multiname : IABCMultiname) {
			super(multiname);
		}
		
		public static function create(trait:ABCTraitMethodInfo):ABCReflectSetterTrait {
			const instance:ABCReflectSetterTrait = new ABCReflectSetterTrait(trait.multiname);
			return instance;
		}
		
		override public function get name():String { return "ABCReflectSetterTrait"; }
	}
}
