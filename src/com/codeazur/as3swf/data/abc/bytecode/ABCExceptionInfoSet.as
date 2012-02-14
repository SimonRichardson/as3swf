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
		
		public function parse(data:SWFData, scanner:ABCScanner):void {
			const total:uint = data.readEncodedU30();
			for(var i:uint=0; i<total; i++){
				const exception:ABCExceptionInfo = new ABCExceptionInfo.create(abcData);
				exception.parse(data, scanner);
				
				exceptions.push(exception);
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
