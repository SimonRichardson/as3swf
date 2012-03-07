package com.codeazur.as3swf.data.abc.exporters.translator
{
	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeTranslatorOptimizer {

		public function ABCOpcodeTranslatorOptimizer() {
		}
		
		public static function create():ABCOpcodeTranslatorOptimizer {
			return new ABCOpcodeTranslatorOptimizer();
		}
		
		public function optimize(data:ABCOpcodeTranslateData):void {
			
		}
		
		public function get name():String { return "ABCOpcodeTranslatorOptimizer"; }
		
		public function toString(indent:uint=0) : String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
