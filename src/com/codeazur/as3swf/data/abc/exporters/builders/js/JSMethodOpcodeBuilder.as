package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBody;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespace;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespaceType;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeSet;
	import com.codeazur.as3swf.data.abc.bytecode.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.exporters.ABCJavascriptExporter;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCExpression;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMethodOpcodeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCVariableBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.js.expressions.JSThisExpression;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMethodOpcodeBuilder implements IABCMethodOpcodeBuilder {
		
		private var _methodBody:ABCMethodBody;
		private var _returnType:IABCMultiname;
		
		public function JSMethodOpcodeBuilder() {
		}
		
		public static function create():JSMethodOpcodeBuilder {
			return new JSMethodOpcodeBuilder();
		}

		public function write(data : ByteArray) : void {
			const opcodes:ABCOpcodeSet = methodBody.opcode;
			const total:uint = opcodes.length;
			if(total > 0) {
				// Add scope.
				const scopeName:String = getScopeName();
				const scopeQName:ABCQualifiedName = ABCQualifiedName.create(scopeName, ABCNamespace.getType(ABCNamespaceType.ASTERISK));
				const scopeExpression:IABCExpression = JSThisExpression.create(); 
				const scope:IABCVariableBuilder = JSLocalVariableBuilder.create(scopeQName, scopeExpression);
				scope.write(data);
				
				// Build method args
				for(var i:uint=0; i<total; i++) {
					const opcode:ABCOpcode = opcodes.getAt(i);
					const kind:ABCOpcodeKind = opcode.kind;
					
					if(!ABCOpcodeKind.isDebug(kind)) {
						if(!(i == total - 1 && ABCOpcodeKind.isType(kind, ABCOpcodeKind.RETURNVOID))) {
							trace(opcode);
							break;
						}
					}
				}
			}
		}
		
		public function getScopeName():String {
			return ABCJavascriptExporter.PRE_FIX + 'scope';
		}
		
		public function get methodBody():ABCMethodBody { return _methodBody; }
		public function set methodBody(value:ABCMethodBody):void { _methodBody = value; }
		
		public function get returnType():IABCMultiname { return _returnType; }
		public function set returnType(value:IABCMultiname):void { _returnType = value; }
		
		public function get name():String { return "JSMethodOpcodeBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
