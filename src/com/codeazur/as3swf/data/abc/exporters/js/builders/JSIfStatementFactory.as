package com.codeazur.as3swf.data.abc.exporters.js.builders
{

	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSEqualityExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSGreaterThanExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSInequalityExpression;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.expressions.JSLogicalAndExpression;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSIfStatementFactory {
		
		public static function create(kind:ABCOpcodeKind, items:Vector.<IABCWriteable>):JSConsumableBlock {
			trace(items);
			return null;
			
//			const expression:JSConsumableBlock = createExpression(kind);
//			
//			const total:uint = items.length;
//			if(total == 2) {
//				expression.left = items[0];
//				expression.right = items[1];
//			} else if(total == 1) {
//				expression.left = items[0];
//			} else {
//				//throw new Error();
//			}
//			
//			return expression;
		}
		
		public static function make(statements:Vector.<IABCWriteable>):JSConsumableBlock {
			const root:JSConsumableBlock = new JSLogicalAndExpression();
			
			var block:JSConsumableBlock = root;
			const total:uint = statements.length;
			for(var i:uint=0; i<total; i++) {
				block.left = statements[i];
				if(i < total - 1) {
					block.right = new JSLogicalAndExpression();
					block = block.right as JSConsumableBlock;
				} 
			}
			
			return root;
		}
		
		private static function createExpression(kind:ABCOpcodeKind):JSConsumableBlock {
			switch(kind) {
				case ABCOpcodeKind.IFEQ:
				case ABCOpcodeKind.IFTRUE:
					return JSInequalityExpression.create();
					
				case ABCOpcodeKind.IFNE:
				case ABCOpcodeKind.IFFALSE:
					return JSEqualityExpression.create();
				
				case ABCOpcodeKind.IFNGT:
					return JSGreaterThanExpression.create();
				
				default:
					throw new Error(kind);
			}
		}
	}
}
