package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	import com.codeazur.as3swf.data.abc.io.ABCScanner;
	import com.codeazur.utils.DictionaryUtils;
	import com.codeazur.utils.StringUtils;

	import flash.utils.Dictionary;


	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCMetadataSet extends ABCSet {
		
		public var metadatas:Vector.<ABCMetadata>;
		
		public function ABCMetadataSet(abcData : ABCData) {
			super(abcData);
			
			metadatas = new Vector.<ABCMetadata>();
		}
		
		public function merge(metadataSet:ABCMetadataSet):void {
			metadataSet.abcData = abcData;
			
			const total:uint = metadataSet.metadatas.length;
			for(var i:uint=0; i<total; i++) {
				const info:ABCMetadata = metadataSet.metadatas[i];
				metadatas.push(info);
			}
		}
		
		public function read(data:SWFData, scanner:ABCScanner):void {
			const position:uint = scanner.getMetadataInfo();
			if(data.position != position) {
				throw new Error('Invalid position (Expected: ' + data.position + ', Recieved: ' + position + ')');
			}
			
			data.position = position;
			
			const total:uint = data.readEncodedU30();
			for(var i:uint=0; i<total; i++) {
				data.position = scanner.getMetadataInfoAtIndex(i);
				
				const nameIndex:uint = data.readEncodedU30();
				const metadataName:String = getStringByIndex(nameIndex);
				
				const keysTotal:int = data.readEncodedU30();
				
				const keys:Vector.<String> = new Vector.<String>();
				
				for(var j:uint=0; j<keysTotal; j++) {
					const keyIndex:uint = data.readEncodedU30();
					const keyName:String = getStringByIndex(keyIndex);
					
					keys.push(keyName);
				}
				
				const properties:Dictionary = new Dictionary();
				for(var k:uint=0; k<keysTotal; k++) {
					const key:String = keys[k];
					
					const valueIndex:uint = data.readEncodedU30();
					const value:String = getStringByIndex(valueIndex);
					
					properties[key] = value;
				}
				metadatas.push(ABCMetadata.create(metadataName, properties));
			}
		}
		
		public function write(bytes:SWFData):void {
			const total:uint = metadatas.length;
			bytes.writeEncodedU32(total);
			
			for(var i:uint=0; i<total; i++) {
				const metadata:ABCMetadata = metadatas[i];
				
				bytes.writeEncodedU32(getStringIndex(metadata.label));
				
				var key:String;
				var propertyTotal:uint = 0;
				for(key in metadata.properties) {
					propertyTotal++;
				}
				bytes.writeEncodedU32(propertyTotal);
				
				const keys:Vector.<String> = new Vector.<String>();
				for(key in metadata.properties) {
					bytes.writeEncodedU32(getStringIndex(key));
					keys.push(key);
				}
				
				const keysTotal:uint = keys.length;
				for(var j:uint=0; j<keysTotal; j++) {
					const propertyValue:String = metadata.properties[keys[j]];
					bytes.writeEncodedU32(getStringIndex(propertyValue));
				}
			}
		}
		
		public function getAt(index:uint):ABCMetadata {
			return metadatas[index];
		}
		
		public function indexOf(value:ABCMetadata):int {
			var index:int = -1;
			
			const total:uint = metadatas.length;
			for(var i:uint=0; i<total; i++) {
				const metadata:ABCMetadata = metadatas[i];
				if(metadata.label == value.label) {
					const d0:Dictionary = metadata.properties;
					const d1:Dictionary = value.properties;
					
					if(DictionaryUtils.compare(d0, d1)) {
						index = i;
					}
				}
			}
			
			return index;
		}
		
		override public function get length():uint { return metadatas.length; }
		override public function get name():String { return "ABCMetadataSet"; }
		
		override public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Number Metadata: ";
			str += metadatas.length;
			
			if(metadatas.length > 0) {
				for(var i:uint=0; i<metadatas.length; i++) {
					str += "\n" + metadatas[i].toString(indent + 4);
				}
			}
			
			return str;
		}
	}
}
