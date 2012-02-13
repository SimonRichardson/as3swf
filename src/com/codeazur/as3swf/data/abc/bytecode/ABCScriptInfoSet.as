package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
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
		
		override public function parse(data:SWFData, scanner:ABCScanner):void {
			const total:uint = data.readEncodedU30();
			for(var i:uint=0; i<total; i++){
				const scriptIndex:uint = data.readEncodedU30();
				const scriptInitialiser:ABCMethodInfo = getMethodInfoByIndex(scriptIndex);
				
				const scriptInfo:ABCScriptInfo = ABCScriptInfo.create(abcData, scriptInitialiser);
				scriptInfo.parse(data, scanner);
				
				scriptInfos.push(scriptInfo);
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
