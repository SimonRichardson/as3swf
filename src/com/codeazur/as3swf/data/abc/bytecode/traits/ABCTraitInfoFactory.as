package com.codeazur.as3swf.data.abc.bytecode.traits
{
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCTraitInfoFactory {
		
		public static function create(abcData:ABCData, kind:uint, traitQName:IABCMultiname, isStatic:Boolean = false):ABCTraitInfo {
			var traitInfo:ABCTraitInfo;
			
			const kindType:ABCTraitInfoKind = ABCTraitInfoKind.getType(kind);
			switch(kindType) {
				case ABCTraitInfoKind.SLOT:
					traitInfo = ABCTraitSlotInfo.create(abcData, traitQName, kind, kindType, isStatic);
					break;
					
				case ABCTraitInfoKind.CONST:
					traitInfo = ABCTraitConstInfo.create(abcData, traitQName, kind, kindType, isStatic);
					break;
				
				case ABCTraitInfoKind.METHOD:
				case ABCTraitInfoKind.GETTER:
				case ABCTraitInfoKind.SETTER:
					traitInfo = ABCTraitMethodInfo.create(abcData, traitQName, kind, kindType, isStatic);
					break;
				
				case ABCTraitInfoKind.CLASS:
					traitInfo = ABCTraitClassInfo.create(abcData, traitQName, kind, kindType);
					break;
				
				case ABCTraitInfoKind.FUNCTION:
					traitInfo = ABCTraitFunctionInfo.create(abcData, traitQName, kind, kindType, isStatic);
					break;
			}
			
			return traitInfo;
		}
	}
}
