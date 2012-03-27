package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.IABCOpcodeIntegerAttribute;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeSet extends ABCSet {
		
		public var opcodes:Vector.<ABCOpcode>;
		public var jumpTargets:Vector.<ABCOpcodeJumpTarget>;
		
		public var autoBuildJumpTargets:Boolean;
		
		private var _jumpPositions:Vector.<ABCOpcodeJumpTargetPosition>;
		private var _hasAlchemyOpcodes:Boolean; 
				
		public function ABCOpcodeSet(abcData:ABCData) {
			super(abcData);
			
			opcodes = new Vector.<ABCOpcode>();
			jumpTargets = new Vector.<ABCOpcodeJumpTarget>();
			
			autoBuildJumpTargets = false;
			
			_hasAlchemyOpcodes = false;
			_jumpPositions = new Vector.<ABCOpcodeJumpTargetPosition>();
		}
		
		public static function create(abcData:ABCData):ABCOpcodeSet {
			return new ABCOpcodeSet(abcData);
		}
		
		public function read(data:SWFData):void {
			opcodes.length = 0;
			jumpTargets.length = 0;
			_jumpPositions.length = 0;
			
			const codeLength:uint = data.readEncodedU30();
			if(codeLength > 0) {
				
				var dataPositionOffset:uint = 0;
				
				const total:uint = data.position + codeLength;
				while(data.position < total) {
					const dataPosition:uint = data.position;
					
					const opcodeKind:uint = data.readUI8();
					const opcode:ABCOpcode = ABCOpcodeFactory.create(abcData, opcodeKind);
					opcode.read(data);
					
					if(opcode.alchemyOpcode) {
						_hasAlchemyOpcodes = true;
					}
					
					opcodes.push(opcode);
					
					// Jump targets
					if(ABCOpcodeJumpTargetKind.isKind(opcode)) {
						jumpTargets.push(ABCOpcodeJumpTarget.create(opcode));
					}
					
					const start:uint = dataPositionOffset;
					const finish:uint = dataPositionOffset + (data.position - dataPosition);
					
					_jumpPositions.push(ABCOpcodeJumpTargetPosition.create(opcode, start, finish));
					
					dataPositionOffset = finish;
				}
				
				if(autoBuildJumpTargets) {
					buildJumpTargets();
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
		
		public function buildJumpTargets():void {
			const jumpTargetsTotal:uint = jumpTargets.length;
			if(jumpTargetsTotal > 0) {
				for(var i:uint=0; i<jumpTargetsTotal; i++) {
					const jumpTarget:ABCOpcodeJumpTarget = jumpTargets[i];
					const jumpOpcode:ABCOpcode = jumpTarget.opcode;
					const jumpAttribute:ABCOpcodeAttribute = jumpOpcode.attribute;
					
					if(ABCOpcodeJumpTargetKind.isType(jumpTarget, ABCOpcodeKind.LOOKUPSWITCH)) {
						
					} else {
						if(jumpAttribute is IABCOpcodeIntegerAttribute) {
							const attribute:IABCOpcodeIntegerAttribute = IABCOpcodeIntegerAttribute(jumpAttribute);
							
							const opcodeTarget:ABCOpcodeJumpTargetPosition = getJumpTargetPosition(jumpOpcode);
							if(opcodeTarget) {
								
								const jumpToPosition:uint = opcodeTarget.finish + attribute.integer;
								const jumpToTarget:ABCOpcodeJumpTargetPosition = getJumpToTarget(jumpToPosition);
								
								if(jumpToTarget && jumpToTarget.opcode) {
									jumpTarget.targetOpcode = jumpToTarget.opcode;
								} else {
									throw new Error('No such opcode target');
								}
								
							} else {
								throw new Error('No such opcode');
							}
						} else {
							throw new Error('Invalid opcode attribute (recieved:' + jumpAttribute + ')');
						}
					}
				}
			}
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
					break;
				}
			}
			
			return result;
		}
		
		private function getJumpTargetPosition(opcode:ABCOpcode):ABCOpcodeJumpTargetPosition {
			var result:ABCOpcodeJumpTargetPosition = null;
			
			const total:uint = _jumpPositions.length;
			for(var i:uint=0; i<total; i++) {
				const targetPosition:ABCOpcodeJumpTargetPosition = _jumpPositions[i];
				if(targetPosition.opcode == opcode) {
					result = targetPosition;
					break;
				}
			}
			
			return result;
		}
		
		private function getJumpToTarget(position:uint):ABCOpcodeJumpTargetPosition {
			var result:ABCOpcodeJumpTargetPosition = null;
			
			const total:uint = _jumpPositions.length;
			for(var i:uint=0; i<total; i++) {
				const targetPosition:ABCOpcodeJumpTargetPosition = _jumpPositions[i];
				if(targetPosition.contains(position)) {
					result = targetPosition;
					break;
				}
			}
			
			return result;
		}
		
		override public function set abcData(value : ABCData) : void {
			super.abcData = value;
			
			const total:uint = opcodes.length;
			for(var i:uint=0; i<total; i++){
				const opcode:ABCOpcode = opcodes[i];
				opcode.abcData = value;
			}
		}
		
		public function get hasAlchemyOpcodes():Boolean { return _hasAlchemyOpcodes; }
		
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
