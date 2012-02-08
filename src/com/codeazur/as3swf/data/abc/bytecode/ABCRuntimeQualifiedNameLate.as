package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCRuntimeQualifiedNameLate extends ABCBaseMultiname {
		
		public function ABCRuntimeQualifiedNameLate(){}
		
		public static function create(kind:int = -1):ABCRuntimeQualifiedNameLate {
			const qname:ABCRuntimeQualifiedNameLate = new ABCRuntimeQualifiedNameLate();
			qname.kind = kind < 0? ABCMultinameKind.RUNTIME_QNAME_LATE : ABCMultinameKind.getType(kind);
			return qname; 
		}
		
		override public function get name():String { return "ABCRuntimeQualifiedNameLate"; }
		
		override public function toString(indent:uint = 0):String {
			return ABC.toStringCommon(name, indent) + 
				"Kind: " + kind.toString();
		}
	}
}
