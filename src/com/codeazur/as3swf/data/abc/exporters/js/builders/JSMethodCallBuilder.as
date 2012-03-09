package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodCallBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMultinameAttributeBuilder;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	import com.codeazur.utils.StringUtils;

	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMethodCallBuilder implements IABCMethodCallBuilder {
		
		private var _method:IABCMultinameAttributeBuilder;
		private var _args:Vector.<IABCWriteable>;
		
		public function JSMethodCallBuilder() {
		}
		
		public static function create(method:IABCMultinameAttributeBuilder, args:Vector.<IABCWriteable> = null):JSMethodCallBuilder {
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
					const argument:IABCWriteable = args[i];
					argument.write(data);
					
					if(i < total - 1) {
						JSTokenKind.COMMA.write(data);
					}
				}
			}
			
			JSTokenKind.RIGHT_PARENTHESES.write(data);
		}
		
		public function get method():IABCMultinameAttributeBuilder { return _method; }
		public function set method(value:IABCMultinameAttributeBuilder):void { _method = value; }
		
		public function get args():Vector.<IABCWriteable> { return _args; }
		public function set args(value:Vector.<IABCWriteable>):void { _args = value; }
		
		public function get name():String { return "JSMethodCallBuilder"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Method:";
			str += "\n" + method.toString(indent + 4);
			
			if(args && args.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Arguments:";
				for(var i:uint=0; i<args.length; i++) {
					str += "\n" + args[i].toString(indent + 4);
				}
			}
			
			return str;
		}
	}
}
