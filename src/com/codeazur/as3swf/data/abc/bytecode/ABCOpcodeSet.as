package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeLookupSwitchAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.IABCOpcodeIntegerAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.utils.getClassFromInstance;
	import com.codeazur.utils.StringUtils;

	import flash.utils.Dictionary;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeSet extends ABCSet {
		
		public var opcodes:Vector.<ABCOpcode>;
		public var jumpTargets:Vector.<ABCOpcodeJumpTarget>;
				
		public function ABCOpcodeSet(abcData:ABCData) {
			super(abcData);
			
			opcodes = new Vector.<ABCOpcode>();
			jumpTargets = new Vector.<ABCOpcodeJumpTarget>();
		}
		
		public static function create(abcData:ABCData):ABCOpcodeSet {
			return new ABCOpcodeSet(abcData);
		}
		
		public function read(data:SWFData):void {
			
			opcodes.length = 0;
			jumpTargets.length = 0;
			
			var opcodeStartPosition:uint = 0;
			var opcodeOffsetPosition:uint = 0;
			
			const jumpTargetByOpcode:Dictionary = new Dictionary();
			const jumpTargetByPositions:Dictionary = new Dictionary();
			
			const codeLength:uint = data.readEncodedU30();
			const total:uint = data.position + codeLength;
			while(data.position < total) {
				opcodeStartPosition = data.position;
				
				const opcodeKind:uint = data.readUI8();
				const opcode:ABCOpcode = ABCOpcodeFactory.create(abcData, opcodeKind);
				opcode.read(data);
				
				const startLocation:uint = opcodeOffsetPosition;
				opcodeOffsetPosition += data.position - opcodeStartPosition;
				const finishLocation:uint = opcodeOffsetPosition;
				
				const opcodePosition:ABCOpcodeJumpTargetPosition = ABCOpcodeJumpTargetPosition.create(startLocation, finishLocation);
				jumpTargetByOpcode[opcodePosition.start] = opcode;
				jumpTargetByPositions[opcode] = opcodePosition; 
				
				if(ABCOpcodeJumpTargetKind.isKind(opcode)) {
					jumpTargets.push(ABCOpcodeJumpTarget.create(opcode));
				}
				
				opcodes.push(opcode);
			}
			
			const jumpTargetsTotal:uint = jumpTargets.length;
			if(jumpTargetsTotal > 0) {
				var position:int;
				var targetPosition:int;
				var targetOpcode:ABCOpcode;
				var jumpTargetPosition:ABCOpcodeJumpTargetPosition;
				
				for(var j:uint=0; j<jumpTargetsTotal; j++) {
					const jumpTarget:ABCOpcodeJumpTarget = jumpTargets[j];
					const jumpOpcode:ABCOpcode = jumpTarget.opcode;
					if(ABCOpcodeJumpTargetKind.isType(jumpTarget, ABCOpcodeKind.LOOKUPSWITCH)) {
						
						if(jumpOpcode.attribute is ABCOpcodeLookupSwitchAttribute) {
							const switchAttribute:ABCOpcodeLookupSwitchAttribute = ABCOpcodeLookupSwitchAttribute(jumpOpcode.attribute);
							
							const offsets:Vector.<int> = switchAttribute.offsets;
							const offsetsTotal:uint = offsets.length;
							for(var k:uint=0; k<offsetsTotal; k++) {
								position = offsets[k];
								
								jumpTargetPosition = jumpTargetByPositions[jumpOpcode];
								targetPosition = jumpTargetPosition.start + position;
								
								targetOpcode = jumpTargetByOpcode[targetPosition];
								
								if(null == targetOpcode) {
									throw new Error("Invalid jump target");
								}
								
								jumpTarget.optionalTargetOpcodes.push(targetOpcode);
							}
							
							position = switchAttribute.defaultOffset;
							
							jumpTargetPosition = jumpTargetByPositions[jumpOpcode];
							targetPosition = jumpTargetPosition.start + position;
							
							targetOpcode = jumpTargetByOpcode[targetPosition];
							
							jumpTarget.targetOpcode;
						}
					} else {
						
						if(jumpOpcode.attribute is IABCOpcodeIntegerAttribute) {
							const intAttribute:IABCOpcodeIntegerAttribute = IABCOpcodeIntegerAttribute(jumpOpcode.attribute);
							
							position = intAttribute.integer;
							
							jumpTargetPosition = jumpTargetByPositions[jumpOpcode];
							targetPosition = jumpTargetPosition.finish + position;
							
							targetOpcode = jumpTargetByOpcode[targetPosition];
							
							if(null == targetOpcode) {
								throw new Error("Invalid jump target");
							}
							
							jumpTarget.targetOpcode = targetOpcode;
						} else {
							throw new Error("Invalid attribute: " + getClassFromInstance(jumpOpcode.attribute));
						}
					}
				}
			}
		}
		
		public function write(bytes:SWFData):void {
			const data:SWFData = new SWFData();
			
			const total:uint = opcodes.length;
			for(var i:uint=0; i<total; i++) {
				const opcode:ABCOpcode = opcodes[i];
				data.writeUI8(opcode.kind.type);
				opcode.write(data);
			}
			
			const dataLength:uint = data.length;
			bytes.writeEncodedU32(dataLength);
			bytes.writeBytes(data, 0, dataLength);
		}
		
		public function getAt(index:uint):ABCOpcode {
			return opcodes[index];
		}
		
		public function isJumpPoint(opcode:ABCOpcode):Boolean {
			var result:Boolean = false;
			
			const total:uint = jumpTargets.length;
			for(var i:uint=0; i<total; i++) {
				const jumpTarget:ABCOpcodeJumpTarget = jumpTargets[i];
				if(jumpTarget.opcode == opcode) {
					result = true;
					break;
				}
			}
			
			return result;
		}
		
		public function getJumpTarget(opcode:ABCOpcode):ABCOpcode {
			var result:ABCOpcode = null;
			
			const total:uint = jumpTargets.length;
			for(var i:uint=0; i<total; i++) {
				const jumpTarget:ABCOpcodeJumpTarget = jumpTargets[i];
				if(jumpTarget.opcode == opcode) {
					result = jumpTarget.targetOpcode;
				}
			}
			
			return result;
		}
		
		override public function get length():uint { return opcodes.length; }
		override public function get name():String { return "ABCOpcodeSet"; }
		
		override public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Number Opcode: ";
			str += opcodes.length;
			
			if(opcodes.length > 0) {
				for(var i:uint=0; i<opcodes.length; i++) {
					str += "\n" + opcodes[i].toString(indent + 4);
				}
			}
			
			return str;
		}
	}
}
