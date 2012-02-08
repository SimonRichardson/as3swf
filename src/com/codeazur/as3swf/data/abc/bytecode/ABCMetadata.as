package com.codeazur.as3swf.data.abc.bytecode
{
	import flash.utils.Dictionary;
	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCMetadata {

		public var label:String;
		public var properties:Dictionary;
		
		public function ABCMetadata() {}
		
		public static function create(label:String, properties:Dictionary):ABCMetadata {
			const metadata:ABCMetadata = new ABCMetadata();
			metadata.label = label;
			metadata.properties = properties;
			return metadata;
		}
		
		public function get name():String { return "ABCMetadata"; }
		
		public function toString(indent:uint = 0) : String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
