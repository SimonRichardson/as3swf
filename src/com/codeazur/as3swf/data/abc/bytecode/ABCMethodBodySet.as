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
		
		public function ABCMethodBodySet(abcData : ABCData) {
			super(abcData);
			
			methodBodies = new Vector.<ABCMethodBody>();
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
				
				methodBodies.push(methodBody);
			}
		}
		
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
