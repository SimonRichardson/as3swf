package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	import com.codeazur.as3swf.data.abc.io.ABCScanner;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCMethodBody extends ABCSet {
		
		public var maxStack:uint;
		public var localCount:uint;
		public var initScopeDepth:uint;
		public var maxScopeDepth:uint;
		
		public var opcode:ABCMethodBodyOpcode;
		
		public function ABCMethodBody(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCMethodBody {
			const methodBody:ABCMethodBody = new ABCMethodBody(abcData);
			
			return methodBody;
		}
		
		public function parse(data:SWFData, scanner:ABCScanner):void {
			const methodIndex:uint = data.readEncodedU30();
			const method:ABCMethodInfo = getMethodInfoByIndex(methodIndex);
			method.methodBody = this;
			
			maxStack = data.readEncodedU30();
			localCount = data.readEncodedU30();
			initScopeDepth = data.readEncodedU30();
			maxScopeDepth = data.readEncodedU30();
			
			opcode = ABCMethodBodyOpcode.create(abcData);
			opcode.parse(data);
		}
		
		override public function get name():String { return "ABCMethodBody"; }
		
		override public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
						
			return str;
		}

	}
}
