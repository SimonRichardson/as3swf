package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.ABCData;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCOpcodeFactory {
		
		public static function create(abcData:ABCData, kind:uint):ABCOpcode {
			 return ABCOpcode.create(abcData, ABCOpcodeKind.getType(kind));
		}
		
	}
}
