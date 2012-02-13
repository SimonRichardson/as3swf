package com.codeazur.as3swf.data.abc
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBodySet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCClassInfoSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCConstantsPool;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfoSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMetadataSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfoSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCScriptInfoSet;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCData {
		
		public var minorVersion:uint;
		public var majorVersion:uint;
		
		public var constantPool:ABCConstantsPool;
		
		public var methodInfoSet:ABCMethodInfoSet;
		public var metadataSet:ABCMetadataSet;
		public var instanceInfoSet:ABCInstanceInfoSet;
		public var classInfoSet:ABCClassInfoSet;
		public var scriptInfoSet:ABCScriptInfoSet;
		public var methodBodySet:ABCMethodBodySet;

		public function ABCData() {
			constantPool = new ABCConstantsPool();
			
			methodInfoSet = new ABCMethodInfoSet(this);
			metadataSet = new ABCMetadataSet(this);
			instanceInfoSet = new ABCInstanceInfoSet(this);
			classInfoSet = new ABCClassInfoSet(this);
			scriptInfoSet = new ABCScriptInfoSet(this);
			methodBodySet = new ABCMethodBodySet(this);
		}
		
		public function get name():String { return 'ABCData'; }
		
		public function toString(indent:uint = 0):String {
			var str:String = ABC.toStringCommon(name, indent); 
			 
			str += "Minor Version: " + minorVersion + ", ";
			str += "Major Version: " + majorVersion + "";
			
			str += "\n" + StringUtils.repeat(indent + 2) + "ConstantPool:";
			str += "\n" + constantPool.toString(indent + 4);
			str += "\n" + StringUtils.repeat(indent + 2) + "MethodInfoSet:";
			str += "\n" + methodInfoSet.toString(indent + 4);
			str += "\n" + StringUtils.repeat(indent + 2) + "MetadataSet:";
			str += "\n" + metadataSet.toString(indent + 4);
			str += "\n" + StringUtils.repeat(indent + 2) + "InstanceInfoSet:";
			str += "\n" + instanceInfoSet.toString(indent + 4);
			str += "\n" + StringUtils.repeat(indent + 2) + "ClassInfoSet:";
			str += "\n" + classInfoSet.toString(indent + 4);
			str += "\n" + StringUtils.repeat(indent + 2) + "ScriptInfoSet:";
			str += "\n" + scriptInfoSet.toString(indent + 4);
			
			return str;
		}
	}
}
