package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.utils.DictionaryUtils;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	import com.codeazur.as3swf.data.abc.io.ABCScanner;
	import com.codeazur.utils.StringUtils;
	import flash.utils.Dictionary;


	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCMetadataSet extends ABCSet {
		
		public var metadatas:Vector.<ABCMetadata>;
		
		private var _keys:Vector.<Vector.<ABCMetadataKey>>;
		
		public function ABCMetadataSet(abcData : ABCData) {
			super(abcData);
			
			metadatas = new Vector.<ABCMetadata>();
			
			_keys = new Vector.<Vector.<ABCMetadataKey>>();
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
				
				const metadataKeys:Vector.<ABCMetadataKey> = new Vector.<ABCMetadataKey>();
				
				for(var j:uint=0; j<keysTotal; j++) {
					const keyIndex:uint = data.readEncodedU30();
					const keyName:String = getStringByIndex(keyIndex);
					
					metadataKeys.push(ABCMetadataKey.create(keyIndex));
					
					keys.push(keyName);
				}
				
				const properties:Dictionary = new Dictionary();
				for(var k:uint=0; k<keysTotal; k++) {
					const key:String = keys[k];
					
					const valueIndex:uint = data.readEncodedU30();
					const value:String = getStringByIndex(valueIndex);
					
					const metadataKeyValue:ABCMetadataKey = metadataKeys[k];
					metadataKeyValue.value = valueIndex;
					
					properties[key] = value;
				}
				
				_keys.push(metadataKeys);
				metadatas.push(ABCMetadata.create(metadataName, properties));
			}
		}
		
		public function write(bytes:SWFData):void {
			const total:uint = metadatas.length;
			bytes.writeEncodedU32(total);
			
			for(var i:uint=0; i<total; i++) {
				const metadata:ABCMetadata = metadatas[i];
				
				bytes.writeEncodedU32(getStringIndex(metadata.label));
				
				const keys:Vector.<ABCMetadataKey> = _keys[i];
				const keysTotal:uint = keys.length;
				bytes.writeEncodedU32(keysTotal);
				
				for(var j:uint=0; j<keysTotal; j++) {
					bytes.writeEncodedU32(keys[j].key);
				}
				
				for(var k:uint=0; k<keysTotal; k++) {
					bytes.writeEncodedU32(keys[k].value);
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
