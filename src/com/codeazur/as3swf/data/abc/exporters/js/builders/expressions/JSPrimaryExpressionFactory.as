package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCPrimaryExpression;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSPrimaryExpressionFactory {
		
		public static function create(kind:ABCOpcodeKind):IABCPrimaryExpression {
			var expression:IABCPrimaryExpression;
			
			switch(kind) {
				case ABCOpcodeKind.PUSHFALSE:
					expression = new JSFalseExpression();
					break;
					
				case ABCOpcodeKind.PUSHNULL:
					expression = new JSNullExpression();
					break;
				
				case ABCOpcodeKind.PUSHTRUE:
					expression = new JSTrueExpression();
					break;
				
				default:
					throw new Error();
			}
			
			return expression;
		}
	}
}
