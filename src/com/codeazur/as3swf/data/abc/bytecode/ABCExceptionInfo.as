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
	public class ABCExceptionInfo extends ABCSet {
		
		public var from:uint;
		public var to:uint;
		public var target:uint;
				
		public var exceptionType:IABCMultiname;
		public var variableName:IABCMultiname;

		public function ABCExceptionInfo(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCExceptionInfo {
			return new ABCExceptionInfo(abcData);
		}
		
		public function read(data:SWFData, scanner:ABCScanner):void {
			from = data.readEncodedU30();
			to = data.readEncodedU30();
			target = data.readEncodedU30();
			
			const exceptionTypeIndex:uint = data.readEncodedU30();
			exceptionType = getMultinameByIndex(exceptionTypeIndex);
			
			const variableNameIndex:uint = data.readEncodedU30();
			variableName = getMultinameByIndex(variableNameIndex);
		}
		
		public function write(bytes:SWFData):void {
			bytes.writeEncodedU32(from);
			bytes.writeEncodedU32(to);
			bytes.writeEncodedU32(target);
			
			bytes.writeEncodedU32(getMultinameIndex(exceptionType));
			bytes.writeEncodedU32(getMultinameIndex(variableName));
		}
		
		override public function get name():String { return "ABCExceptionInfo"; }
		
		override public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "From: " + from;
			str += "\n" + StringUtils.repeat(indent + 2) + "To: " + to;
			str += "\n" + StringUtils.repeat(indent + 2) + "Target: " + target;

			str += "\n" + StringUtils.repeat(indent + 2) + "ExceptionType: ";
			str += "\n" + exceptionType.toString(indent + 4);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "VariableName: ";
			str += "\n" + variableName.toString(indent + 4);
									
			return str;
		}

	}
}
