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
	public class ABCExceptionInfoSet extends ABCSet {
		
		public var exceptions:Vector.<ABCExceptionInfo>;
		
		public function ABCExceptionInfoSet(abcData:ABCData) {
			super(abcData);
			
			exceptions = new Vector.<ABCExceptionInfo>();
		}
		
		public static function create(abcData:ABCData):ABCExceptionInfoSet {
			return new ABCExceptionInfoSet(abcData);
		}
		
		public function read(data:SWFData, scanner:ABCScanner):void {
			const total:uint = data.readEncodedU30();
			for(var i:uint=0; i<total; i++){
				const exception:ABCExceptionInfo = ABCExceptionInfo.create(abcData);
				exception.read(data, scanner);
				
				exceptions.push(exception);
			}
		}
		
		public function write(bytes:SWFData):void {
			const total:uint = exceptions.length;
			bytes.writeEncodedU32(total);
			
			for(var i:uint=0; i<total; i++){
				const exception:ABCExceptionInfo = exceptions[i];
				exception.write(bytes);
			}
		}
		
		override public function set abcData(value : ABCData) : void {
			super.abcData = value;
			
			const total:uint = exceptions.length;
			
			for(var i:uint=0; i<total; i++){
				const exception:ABCExceptionInfo = exceptions[i];
				exception.abcData = value;
			}
		}
		
		override public function get name():String { return "ABCExceptionInfoSet"; }
		
		override public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Number ExceptionInfo: ";
			str += exceptions.length;
			
			if(exceptions.length > 0) {
				for(var i:uint=0; i<exceptions.length; i++) {
					str += "\n" + exceptions[i].toString(indent + 4);
				}
			}
				
			return str;
		}
	}
}
