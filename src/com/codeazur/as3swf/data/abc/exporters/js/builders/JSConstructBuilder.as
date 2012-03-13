package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCApplyTypeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCConstructorBuilder;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSConstructBuilder implements IABCConstructorBuilder
	{
		
		private var _constructorMethod:IABCApplyTypeBuilder;
		private var _args:Vector.<IABCWriteable>;
		
		public function JSConstructBuilder() {
		}

		public static function create(constructorMethod:IABCApplyTypeBuilder, args:Vector.<IABCWriteable>):JSConstructBuilder {
			const instance:JSConstructBuilder = new JSConstructBuilder();
			instance.constructorMethod = constructorMethod;
			instance.args = args;
			return instance;
		}

		public function write(data : ByteArray) : void {
			JSReservedKind.NEW.write(data);
			JSTokenKind.SPACE.write(data);
			
			constructorMethod.write(data);
						
			JSTokenKind.LEFT_PARENTHESES.write(data);
			if(null != args) {
				const total:uint = args.length;
				for(var i:uint=0; i<total; i++) {
					const argument:IABCWriteable = args[i];
					argument.write(data);
					
					if(i < total - 1) {
						JSTokenKind.COMMA.write(data);
					}
				}
			}
			
			JSTokenKind.RIGHT_PARENTHESES.write(data);
		}
		
		public function get constructorMethod():IABCApplyTypeBuilder { return _constructorMethod; }
		public function set constructorMethod(value:IABCApplyTypeBuilder) : void { _constructorMethod = value; }
		
		public function get args():Vector.<IABCWriteable> { return _args; }
		public function set args(value:Vector.<IABCWriteable>):void { _args = value; }

		public function get name():String { return "JSConstructBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
