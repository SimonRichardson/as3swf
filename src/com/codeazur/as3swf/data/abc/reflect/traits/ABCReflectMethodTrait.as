package com.codeazur.as3swf.data.abc.reflect.traits
{

	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitMethodInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectMethodTrait extends ABCReflectTrait {

		public function ABCReflectMethodTrait(multiname : IABCMultiname) {
			super(multiname);
		}
		
		public static function create(trait:ABCTraitMethodInfo):ABCReflectMethodTrait {
			const instance:ABCReflectMethodTrait = new ABCReflectMethodTrait(trait.multiname);
			return instance;
		}
		
		override public function get name():String { return "ABCReflectMethodTrait"; }
	}
}
