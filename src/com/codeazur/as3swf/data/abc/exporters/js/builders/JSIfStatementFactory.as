package com.codeazur.as3swf.data.abc.exporters.js.builders
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.exporters.builders.ABCIfStatementType;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCIfStatementExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSIfEqualExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSIfFalseExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSIfNotEqualExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSIfNotGreaterThanExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSIfTrueExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSInequalityExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSLogicalAndExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSLogicalOrExpression;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSIfStatementFactory {
		
		public static function create(kind:ABCOpcodeKind, items:Vector.<IABCWriteable>):IABCIfStatementExpression {
			const expression:IABCIfStatementExpression = createExpression(kind);
			
			const total:uint = items.length;
			if(total == 2) {
				expression.statement = JSInequalityExpression.create(items[0], items[1]);
			} else if(total == 1) {
				expression.statement = items[0];
			} else {
				throw new Error("Invalid if statement expression count (expected=1 or 2, recieved=" + total + ")");
			}
			
			return expression;
		}
		
		public static function make(statements:Vector.<IABCWriteable>):JSConsumableBlock {
			var result:JSConsumableBlock;
			 
			const total:uint = statements.length;
			if(total == 0) {
				result = null;
			} else if(total == 1) {
				result = JSConsumableBlock.create(statements[0]);
			} else if(total > 1) {
				result = createLogicalExpression(statements[0], statements[1]);
				
				var block:JSConsumableBlock = result;
				for(var i:uint=0; i<total; i++) {
					block.left = statements[i];
					
					if(i < total - 1) {
						block.right = createLogicalExpression(statements[i], statements[i + 1]);
						block = block.right as JSConsumableBlock;
					}
				}
			} else {
				throw new Error();
			}
			
			return result;
		}
		
		private static function createLogicalExpression(itemA:IABCWriteable, itemB:IABCWriteable):JSConsumableBlock {
			const type0:ABCIfStatementType = IABCIfStatementExpression(itemA).type;
			const type1:ABCIfStatementType = IABCIfStatementExpression(itemB).type;
				
			return (ABCIfStatementType.equals(type0, type1)) ? new JSLogicalAndExpression() : new JSLogicalOrExpression();
		}
		
		private static function createExpression(kind:ABCOpcodeKind):IABCIfStatementExpression {
			var expression:IABCIfStatementExpression;
			
			switch(kind) {
				case ABCOpcodeKind.IFEQ:
					expression = JSIfEqualExpression.create();
					break;
					
				case ABCOpcodeKind.IFTRUE:
					expression = JSIfTrueExpression.create();
					break;
					
				case ABCOpcodeKind.IFNE:
					expression = JSIfNotEqualExpression.create();
					break;
					
				case ABCOpcodeKind.IFFALSE:
					expression = JSIfFalseExpression.create();
					break;
				
				case ABCOpcodeKind.IFNGT:
					expression = JSIfNotGreaterThanExpression.create();
					break;
				
				default:
					throw new Error(kind);
			}
			
			return expression;
		}
	}
}
