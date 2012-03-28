package com.codeazur.as3swf.data.abc.tools
{
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMetadata;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfo;
	import com.codeazur.as3swf.data.abc.bytecode.traits.ABCTraitInfoFlags;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOptimizeMetadata implements IABCVistor {
		
		private static const GO_TO:String = "__go_to_";
		
		public function ABCOptimizeMetadata() {
		}

		public function visit(value:ABCData):void {
			var index:uint = value.metadataSet.length;
			while(--index > -1) {
				const metadata:ABCMetadata = value.metadataSet.getAt(index);
				if(metadata.label.indexOf(GO_TO) == 0) {
					value.metadataSet.metadatas.splice(index, 1);
				}
			}
			
			// go through all the types and remove any metadata
			index = value.instanceInfoSet.length;
			while(--index > -1) {
				removeTraitMetadata(value.instanceInfoSet.getAt(index).traits);
			}
			index = value.classInfoSet.length;
			while(--index > -1) {
				removeTraitMetadata(value.classInfoSet.getAt(index).traits);
			}
			index = value.scriptInfoSet.length;
			while(--index > -1) {
				removeTraitMetadata(value.scriptInfoSet.getAt(index).traits);
			}
			index = value.methodBodySet.length;
			while(--index > -1) {
				removeTraitMetadata(value.methodBodySet.getAt(index).traits);
			}
		}
		
		private function removeTraitMetadata(traits:Vector.<ABCTraitInfo>):void {
			var index0:uint = traits.length;
			while(--index0 > -1) {
				const info:ABCTraitInfo = traits[index0];
				if(info.hasMetadata) {
					const metadatas:Vector.<ABCMetadata> = info.metadatas;
					var index1:uint = metadatas.length;
					while(--index1 > -1) {
						const metadata:ABCMetadata = metadatas[index1];
						if(metadata.label.indexOf(GO_TO) == 0) {
							metadatas.splice(index1, 1);
						}
					}
					if(metadatas.length == 0) {
						info.kind &= ~(ABCTraitInfoFlags.METADATA.type << 4);
						// Check to make sure we remove the metadata bitwise.
						if(info.hasMetadata) {
							throw new Error("Unknown error");
						}
					}
				}
			}
		}
	}
}
