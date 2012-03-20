package com.codeazur.as3swf.data.abc.reflect.traits
{

	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitMethodInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectGetterTrait extends ABCReflectTrait {

		public function ABCReflectGetterTrait(qname : IABCMultiname) {
			super(qname);
		}
		
		public static function create(trait:ABCTraitMethodInfo):ABCReflectGetterTrait {
			const instance:ABCReflectGetterTrait = new ABCReflectGetterTrait(trait.qname);
			return instance;
		}
		
		override public function get name():String { return "ABCReflectGetterTrait"; }
	}
}
