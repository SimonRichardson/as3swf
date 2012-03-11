package com.codeazur.as3swf.data.abc.exporters.js.builders.arguments
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespace;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceType;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCAttributeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;
	import com.codeazur.utils.StringUtils;
	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSArgumentsBuilder implements IABCAttributeBuilder {
		
		public var index:int;
		
		private var _argument:ABCParameter;

		public function JSArgumentsBuilder() {
			const name:String = "arguments";
			const ns:ABCNamespace = ABCNamespace.getType(ABCNamespaceType.ASTERISK);
			const qname:ABCQualifiedName = ABCQualifiedName.create(name, ns);
			_argument = ABCParameter.create(qname, name);
		}
		
		public static function create(index:int=-1):JSArgumentsBuilder {
			const builder:JSArgumentsBuilder = new JSArgumentsBuilder();
			builder.index = index;
			return builder;
		}
		
		public function write(data:ByteArray):void {
			data.writeUTF(argument.label);
			
			if(index >= 0) {
				JSTokenKind.LEFT_SQUARE_BRACKET.write(data);
				data.writeUTF(index.toString(10));
				JSTokenKind.RIGHT_SQUARE_BRACKET.write(data);
			}
		}
		
		public function get argument():ABCParameter { return _argument; }
		public function set argument(value:ABCParameter) : void { _argument = value; }
		
		public function get name():String { return "JSArgumentsBuilder"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			if(argument) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Arguments:";
				str += "\n" + argument.toString(indent + 4);
			}
			
			return str;
		}
	}
}
