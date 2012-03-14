package com.codeazur.as3swf.data.abc.exporters.js.builders
{
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCMultinameKind;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCAttributeBuilder;
	import com.codeazur.as3swf.data.abc.exporters.js.builders.arguments.JSMultinameLateArgumentBuilder;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMultinameFactory {
		
		public static function create(multiname:IABCMultiname):IABCAttributeBuilder {
			var builder:IABCAttributeBuilder;
			
			const kind:ABCMultinameKind = multiname.kind;
			switch(kind) {
				case ABCMultinameKind.MULTINAME_LATE:
					builder = JSMultinameLateArgumentBuilder.create(multiname);
					break;
							
				default:
					throw new Error(kind);
			}
			
			return builder;
		}
	}
}
