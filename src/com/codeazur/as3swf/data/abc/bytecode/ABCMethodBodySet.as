package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	import com.codeazur.as3swf.data.abc.io.ABCScanner;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCMethodBodySet extends ABCSet {
		
		public var methodBodies:Vector.<ABCMethodBody>;
		
		public function ABCMethodBodySet(abcData : ABCData) {
			super(abcData);
			
			methodBodies = new Vector.<ABCMethodBody>();
		}
		
		public function parse(data:SWFData, scanner:ABCScanner):void {
			const total:uint = data.readEncodedU30();
			for(var i:uint=0; i<total; i++) {
				data.position = scanner.getMethodBodyInfoAtIndex(i);
				
				const methodBody:ABCMethodBody = ABCMethodBody.create(abcData);
				methodBody.parse(data, scanner);
				
				methodBodies.push(methodBody);
			}
		}
		
		override public function get name():String { return "ABCMethodBodySet"; }
		
		override public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
						
			return str;
		}
	}
}
