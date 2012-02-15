package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedNameType;
	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitSlotInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitInfoKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCTraitInfo;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassStaticBuilder;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCJavascriptClassStaticBuilder implements IABCClassStaticBuilder {
		
		private var _qname:ABCQualifiedName;
		private var _traits:Vector.<ABCTraitInfo>;
		
		public function ABCJavascriptClassStaticBuilder() {}
		
		public static function create(qname:ABCQualifiedName):ABCJavascriptClassStaticBuilder {
			const builder:ABCJavascriptClassStaticBuilder = new ABCJavascriptClassStaticBuilder();
			builder.qname = qname;
			return builder; 
		}
		
		public function write(data:ByteArray):void {
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
								
								data.writeUTF(qname.fullName);
								
								ABCJavascriptTokenKind.DOT.write(data);
								
								data.writeUTF(traitQName.label);
								
								if(slotTrait.hasDefaultValue) {
									const valueQName:ABCQualifiedName = slotTrait.typeMultiname.toQualifiedName();
									if(null != valueQName) {
										ABCJavascriptTokenKind.EQUALS.write(data);
										
										if(ABCQualifiedNameType.isType(valueQName, ABCQualifiedNameType.STRING)) {
											
											ABCJavascriptTokenKind.DOUBLE_QUOTE.write(data);
											data.writeUTF(slotTrait.defaultValue);
											ABCJavascriptTokenKind.DOUBLE_QUOTE.write(data);
											
										} else {
											data.writeUTF(slotTrait.defaultValue);
										}
										
									}
								}
								
								ABCJavascriptTokenKind.SEMI_COLON.write(data);
							}
						}
					}
				}
			}
		}

		public function get qname():ABCQualifiedName { return _qname; }
		public function set qname(value:ABCQualifiedName) : void { _qname = value; }
		
		public function get traits() : Vector.<ABCTraitInfo> { return _traits; }
		public function set traits(value : Vector.<ABCTraitInfo>) : void { _traits = value; }
		
		public function get name():String { return "ABCJavascriptClassStaticBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
