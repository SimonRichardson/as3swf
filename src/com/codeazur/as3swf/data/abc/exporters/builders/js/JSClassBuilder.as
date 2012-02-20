package com.codeazur.as3swf.data.abc.exporters.builders.js
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCClassInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassConstructorBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassPackageNameBuilder;

	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSClassBuilder implements IABCClassBuilder {
		
		private var _qname:ABCQualifiedName;
		private var _classInfo:ABCClassInfo;
		private var _instanceInfo:ABCInstanceInfo;
		
		public function JSClassBuilder() {}
		
		public static function create(qname:ABCQualifiedName):JSClassBuilder {
			const builder:JSClassBuilder = new JSClassBuilder();
			builder.qname = qname;
			return builder; 
		}
		
		public function write(data:ByteArray):void {
			const nameBuilder:IABCClassPackageNameBuilder = JSClassPackageNameBuilder.create(qname);
			nameBuilder.write(data);
			
			const ctorBuilder:IABCClassConstructorBuilder = JSClassConstructorBuilder.create(qname);
			ctorBuilder.instanceInfo = instanceInfo;
			ctorBuilder.write(data);
		}

		public function get qname():ABCQualifiedName { return _qname; }
		public function set qname(value:ABCQualifiedName):void { _qname = value; }

		public function get classInfo():ABCClassInfo { return _classInfo; }
		public function set classInfo(value:ABCClassInfo):void { _classInfo = value; }
		
		public function get instanceInfo():ABCInstanceInfo { return _instanceInfo; }
		public function set instanceInfo(value:ABCInstanceInfo):void { _instanceInfo = value; }
		
		public function get name():String { return "JSClassBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}	
}
