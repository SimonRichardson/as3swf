package com.codeazur.as3swf.data.abc.bytecode.attributes
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCExceptionInfo;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeExceptionInfoAttribute extends ABCOpcodeAttribute {
		
		private var _integer:int;
		private var _exceptionInfo:ABCExceptionInfo;
		
		public function ABCOpcodeExceptionInfoAttribute(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCOpcodeExceptionInfoAttribute {
			return new ABCOpcodeExceptionInfoAttribute(abcData);
		}
		
		override public function read(data:SWFData):void {
			_integer = data.readEncodedU30();
		}
		
		override public function write(bytes : SWFData) : void {
			bytes.writeEncodedU32(_integer);
		}
		
		public function get exceptionInfo():ABCExceptionInfo { return _exceptionInfo; }
		
		override public function get value():* { return _exceptionInfo; }
		override public function get name():String { return "ABCOpcodeExceptionInfoAttribute"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "ExceptionInfo: ";
			str += "\n" + StringUtils.repeat(indent + 4) + exceptionInfo;
			
			return str;
		}
	}
}
