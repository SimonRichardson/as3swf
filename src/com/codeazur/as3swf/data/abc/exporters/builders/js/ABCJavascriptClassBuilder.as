package com.codeazur.as3swf.data.abc.exporters.builders.js
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCClassInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassConstructorBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassPackageNameBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassStaticBuilder;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCJavascriptClassBuilder implements IABCClassBuilder {
		
		private var _qname:ABCQualifiedName;
		private var _classInfo:ABCClassInfo;
		private var _instanceInfo:ABCInstanceInfo;
		
		public function ABCJavascriptClassBuilder() {}
		
		public static function create(qname:ABCQualifiedName):ABCJavascriptClassBuilder {
			const builder:ABCJavascriptClassBuilder = new ABCJavascriptClassBuilder();
			builder.qname = qname;
			return builder; 
		}
		
		public function write(data:ByteArray):void {
			const nameBuilder:IABCClassPackageNameBuilder = ABCJavascriptClassPackageNameBuilder.create(qname);
			nameBuilder.write(data);
			
			const ctorBuilder:IABCClassConstructorBuilder = ABCJavascriptClassConstructorBuilder.create(qname);
			ctorBuilder.instanceInfo = instanceInfo;
			ctorBuilder.write(data);
			
			const staticBuilder:IABCClassStaticBuilder = ABCJavascriptClassStaticBuilder.create(qname);
			staticBuilder.traits = classInfo.traits;
			staticBuilder.write(data);
		}

		public function get qname():ABCQualifiedName { return _qname; }
		public function set qname(value:ABCQualifiedName):void { _qname = value; }

		public function get classInfo():ABCClassInfo { return _classInfo; }
		public function set classInfo(value:ABCClassInfo):void { _classInfo = value; }
		
		public function get instanceInfo():ABCInstanceInfo { return _instanceInfo; }
		public function set instanceInfo(value:ABCInstanceInfo):void { _instanceInfo = value; }
		
		public function get name():String { return "ABCJavascriptClassBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}	
}
