package com.codeazur.as3swf.data.abc.reflect.traits
{

	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitClassInfo;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitConstInfo;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitFunctionInfo;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfo;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfoKind;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitSlotInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectTraitFactory {
		
		public static function create(trait:ABCTraitInfo):IABCReflectTrait {
			var instance:IABCReflectTrait;
			switch(trait.kindType) {
				case ABCTraitInfoKind.CLASS:
					instance = ABCReflectClassTrait.create(ABCTraitClassInfo(trait));
					break;
					
				case ABCTraitInfoKind.CONST:
					instance = ABCReflectConstTrait.create(ABCTraitConstInfo(trait));
					break;
					
				case ABCTraitInfoKind.FUNCTION:
					instance = ABCReflectFunctionTrait.create(ABCTraitFunctionInfo(trait));
					break;
					
				case ABCTraitInfoKind.GETTER:
					instance = ABCReflectGetterTrait.create(ABCTraitMethodInfo(trait));
					break;
					
				case ABCTraitInfoKind.METHOD:
					instance = ABCReflectMethodTrait.create(ABCTraitMethodInfo(trait));
					break;
					
				case ABCTraitInfoKind.SETTER:
					instance = ABCReflectSetterTrait.create(ABCTraitMethodInfo(trait));
					break;
					
				case ABCTraitInfoKind.SLOT:
					instance = ABCReflectSlotTrait.create(ABCTraitSlotInfo(trait));
					break;
					
				default:
					throw new Error();
			}
			return instance;
		}
	}
}
