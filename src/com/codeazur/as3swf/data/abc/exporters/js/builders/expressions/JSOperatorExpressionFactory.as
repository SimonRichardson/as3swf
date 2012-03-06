package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCOperatorExpression;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSOperatorExpressionFactory {

		public static function create(kind:ABCOpcodeKind, items:Vector.<IABCWriteable>):IABCOperatorExpression {
			var infix:Boolean = false;
			var expression:IABCOperatorExpression;
			
			switch(kind) {
				case ABCOpcodeKind.ADD:
				case ABCOpcodeKind.ADD_D:
				case ABCOpcodeKind.ADD_I:
					expression = new JSAddExpression();
					break;
				
				case ABCOpcodeKind.DIVIDE:
					expression = new JSDivideExpression();
					break;
					
				case ABCOpcodeKind.EQUALS:
					expression = new JSEqualityExpression();
					break;
					
				case ABCOpcodeKind.MULTIPLY:
					expression = new JSMultiplyExpression();
					break;
					
				case ABCOpcodeKind.NOT:
					// If equals is the first child, lets make remove it.
					const firstChild:IABCWriteable = items[0];
					expression = new JSInequalityExpression();
					if(firstChild is JSEqualityExpression) {
						const equality:JSEqualityExpression = JSEqualityExpression(firstChild);
						expression.left = equality.left;
						expression.right = equality.right;
						infix = true;
					}
					break;
				
				case ABCOpcodeKind.SUBTRACT:
				case ABCOpcodeKind.SUBTRACT_I:
					expression = new JSSubtractExpression();
					break;
				
				default:
					throw new Error();
			}
			
			if(!infix) {
				const total:uint = items.length;
				if(total == 2) {
					expression.left = items[0];
					expression.right = items[1];
				} else if(total == 1){
					expression.left = items[0];
				} else {
					throw new Error();
				}
			}
			
			return expression;
		}
	}
}
