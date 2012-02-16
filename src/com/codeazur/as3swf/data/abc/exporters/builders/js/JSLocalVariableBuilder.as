package com.codeazur.as3swf.data.abc.exporters.builders.js
{

	import com.codeazur.as3swf.data.abc.exporters.builders.IABCExpression;
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCVariableBuilder;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSLocalVariableBuilder implements IABCVariableBuilder {

		private var _variable : ABCQualifiedName;
		private var _expression : IABCExpression;

		public function JSLocalVariableBuilder() {
		}
		
		public static function create(variable:ABCQualifiedName, expression:IABCExpression):JSLocalVariableBuilder {
			const builder:JSLocalVariableBuilder = new JSLocalVariableBuilder();
			builder.variable = variable;
			builder.expression = expression;
			return builder;
		}
		
		public function write(data : ByteArray) : void {
			JSReservedKind.VAR.write(data);
			JSTokenKind.SPACE.write(data);
			
			data.writeUTF(_variable.fullName);
			
			if(expression) {
				JSTokenKind.EQUALS.write(data);
				expression.write(data);
			}
			
			JSTokenKind.SEMI_COLON.write(data);
		}
		
		public function get variable() : ABCQualifiedName { return _variable; }
		public function set variable(value : ABCQualifiedName) : void { _variable = value; }

		public function get expression() : IABCExpression { return _expression; }
		public function set expression(value : IABCExpression) : void { _expression = value; }
		
		public function get name():String { return "JSVariableBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
