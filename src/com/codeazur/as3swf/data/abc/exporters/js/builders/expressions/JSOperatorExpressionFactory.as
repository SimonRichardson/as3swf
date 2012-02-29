package com.codeazur.as3swf.data.abc.exporters.js.builders.expressions
{

	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCOperatorExpression;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSOperatorExpressionFactory {

		public static function create(kind:ABCOpcodeKind, items:Vector.<IABCWriteable>):IABCOperatorExpression {
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
			
			const total:uint = items.length;
			if(total == 2) {
				expression.left = items[0];
				expression.right = items[1];
			} else if(total == 1){
				expression.left = items[0];
			} else {
				throw new Error();
			}
			
			return expression;
		}
	}
}
