package com.codeazur.as3swf.data.abc.exporters.js.builders.debug
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.bytecode.attributes.ABCOpcodeAttribute;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCDebugBuilder;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSDebugFactory {
		
		public static function create(kind:ABCOpcodeKind, attribute:ABCOpcodeAttribute):IABCDebugBuilder {
			var debug:IABCDebugBuilder;
			switch(kind) {
				case ABCOpcodeKind.DEBUG:
					debug = JSDebugBuilder.create(attribute);
					break;
					
				case ABCOpcodeKind.DEBUGFILE:
					debug = JSDebugFileBuilder.create(attribute);
					break;
					
				case ABCOpcodeKind.DEBUGLINE:
					debug = JSDebugLineBuilder.create(attribute);
					break;
				
				default:
					throw new Error();
			}
			return debug;
		}
	}
}
