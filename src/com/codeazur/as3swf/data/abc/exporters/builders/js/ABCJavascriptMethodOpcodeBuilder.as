package com.codeazur.as3swf.data.abc.exporters.builders.js
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBody;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOpcodeBuilder;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCJavascriptMethodOpcodeBuilder implements IABCMethodOpcodeBuilder {
		
		private var _methodBody:ABCMethodBody;
		private var _returnType:IABCMultiname;
		
		public function ABCJavascriptMethodOpcodeBuilder() {
		}
		
		public static function create():ABCJavascriptMethodOpcodeBuilder {
			return new ABCJavascriptMethodOpcodeBuilder();
		}

		public function write(data : ByteArray) : void {
			trace(methodBody.opcode);
		}
		
		public function get methodBody():ABCMethodBody { return _methodBody; }
		public function set methodBody(value:ABCMethodBody):void { _methodBody = value; }
		
		public function get returnType():IABCMultiname { return _returnType; }
		public function set returnType(value:IABCMultiname):void { _returnType = value; }
		
		public function get name():String { return "ABCJavascriptMethodOpcodeBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
