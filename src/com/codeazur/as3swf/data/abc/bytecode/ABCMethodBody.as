package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCTraitSet;
	import com.codeazur.as3swf.data.abc.io.ABCScanner;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCMethodBody extends ABCTraitSet {
		
		public var maxStack:uint;
		public var localCount:uint;
		public var initScopeDepth:uint;
		public var maxScopeDepth:uint;
		
		public var opcode:ABCOpcodeSet;
		public var exceptionInfo:ABCExceptionInfoSet;
		
		public function ABCMethodBody(abcData:ABCData) {
			super(abcData);
		}
		
		public static function create(abcData:ABCData):ABCMethodBody {
			return new ABCMethodBody(abcData);
		}
		
		override public function parse(data:SWFData, scanner:ABCScanner, traitPositions:Vector.<uint>):void {
			const methodIndex:uint = data.readEncodedU30();
			const method:ABCMethodInfo = getMethodInfoByIndex(methodIndex);
			method.methodBody = this;
			
			maxStack = data.readEncodedU30();
			localCount = data.readEncodedU30();
			initScopeDepth = data.readEncodedU30();
			maxScopeDepth = data.readEncodedU30();
			
			opcode = ABCOpcodeSet.create(abcData);
			opcode.parse(data);
			
			exceptionInfo = ABCExceptionInfoSet.create(abcData);
			exceptionInfo.parse(data, scanner);
			
			super.parse(data, scanner, traitPositions);
		}
		
		override public function get name():String { return "ABCMethodBody"; }
		
		override public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "MaxStack: " + maxStack;
			str += "\n" + StringUtils.repeat(indent + 2) + "LocalCount: " + localCount;
			str += "\n" + StringUtils.repeat(indent + 2) + "InitScopeDepth: " + initScopeDepth;
			str += "\n" + StringUtils.repeat(indent + 2) + "MaxScopeDepth: " + maxScopeDepth;

			str += "\n" + StringUtils.repeat(indent + 2) + "ABCOpcodeSet: ";
			str += "\n" + opcode.toString(indent + 4);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "ABCExceptionInfoSet: ";
			str += "\n" + exceptionInfo.toString(indent + 4);
												
			return str;
		}

	}
}
