package com.codeazur.as3swf.data.abc.exporters.builders.js.parameters
{
	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSTokenKind;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespace;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespaceKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCParameterBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.JSReservedKind;

	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSRestParameterBuilder implements IABCParameterBuilder {
		
		
		private static const ARRAY_PROTOTYPE_CALL:IABCMultiname = ABCQualifiedName.create("call", ABCNamespace.create(ABCNamespaceKind.NAMESPACE.type, "Array.prototype.slice"));
		
		public var start:uint;
		
		private var _parameter:ABCParameter;

		public function JSRestParameterBuilder() {
		}
		
		public static function create(start:uint=0):JSRestParameterBuilder {
			const builder:JSRestParameterBuilder = new JSRestParameterBuilder();
			builder.start = start;
			builder.parameter = ABCParameter.create(ARRAY_PROTOTYPE_CALL, JSReservedKind.ARGUMENTS.type);
			return builder;
		}
		
		public function write(data:ByteArray):void {
			data.writeUTF(parameter.qname.fullName);
			JSTokenKind.LEFT_PARENTHESES.write(data);
			data.writeUTF(parameter.label);
			
			if(start > 0) {
				JSTokenKind.COMMA.write(data);
				data.writeUTF(start.toString(10));
			}
			
			JSTokenKind.RIGHT_PARENTHESES.write(data);
		}
		
		public function get parameter():ABCParameter { return _parameter; }
		public function set parameter(value:ABCParameter) : void { _parameter = value; }
		
		public function get name():String { return "JSRestParameterBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
