package com.codeazur.as3swf.data.abc.exporters.js.builders
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespace;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespaceType;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCVariableBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.ABCJavascriptExporter;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	import com.codeazur.utils.StringUtils;
	import flash.utils.ByteArray;


	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSLocalVariableBuilder extends JSConsumableBlock implements IABCVariableBuilder {

		private var _variable:ABCQualifiedName;
		private var _includeKeyword:Boolean;

		public function JSLocalVariableBuilder() {
			_includeKeyword = true;
		}
		
		public static function create(variable:ABCQualifiedName, expressions:Vector.<IABCWriteable>):JSLocalVariableBuilder {
			const builder:JSLocalVariableBuilder = new JSLocalVariableBuilder();
			builder.variable = variable;
			builder.right = JSNameBuilder.create(expressions, true);
			return builder;
		}
		
		public static function createLocalQName(index:uint = 0):ABCQualifiedName {
			const label:String = ABCJavascriptExporter.LOCAL_PREFIX + index;
			const ns:ABCNamespace = ABCNamespaceType.getType(ABCNamespaceType.ASTERISK);
			return ABCQualifiedName.create(label, ns);
		}
		
		override public function write(data : ByteArray) : void {
			if(includeKeyword) {
				JSReservedKind.VAR.write(data);
				JSTokenKind.SPACE.write(data);
			}
			
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
		
		public function get includeKeyword() : Boolean { return _includeKeyword; }
		public function set includeKeyword(value : Boolean) : void { _includeKeyword = value; }
		
		override public function get name():String { return "JSLocalVariableBuilder"; }
		
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
