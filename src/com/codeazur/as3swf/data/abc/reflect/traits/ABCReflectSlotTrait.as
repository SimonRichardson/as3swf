package com.codeazur.as3swf.data.abc.reflect.traits
{

	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitSlotInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectSlotTrait extends ABCReflectTrait {

		public function ABCReflectSlotTrait(multiname : IABCMultiname) {
			super(multiname);
		}
		
		public static function create(trait:ABCTraitSlotInfo):ABCReflectSlotTrait {
			const instance:ABCReflectSlotTrait = new ABCReflectSlotTrait(trait.multiname);
			return instance;
		}
		
		override public function get name():String { return "ABCReflectSlotTrait"; }
	}
}
