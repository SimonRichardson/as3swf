package com.codeazur.as3swf.data.abc.exporters.js.builders.variables
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespace;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCNamespaceType;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCVariableBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.ABCJavascriptExporter;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSConsumableBlock;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSNameBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.JSTokenKind;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	import com.codeazur.utils.StringUtils;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSProtectedVariableBuilder extends JSConsumableBlock implements IABCVariableBuilder {

		private var _variable:ABCQualifiedName;

		public function JSProtectedVariableBuilder() {
		}
		
		public static function create(variable:ABCQualifiedName, expressions:Vector.<IABCWriteable> = null):JSProtectedVariableBuilder {
			const builder:JSProtectedVariableBuilder = new JSProtectedVariableBuilder();
			builder.variable = createQName(variable.label);
			if(expressions) {
				builder.right = JSNameBuilder.create(expressions, true);
			}
			return builder;
		}
		
		public static function createQName(name:String):ABCQualifiedName {
			const ns:ABCNamespace = ABCNamespaceType.getType(ABCNamespaceType.PROTECTED);
			ns.value = ABCJavascriptExporter.NAMESPACE_PROTECTED_PREFIX;
			return ABCQualifiedName.create(name, ns);
		}
		
		override public function write(data : ByteArray) : void {			
			data.writeUTF(variable.fullName);
			
			if(right) {
				JSTokenKind.EQUALS.write(data);
				right.write(data);
			}
		}
		
		public function get variable() : ABCQualifiedName { return _variable; }
		public function set variable(value : ABCQualifiedName) : void { _variable = value; }

		public function get expression() : IABCWriteable { return right; }
		public function set expression(value : IABCWriteable) : void { right = value; }
		
		public function get includeKeyword() : Boolean { return false; }
		public function set includeKeyword(value : Boolean) : void { throw new Error('Missing implementation'); }
		
		override public function get name():String { return "JSProtectedVariableBuilder"; }
		
		override public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "QName:";
			str += "\n" + variable.toString(indent + 4);
			
			if(expression) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Expression:";
				str += "\n" + expression.toString(indent + 4);
			}
			
			return str;
		}
	}
}
