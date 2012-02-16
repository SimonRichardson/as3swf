package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSOperatorKind {
		
		public static const OR:JSOperatorKind = new JSOperatorKind();
				
		public function JSOperatorKind() {}
		
		public function write(data:ByteArray):void {
			switch(this) {
				case OR:
					JSTokenKind.PIPE.write(data);
					JSTokenKind.PIPE.write(data);
					break;
			}
		}
	}
}
