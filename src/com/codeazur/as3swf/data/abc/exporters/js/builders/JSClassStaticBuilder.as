package com.codeazur.as3swf.data.abc.exporters.js.builders
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitInfoKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitSlotInfo;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassStaticBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;

	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSClassStaticBuilder implements IABCClassStaticBuilder {
		
		private var _traits:Vector.<ABCTraitInfo>;
		
		public function JSClassStaticBuilder() {}
		
		public static function create():JSClassStaticBuilder {
			return new JSClassStaticBuilder();
		}
		
		public function write(data:ByteArray):void {
			// Remove the last comma and then tidy
			data.length -= 3;
			
			JSTokenKind.RIGHT_CURLY_BRACKET.write(data);
			JSTokenKind.COMMA.write(data);
			
			JSTokenKind.LEFT_CURLY_BRACKET.write(data);
			
			if(null != traits && traits.length > 0) {
				const total:uint = traits.length;
				for(var i:uint=0; i<total; i++) {
					const trait:ABCTraitInfo = traits[i];
					const kind:ABCTraitInfoKind = trait.kindType;
					
					if(	ABCTraitInfoKind.isType(kind.type, ABCTraitInfoKind.CONST) || 
						ABCTraitInfoKind.isType(kind.type, ABCTraitInfoKind.SLOT)) {
						
						const slotTrait:ABCTraitSlotInfo = ABCTraitSlotInfo(trait);
						if(slotTrait.isStatic) {
							
							const traitQName:ABCQualifiedName = slotTrait.qname.toQualifiedName();
							if(null != traitQName) {
								
								data.writeUTF(traitQName.label);
								
								if(slotTrait.hasDefaultValue) {
									const valueQName:ABCQualifiedName = slotTrait.typeMultiname.toQualifiedName();
									if(null != valueQName) {
										JSTokenKind.COLON.write(data);
										
										const value:* = slotTrait.defaultValue;
										const valueBuilder:IABCValueBuilder = JSValueBuilder.create(value, valueQName);
										valueBuilder.write(data);
									}
								}
								
								if(i < total - 1) {
									JSTokenKind.COMMA.write(data);
								}
							}
						}
					}
				}
			}
			
			JSTokenKind.RIGHT_CURLY_BRACKET.write(data);
			JSTokenKind.RIGHT_PARENTHESES.write(data);
			JSTokenKind.SEMI_COLON.write(data);
		}

		public function get traits() : Vector.<ABCTraitInfo> { return _traits; }
		public function set traits(value : Vector.<ABCTraitInfo>) : void { _traits = value; }
		
		public function get name():String { return "JSClassStaticBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
