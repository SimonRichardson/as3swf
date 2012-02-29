package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCOperatorExpression;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSOperatorExpressionFactory {

		public static function create(kind:ABCOpcodeKind):IABCOperatorExpression {
			var expression:IABCOperatorExpression;
			
			switch(kind) {
				case ABCOpcodeKind.EQUALS:
					expression = new JSEqualityExpression();
					break;
					
				case ABCOpcodeKind.NOT:
					expression = new JSInequalityExpression();
					break;
				
				default:
					throw new Error();
			}
			
			return expression;
		}
	}
}
