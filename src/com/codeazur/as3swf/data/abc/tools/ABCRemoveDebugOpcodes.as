package com.codeazur.as3swf.data.abc.tools
{

	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodBody;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcode;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeJumpTarget;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeJumpTargetPosition;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeSet;
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
						
						const targetPosition:ABCOpcodeJumpTargetPosition = opcodes.getJumpTargetPosition(opcode);
						if(targetPosition) {
							const delta:int = targetPosition.finish - targetPosition.start;
							
							opcodes.opcodes.splice(index, 1);
							
							// TODO : move the jump positions back by the delta
						} else {
							throw new Error('Invalid opcode target position');
						}
					}
				}
				
				if(opcodes.autoBuildJumpTargets) {
					opcodes.buildJumpTargets();
				}
			}
		}
	}
}
