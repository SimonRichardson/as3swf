package com.codeazur.as3swf.data.abc.exporters.js.builders
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodNameBuilder;
	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMethodNameBuilder implements IABCMethodNameBuilder {

		private var _qname:ABCQualifiedName;

		public function JSMethodNameBuilder() {
		}
		
		public static function create(qname:ABCQualifiedName):JSMethodNameBuilder {
			const builder:JSMethodNameBuilder = new JSMethodNameBuilder();
			builder.qname = qname;
			return builder; 
		}

		public function write(data : ByteArray) : void {
			const fullName:String = qname.fullName.replace(/:/, '.');
			const index:uint = fullName.lastIndexOf('/');
			data.writeUTF(fullName.substr(index + 1));
		}
		
		public function get qname():ABCQualifiedName { return _qname; }
		public function set qname(value:ABCQualifiedName):void { _qname = value; }
		
		public function get name():String { return "JSMethodNameBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
