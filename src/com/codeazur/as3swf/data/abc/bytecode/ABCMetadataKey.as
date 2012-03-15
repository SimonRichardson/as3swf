package com.codeazur.as3swf.data.abc.bytecode
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCMetadataKey {
		
		public var key:int;
		public var value : int;

		public function ABCMetadataKey() {
		}
		
		public static function create(key:int):ABCMetadataKey {
			const instance:ABCMetadataKey = new ABCMetadataKey();
			instance.key = key;
			return instance;
		}
	}
}
