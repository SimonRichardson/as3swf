package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCMultinameBuiltin;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCApplyTypeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSMultinameArgumentBuilder;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSApplyTypeBuilder implements IABCApplyTypeBuilder {

		private var _expressions:Vector.<IABCWriteable>;

		public function JSApplyTypeBuilder(){
		}

		public static function create(expressions:Vector.<IABCWriteable>):JSApplyTypeBuilder {
			const builder:JSApplyTypeBuilder = new JSApplyTypeBuilder();
			builder.expressions = expressions;
			return builder;
		}
		
		public function write(data:ByteArray):void {	
			const total:int = expressions.length;
			for(var i:uint=0; i<total; i++) {
				const expression:IABCWriteable = expressions[i];
				if(containsVector(expression)) {
					data.writeUTF(ABCMultinameBuiltin.ARRAY.fullName);
				} else {
					expression.write(data);
				}
				
				if(i < total - 1) {
					JSTokenKind.DOT.write(data);
				}
			}
		}
		
		private function containsVector(expression:IABCWriteable):Boolean {
			var result:Boolean = false;
			
			if(expression is JSConsumableBlock) {
				
				const block:JSConsumableBlock = JSConsumableBlock(expression);
				if(block.left is JSNameBuilder) {
					
					const name:JSNameBuilder = JSNameBuilder(block.left);
					const nameExpressions:Vector.<IABCWriteable> = name.expressions;
					if(nameExpressions.length == 1) {
						
						const namedWriteable:IABCWriteable = nameExpressions[0];
						if(namedWriteable is JSConsumableBlock) {
							
							const nestedBlock:JSConsumableBlock = JSConsumableBlock(namedWriteable);
							if(nestedBlock.right is JSMultinameArgumentBuilder) {
								
								const multinameArgument:JSMultinameArgumentBuilder = JSMultinameArgumentBuilder(nestedBlock.right);
								if(multinameArgument.argument.multiname) {
									
									const qname:IABCMultiname = multinameArgument.argument.multiname;
									if(ABCMultinameBuiltin.isBuiltin(qname) && ABCMultinameBuiltin.isType(qname, ABCMultinameBuiltin.VECTOR)) {
										
										result = true;
									} 
								}
							}
						}
					}
				}
			}
			
			return result;
		}
		
		public function get expressions():Vector.<IABCWriteable> { return _expressions; }
		public function set expressions(value:Vector.<IABCWriteable>):void { _expressions = value; }
		
		public function get name():String { return "JSApplyTypeBuilder"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			return str;
		}
	}
}
