package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodCallBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCArgumentBuilder;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMethodCallBuilder implements IABCMethodCallBuilder {
		
		public var method:IABCWriteable;
		public var args:Vector.<IABCArgumentBuilder>;
		
		public function JSMethodCallBuilder() {
		}
		
		public static function create(method:IABCWriteable, args:Vector.<IABCArgumentBuilder> = null):JSMethodCallBuilder {
			const builder:JSMethodCallBuilder = new JSMethodCallBuilder();
			builder.method = method;
			builder.args = args;
			return builder;
		}

		public function write(data : ByteArray) : void {
			method.write(data);
						
			JSTokenKind.LEFT_PARENTHESES.write(data);
			if(null != args) {
				const total:uint = args.length;
				for(var i:uint=0; i<total; i++) {
					const argument:IABCArgumentBuilder = args[i];
					argument.write(data);
					
					if(i < total - 1) {
						JSTokenKind.COMMA.write(data);
					}
				}
			}
			
			JSTokenKind.RIGHT_PARENTHESES.write(data);
		}
		
		public function get name():String { return "JSMethodCallBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
