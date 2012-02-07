package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCRuntimeQualifiedName extends ABCNamedMultiname {
		
		public function ABCRuntimeQualifiedName() {}

		public static function create(name:String, kind:uint = NaN):ABCQualifiedName {
			const qname : ABCQualifiedName = new ABCQualifiedName();
			qname.label = name;
			qname.kind = isNaN(kind)? ABCMultinameKind.RUNTIME_QNAME : ABCMultinameKind.getType(kind);
			return qname;
		}
		
		override public function get name():String { return "ABCRuntimeQualifiedName"; }
		
		override public function toString(indent:uint = 0):String {
			return ABC.toStringCommon(name, indent) + 
				"Label: " + label + ", " + 
				"Kind: " + kind.toString();
		}
	}
}
