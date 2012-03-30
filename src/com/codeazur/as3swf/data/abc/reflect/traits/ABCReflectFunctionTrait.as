package com.codeazur.as3swf.data.abc.reflect.traits
{

	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitFunctionInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectFunctionTrait extends ABCReflectTrait {

		public function ABCReflectFunctionTrait(multiname : IABCMultiname) {
			super(multiname);
		}
		
		public static function create(trait:ABCTraitFunctionInfo):ABCReflectFunctionTrait {
			const instance:ABCReflectFunctionTrait = new ABCReflectFunctionTrait(trait.multiname);
			return instance;
		}
		
		override public function get name():String { return "ABCReflectFunctionTrait"; }
	}
}
