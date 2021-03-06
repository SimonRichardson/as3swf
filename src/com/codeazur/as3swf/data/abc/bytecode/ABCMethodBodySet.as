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
		
		public function add(methodBody:ABCMethodBody):void {
			addAt(methodBody, length);
		}
		
		public function addAt(methodBody:ABCMethodBody, index:uint):void {
			const methodInfo:ABCMethodInfo = methodBody.methodInfo;
			const methodName:String = methodInfo.methodName;
			const total:uint = length;
			for(var i:uint=0; i<total; i++) {
				const m:ABCMethodBody = methodBodies[i];
				if(methodName == m.methodInfo.methodName) {
					throw new Error('Method name already exists (recieved:' + methodName + ')');
				}
			}
			abcData.methodInfoSet.addAt(methodInfo, index);
			
			const methodIndex:uint = getMethodInfoIndex(methodInfo);
			
			methodBody.methodInfoIndex = methodIndex;
			methodInfo.methodIndex = methodIndex;
			
			if(index == 0) {
				methodBodies.unshift(methodBody);
			} else if(index == length) {
				methodBodies.push(methodBody);
			} else if(index > 0 && index < length) {
				methodBodies.splice(index, 0, methodBody);
			} else {
				throw new RangeError("Invalid index");
			}
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
		
		public function getAt(index:uint):ABCMethodBody {
			return methodBodies[index];
		}
		
		public function get hasAlchemyOpcodes():Boolean { return _hasAlchemyOpcodes; }
		
		override public function get name():String { return "ABCMethodBodySet"; }
		override public function get length():uint { return methodBodies.length; }
		
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
