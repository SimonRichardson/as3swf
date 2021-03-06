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
		
		public var methodInfo:ABCMethodInfo;
		public var methodInfoIndex:int;
		
		public var maxStack:uint;
		public var localCount:uint;
		public var initScopeDepth:uint;
		public var maxScopeDepth:uint;
		
		public var opcodes:ABCOpcodeSet;
		public var exceptionInfo:ABCExceptionInfoSet;
		
		private var _hasAlchemyOpcodes:Boolean; 
		
		public function ABCMethodBody(abcData:ABCData) {
			super(abcData);
			
			_hasAlchemyOpcodes = false;
		}
		
		public static function create(abcData:ABCData):ABCMethodBody {
			return new ABCMethodBody(abcData);
		}
		
		override public function read(data:SWFData, scanner:ABCScanner, traitPositions:Vector.<uint>):void {
			methodInfoIndex = data.readEncodedU30();
			
			methodInfo = getMethodInfoByIndex(methodInfoIndex);
			methodInfo.methodBody = this;
			
			maxStack = data.readEncodedU30();
			localCount = data.readEncodedU30();
			initScopeDepth = data.readEncodedU30();
			maxScopeDepth = data.readEncodedU30();
			
			opcodes = ABCOpcodeSet.create(abcData);
			opcodes.read(data);
			
			_hasAlchemyOpcodes = opcodes.hasAlchemyOpcodes;
			
			exceptionInfo = ABCExceptionInfoSet.create(abcData);
			exceptionInfo.read(data, scanner);
			
			super.read(data, scanner, traitPositions);
		}
		
		override public function write(bytes : SWFData) : void {
			bytes.writeEncodedU32(methodInfoIndex);
			
			bytes.writeEncodedU32(maxStack);
			bytes.writeEncodedU32(localCount);
			bytes.writeEncodedU32(initScopeDepth);
			bytes.writeEncodedU32(maxScopeDepth);
			
			opcodes.write(bytes);
			exceptionInfo.write(bytes);
			
			super.write(bytes);
		}
		
		override public function set abcData(value : ABCData) : void {
			super.abcData = value;
			
			methodInfo.abcData = value;
			opcodes.abcData = value;
			exceptionInfo.abcData = value;
		}
		
		public function get hasAlchemyOpcodes():Boolean { return _hasAlchemyOpcodes; }
		
		override public function get name():String { return "ABCMethodBody"; }
		
		override public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "MaxStack: " + maxStack;
			str += "\n" + StringUtils.repeat(indent + 2) + "LocalCount: " + localCount;
			str += "\n" + StringUtils.repeat(indent + 2) + "InitScopeDepth: " + initScopeDepth;
			str += "\n" + StringUtils.repeat(indent + 2) + "MaxScopeDepth: " + maxScopeDepth;

			str += "\n" + StringUtils.repeat(indent + 2) + "ABCOpcodeSet: ";
			str += "\n" + opcodes.toString(indent + 4);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "ABCExceptionInfoSet: ";
			str += "\n" + exceptionInfo.toString(indent + 4);
												
			return str;
		}

	}
}
