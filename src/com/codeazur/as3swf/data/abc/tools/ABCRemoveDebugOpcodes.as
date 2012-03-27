package com.codeazur.as3swf.data.abc.tools
{

	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBody;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeJumpTarget;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeSet;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.IABCOpcodeIntegerAttribute;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCRemoveDebugOpcodes implements IABCVistor {
		
		public function ABCRemoveDebugOpcodes() {
		}

		public function visit(value : ABCData) : void {
			const total:uint = value.methodBodySet.length;
			for(var i:uint=0; i<total; i++){
				const methodBody:ABCMethodBody = value.methodBodySet.getAt(i);
				const opcodes:ABCOpcodeSet = methodBody.opcodes;
				var index:int = opcodes.length;
				while(--index>-1) {
					const opcode:ABCOpcode = opcodes.getAt(index);
					const kind:ABCOpcodeKind = opcode.kind;
					if(ABCOpcodeKind.isDebug(kind)) {
						// Patch jump positions.
						const jumpTarget:ABCOpcodeJumpTarget = opcodes.getJumpTargetByTarget(opcode);
						if(jumpTarget) {
							if(index < opcodes.length) { 
								jumpTarget.targetOpcode = opcodes.getAt(index + 1);
							} else {
								throw new Error('Invalid opcode jump position');
							}
						}
						
						opcodes.opcodes.splice(index, 1);
						
						const tailIndex:int = opcodes.length;
						while(--tailIndex>index - 1) {
							const tail:ABCOpcode = opcodes.getAt(tailIndex);
							const possible:ABCOpcodeJumpTarget = opcodes.getJumpTargetByOpcode(tail);
							if(possible && tail == possible.opcode) {
								const tailAttribute:ABCOpcodeAttribute = tail.attribute;
								if(tailAttribute is IABCOpcodeIntegerAttribute) {
									const attribute:IABCOpcodeIntegerAttribute = IABCOpcodeIntegerAttribute(tailAttribute);
									trace(index, attribute.integer, attribute.integer - 1);
									attribute.integer--;
								}
							}
						}
					}
				}
			}
		}
	}
}
