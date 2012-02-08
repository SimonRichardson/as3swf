package com.codeazur.as3swf.data.abc.bytecode
{

	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCMultinameGeneric extends ABCBaseMultiname {

		public var qname:IABCMultiname;
		public var params:Vector.<IABCMultiname>;

		public function ABCMultinameGeneric() {}

		public static function create(qname:IABCMultiname, params:Vector.<IABCMultiname>, kind:int = -1):ABCMultinameGeneric {
			const mname:ABCMultinameGeneric = new ABCMultinameGeneric();
			mname.qname = qname;
			mname.params = params;
			mname.kind = kind < 0? ABCMultinameKind.GENERIC : ABCMultinameKind.getType(kind);
			return mname;
		}

		public function get length():uint { return params.length; }
		
		override public function get name():String { return "ABCMultinameGeneric"; }
		
		override public function toString(indent : uint = 0) : String {
			return ABC.toStringCommon(name, indent) +
				"QName: " + qname + ", " + 
				(null != params ? "Params: " + params + ", " : "") +
				"Kind: " + kind;
		}
		
	}
}
