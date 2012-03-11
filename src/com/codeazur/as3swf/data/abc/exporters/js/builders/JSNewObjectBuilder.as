package com.codeazur.as3swf.data.abc.exporters.js.builders
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCNewObjectBuilder;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSNewObjectBuilder implements IABCNewObjectBuilder {
		
		private var _args:Vector.<IABCWriteable>;
		
		public function JSNewObjectBuilder() {
		}

		public static function create(args:Vector.<IABCWriteable>):JSNewObjectBuilder {
			const instance:JSNewObjectBuilder = new JSNewObjectBuilder();
			instance.args = args;
			return instance;
		}

		public function write(data : ByteArray) : void {
			if(args.length == 0) {
				JSLiteralKind.OBJECT.write(data);
			} else {
				JSTokenKind.LEFT_CURLY_BRACKET.write(data);
				
				const total:int = args.length / 2;
				for(var i:int=0; i<total; i++) {
					args[i].write(data);
					
					JSTokenKind.COLON.write(data);
					
					i++;
					args[i].write(data);
					
					if(i < total - 1) {
						JSTokenKind.COMMA.write(data);
					}
				}
 				
				JSTokenKind.RIGHT_CURLY_BRACKET.write(data);
			}
		}
		
		public function get args():Vector.<IABCWriteable> { return _args; }
		public function set args(value:Vector.<IABCWriteable>):void { _args = value; }

		public function get name():String { return "JSClassBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
