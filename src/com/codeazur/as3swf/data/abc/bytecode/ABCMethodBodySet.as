package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	import com.codeazur.as3swf.data.abc.io.ABCScanner;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCMethodBodySet extends ABCSet {
		
		public var methodBodies:Vector.<ABCMethodBody>;
		
		private var _hasAlchemyOpcodes:Boolean; 
		
		public function ABCMethodBodySet(abcData : ABCData) {
			super(abcData);
			
			_hasAlchemyOpcodes = false;
			
			methodBodies = new Vector.<ABCMethodBody>();
		}
		
		public function merge(methodBodySet:ABCMethodBodySet):void {
			methodBodySet.abcData = abcData;
			
			const total:uint = methodBodySet.methodBodies.length;
			for(var i:uint=0; i<total; i++) {
				const info:ABCMethodBody = methodBodySet.methodBodies[i];
				info.abcData = abcData;
				
				info.methodInfoIndex = getMethodInfoIndex(info.methodInfo); 
				
				methodBodies.push(info);
			}
		}
		
		public function read(data:SWFData, scanner:ABCScanner):void {
			const position:uint = scanner.getMethodBodyInfo();
			if(data.position != position) {
				throw new Error('Invalid position (Expected: ' + data.position + ', Recieved: ' + position + ')');
			}
			
			data.position = position;
			
			const total:uint = data.readEncodedU30();
			
			for(var i:uint=0; i<total; i++) {
				data.position = scanner.getMethodBodyInfoAtIndex(i);
				
				const methodBody:ABCMethodBody = ABCMethodBody.create(abcData);
				const methodBodyTraitPositions:Vector.<uint> = scanner.getMethodBodyTraitInfoAtIndex(i);
				methodBody.read(data, scanner, methodBodyTraitPositions);
				
				if(methodBody.hasAlchemyOpcodes) {
					_hasAlchemyOpcodes = true;
				}
				
				methodBodies.push(methodBody);
			}
		}
		
		public function write(bytes:SWFData):void {
			const total:uint = methodBodies.length;
			bytes.writeEncodedU32(total);
			
			for(var i:uint=0; i<total; i++) {
				const methodBody:ABCMethodBody = methodBodies[i];
				methodBody.write(bytes);
			}
		}
		
		public function get hasAlchemyOpcodes():Boolean { return _hasAlchemyOpcodes; }
		
		override public function get name():String { return "ABCMethodBodySet"; }
		
		override public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Number MethodBody: ";
			str += methodBodies.length;
			
			if(methodBodies.length > 0) {
				for(var i:uint=0; i<methodBodies.length; i++) {
					str += "\n" + methodBodies[i].toString(indent + 4);
				}
			}
			
			return str;
		}
	}
}
