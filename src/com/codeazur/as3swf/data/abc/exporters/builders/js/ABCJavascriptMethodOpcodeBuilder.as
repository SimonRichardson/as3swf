package com.codeazur.as3swf.data.abc.exporters.builders.js
{

	import flash.utils.ByteArray;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOpcodeBuilder;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCJavascriptMethodOpcodeBuilder implements IABCMethodOpcodeBuilder {

		public function ABCJavascriptMethodOpcodeBuilder() {
		}
		
		public static function create():ABCJavascriptMethodOpcodeBuilder {
			return new ABCJavascriptMethodOpcodeBuilder();
		}

		public function write(data : ByteArray) : void {
			
		}
		
		

	}
}
