package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	import com.codeazur.as3swf.data.abc.io.ABCScanner;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCScriptInfoSet extends ABCSet {
		
		public var scriptInfos:Vector.<ABCScriptInfo>;
		
		public function ABCScriptInfoSet(abcData:ABCData) {
			super(abcData);
			
			scriptInfos = new Vector.<ABCScriptInfo>();
		}
		
		public function read(data:SWFData, scanner:ABCScanner):void {
			const position:uint = scanner.getScriptInfo();
			if(data.position != position) {
				throw new Error('Invalid position (Expected: ' + data.position + ', Recieved: ' + position + ')');
			}
			
			data.position = position;
			
			const total:uint = data.readEncodedU30();
			for(var i:uint=0; i<total; i++){
				data.position = scanner.getScriptInfoAtIndex(i);
				
				const scriptIndex:uint = data.readEncodedU30();
				const scriptInitialiser:ABCMethodInfo = getMethodInfoByIndex(scriptIndex);
				const scriptInfo:ABCScriptInfo = ABCScriptInfo.create(abcData, scriptInitialiser);
				const scriptTraitPositions:Vector.<uint> = scanner.getScriptTraitInfoAtIndex(i);
				scriptInfo.read(data, scanner, scriptTraitPositions);
				
				scriptInfos.push(scriptInfo);
			}
		}
		
		public function write(bytes:SWFData):void {
			const total:uint = scriptInfos.length;
			bytes.writeEncodedU32(total);
			
			for(var i:uint=0; i<total; i++){
				const scriptInfo:ABCScriptInfo = scriptInfos[i];
				bytes.writeEncodedU32(getMethodInfoIndex(scriptInfo.scriptInitialiser));
				scriptInfo.write(bytes);
			}
		}
		
		override public function get name():String { return "ABCScriptInfoSet"; }
		
		override public function toString(indent:uint=0):String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Number ScriptInfo: ";
			str += scriptInfos.length;
			
			if(scriptInfos.length > 0) {
				for(var i:uint=0; i<scriptInfos.length; i++) {
					str += "\n" + scriptInfos[i].toString(indent + 4);
				}
			}
			
			return str;
		}

	}
}
