package com.codeazur.as3swf.data.abc.exporters.js.builders.debug
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeIntAttribute;
	import com.codeazur.as3swf.data.abc.exporters.ABCJavascriptExporter;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCDebugBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSAccessorBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSThisExpression;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	import flash.utils.ByteArray;



	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSDebugLineBuilder implements IABCDebugBuilder {
		
		public static const METHOD_NAME:String = "debugLine";
		
		public var _attribute:ABCOpcodeAttribute;

		public function JSDebugLineBuilder() {
		}
		
		public static function create(attribute:ABCOpcodeAttribute):JSDebugLineBuilder {
			const builder:JSDebugLineBuilder = new JSDebugLineBuilder();
			builder.attribute = attribute;
			return builder; 
		}

		public function write(data : ByteArray) : void {
			if(attribute is ABCOpcodeIntAttribute) {
				const debug:ABCOpcodeIntAttribute = ABCOpcodeIntAttribute(attribute);
				
				JSAccessorBuilder.create(new <IABCWriteable>[JSThisExpression.create()]).write(data);
				JSTokenKind.DOT.write(data);
				
				data.writeUTF(ABCJavascriptExporter.PRE_FIX + METHOD_NAME);
				
				JSTokenKind.LEFT_PARENTHESES.write(data);
				
				data.writeUTF(debug.integer.toString());
				
				JSTokenKind.RIGHT_PARENTHESES.write(data);
				
				JSTokenKind.SEMI_COLON.write(data);
			} else {
				throw new Error();
			}
		}
		
		public function get name():String { return "JSDebugLineBuilder"; }
		public function get attribute() : ABCOpcodeAttribute { return _attribute; }
		public function set attribute(value : ABCOpcodeAttribute) : void { _attribute = value; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
