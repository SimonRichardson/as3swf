package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCJavascriptOperatorKind {
		
		public static const OR:ABCJavascriptOperatorKind = new ABCJavascriptOperatorKind();
				
		public function ABCJavascriptOperatorKind() {}
		
		public function write(data:ByteArray):void {
			switch(this) {
				case OR:
					ABCJavascriptTokenKind.PIPE.write(data);
					ABCJavascriptTokenKind.PIPE.write(data);
					break;
			}
		}
	}
}
