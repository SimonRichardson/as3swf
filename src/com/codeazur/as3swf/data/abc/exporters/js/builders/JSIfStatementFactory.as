package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSEqualityExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSInequalityExpression;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSIfStatementFactory {
		
		public static function create(kind:ABCOpcodeKind, items:Vector.<IABCWriteable>):JSConsumableBlock {
			const expression:JSConsumableBlock = createExpression(kind);
			switch(kind) {
				case ABCOpcodeKind.IFEQ:
					if(items.length == 2) {
						expression.left = items[0];
						expression.right = items[1];
					} else {
						throw new Error();
					}
					break;
					
				case ABCOpcodeKind.IFNE:
					if(items.length == 2) {
						expression.left = items[0];
						expression.right = items[1];
					} else {
						throw new Error();
					}
					break;
					
				default:
					throw new Error();
			}
			return expression;
		}
		
		public static function createExpression(kind:ABCOpcodeKind):JSConsumableBlock {
			switch(kind) {
				case ABCOpcodeKind.IFEQ:
					return JSInequalityExpression.create();
					
				case ABCOpcodeKind.IFNE:
					return JSEqualityExpression.create();
					
				default:
					throw new Error();
			}
		}
	}
}
