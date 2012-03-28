package com.codeazur.as3swf.data.abc
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfo;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfoFactory;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfoKind;
	import com.codeazur.as3swf.data.abc.io.ABCScanner;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCTraitSet extends ABCSet {
		
		public var traits:Vector.<ABCTraitInfo>;
		public var isStatic:Boolean;

		public function ABCTraitSet(abcData:ABCData) {
			super(abcData);
			
			isStatic = false;
			traits = new Vector.<ABCTraitInfo>();
		}
		
		public function addTrait(trait:ABCTraitInfo):void{
			addTraitAt(trait, traits.length);
		}
		
		public function addTraitAt(trait:ABCTraitInfo, index:uint):void{
			const traitIndex:int = traits.indexOf(trait);
			if(traitIndex >= 0) {
				throw new Error('Trait already exists');
			}
			
			if(index == 0) {
				traits.unshift(trait);
			} else if(index == traits.length) {
				traits.push(trait);
			} else if(index > 0 && index < traits.length) {
				traits.splice(index, 0, trait);
			} else {
				throw new RangeError("Invalid index");
			}
		}

		public function read(data:SWFData, scanner:ABCScanner, traitPositions:Vector.<uint>) : void {
			const total:uint = data.readEncodedU30();
			
			for(var i:uint=0; i<total; i++) {
				data.position = traitPositions[i];
				
				const index:uint = data.readEncodedU30();

				const traitMName:IABCMultiname = getMultinameByIndex(index);
				
				const traitKind:uint = data.readUI8();
				const trait:ABCTraitInfo = ABCTraitInfoFactory.create(abcData, traitKind, traitMName, isStatic);
				trait.read(data, scanner);
				
				traits.push(trait); 
			}
		}
		
		public function write(bytes:SWFData) : void {
			const total:uint = traits.length;
			bytes.writeEncodedU32(total);
			
			for(var i:uint=0; i<total; i++) {
				const trait:ABCTraitInfo = traits[i];
				
				bytes.writeEncodedU32(getMultinameIndex(trait.multiname));
				bytes.writeUI8(trait.kind);
				
				trait.write(bytes);
			}
		}
		
		public function get numMethodTraits():uint {
			var result:uint = 0;
			var index:int = traits.length;
			while(--index > -1) {
				const trait:ABCTraitInfo = traits[index];
				if(ABCTraitInfoKind.isType(trait.kind, ABCTraitInfoKind.METHOD) || 
					ABCTraitInfoKind.isType(trait.kind, ABCTraitInfoKind.GETTER) || 
					ABCTraitInfoKind.isType(trait.kind, ABCTraitInfoKind.SETTER)) {
					result++;	
				}
			}
			return result;
		}
		
		override public function set abcData(value : ABCData) : void {
			super.abcData = value;
			
			const total:uint = traits.length;
			for(var i:uint=0; i<total; i++) {
				const trait:ABCTraitInfo = traits[i];
				trait.abcData = value;
			}
		}
		
		override public function get name() : String { return "ABCTraitSet"; }

		override public function toString(indent : uint = 0) : String {
			return super.toString(indent);
		}
		
	}
}
