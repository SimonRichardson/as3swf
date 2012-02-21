package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSReturnVoidBuilder extends JSReturnBuilder
	{

		public function JSReturnVoidBuilder() {
			useSpace = false;
		}
		
		public static function create():JSReturnVoidBuilder {
			return new JSReturnVoidBuilder();
		}

		override public function get name():String { return "JSReturnVoidBuilder"; }
	}
}
