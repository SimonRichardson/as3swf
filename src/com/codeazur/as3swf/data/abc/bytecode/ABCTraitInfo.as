package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCTraitInfo extends ABCSet {
		
		public var qname:IABCMultiname;
		public var kind:ABCTraitInfoKind;
		
		public var metadatas:Vector.<ABCMetadata>;
		
		public function ABCTraitInfo(abcData:ABCData) {
			super(abcData);
			
			metadatas = new Vector.<ABCMetadata>();	
		}
		
		override public function parse(data : SWFData) : void {
			if(hasMetadata) {
				const total:uint = data.readEncodedU30();
				for(var i:uint = 0; i<total; i++) {
					const index:uint = data.readEncodedU30();
					const metadata:ABCMetadata = getMetadataByIndex(index);
					
					metadatas.push(metadata);
				}
			}
		}

		override public function get name():String { return "ABCTraitInfo"; }
		public function get isFinal():Boolean {
			return ABCTraitInfoFlags.isType(kind.type, ABCTraitInfoFlags.FINAL);
		}
		public function get isOverride():Boolean {
			return ABCTraitInfoFlags.isType(kind.type, ABCTraitInfoFlags.OVERRIDE);
		}
		public function get hasMetadata():Boolean {
			return ABCTraitInfoFlags.isType(kind.type, ABCTraitInfoFlags.METADATA);
		}
		
		override public function toString(indent:uint = 0):String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "QName: ";
			str += "\n" + qname.toString(indent + 4);
			str += "\n" + StringUtils.repeat(indent + 2) + "Kind: ";
			str += "\n" + kind.toString(indent + 4);
			
			if(metadatas.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Metadata: ";
				for(var i:uint = 0; i<metadatas.length; i++) {
					str += "\n" + metadatas[i].toString(indent + 4);
				}
			}
			
			return str;
		}
	}
}
