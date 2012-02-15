package com.codeazur.as3swf.data.abc
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitInfoFactory;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
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

		public function read(data : SWFData, scanner:ABCScanner, traitPositions:Vector.<uint>) : void {
			const total:uint = data.readEncodedU30();
			for(var i:uint=0; i<total; i++) {
				data.position = traitPositions[i];
				
				const index:uint = data.readEncodedU30();

				const traitMName:IABCMultiname = getMultinameByIndex(index);
				const traitQName:IABCMultiname = traitMName.toQualifiedName();
				
				const traitKind:uint = data.readUI8();
				const trait:ABCTraitInfo = ABCTraitInfoFactory.create(abcData, traitKind, traitQName, isStatic);
				trait.read(data, scanner);
				
				traits.push(trait); 
			}
		}
		
		override public function get name() : String { return "ABCTraitSet"; }

		override public function toString(indent : uint = 0) : String {
			return super.toString(indent);
		}
		
	}
}
