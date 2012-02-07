package com.codeazur.as3swf.data.abc
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCConstantsPool;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfoSet;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCData {
		
		public var minorVersion:uint;
		public var majorVersion:uint;
		
		public var constantPool:ABCConstantsPool;
		
		public var methodInfoSet:ABCMethodInfoSet;

		public function ABCData() {
			constantPool = new ABCConstantsPool();
			methodInfoSet = new ABCMethodInfoSet(this);
		}
		
		public function get name():String { return 'ABCData'; }
		
		public function toString(indent:uint = 0):String {
			 return ABC.toStringCommon(name, indent) + 
			 	"Minor Version: " + minorVersion + ", " +
				"Major Version: " + majorVersion + "" +
				"\n" + StringUtils.repeat(indent + 2) + "ConstantPool:" +
				"\n" + constantPool.toString(indent + 4);
		}
	}
}
