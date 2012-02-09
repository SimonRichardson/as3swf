package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.ABCData;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCTraitInfoFactory {
		
		public static function create(abcData:ABCData, traitKind:uint, traitQName:IABCMultiname, isStatic:Boolean = false):ABCTraitInfo {
			var traitInfo:ABCTraitInfo;
			
			const kind:ABCTraitInfoKind = ABCTraitInfoKind.getType(traitKind);
			switch(kind) {
				case ABCTraitInfoKind.SLOT:
					traitInfo = ABCTraitSlotInfo.create(abcData, traitQName, kind, isStatic);
					break;
					
				case ABCTraitInfoKind.CONST:
					traitInfo = ABCTraitConstInfo.create(abcData, traitQName, kind, isStatic);
					break;
				
				case ABCTraitInfoKind.METHOD:
				case ABCTraitInfoKind.GETTER:
				case ABCTraitInfoKind.SETTER:
					traitInfo = ABCTraitMethodInfo.create(abcData, traitQName, kind, isStatic);
					break;
				
				case ABCTraitInfoKind.CLASS:
					traitInfo = ABCTraitClassInfo.create(abcData, traitQName, kind);
					break;
				
				case ABCTraitInfoKind.FUNCTION:
					traitInfo = ABCTraitFunctionInfo.create(abcData, traitQName, kind, isStatic);
					break;
			}
			
			return traitInfo;
		}
	}
}
