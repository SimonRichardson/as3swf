package com.codeazur.as3swf.data.abc.exporters.js.builders
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCIfStatementExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSIfEqualExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSIfFalseExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSIfNotEqualExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSIfNotGreaterThanExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSIfTrueExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSLogicalAndExpression;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSIfStatementFactory {
		
		public static function create(kind:ABCOpcodeKind, items:Vector.<IABCWriteable>):IABCIfStatementExpression {
			const expression:IABCIfStatementExpression = createExpression(kind);
			
			const total:uint = items.length;
			if(total == 2) {
				// This is wrong.
				expression.statement = JSConsumableBlock.create(items[0], items[1]);
			} else if(total == 1) {
				expression.statement = items[0];
			} else {
				throw new Error();
			}
			
			return expression;
		}
		
		public static function make(statements:Vector.<IABCWriteable>):JSConsumableBlock {
			// this is wrong
			trace(statements);
			const root:JSConsumableBlock = new JSLogicalAndExpression();
			
//			var block:JSConsumableBlock = root;
//			const total:uint = statements.length;
//			for(var i:uint=0; i<total; i++) {
//				block.left = statements[i];
//				if(i < total - 1) {
//					block.right = new JSLogicalAndExpression();
//					block = block.right as JSConsumableBlock;
//				} 
//			}
			
			return root;
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
