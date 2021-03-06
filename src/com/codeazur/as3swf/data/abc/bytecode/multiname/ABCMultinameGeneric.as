package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCMultinameGeneric extends ABCBaseMultiname {

		public var multiname:IABCMultiname;
		public var params:Vector.<IABCMultiname>;

		public function ABCMultinameGeneric() {}

		public static function create(multiname:IABCMultiname, params:Vector.<IABCMultiname>, kind:int = -1):ABCMultinameGeneric {
			const mname:ABCMultinameGeneric = new ABCMultinameGeneric();
			mname.multiname = multiname;
			mname.params = params;
			mname.kind = kind < 0? ABCMultinameKind.GENERIC : ABCMultinameKind.getType(kind);
			return mname;
		}
		
		override public function equals(abcMultiname : IABCMultiname) : Boolean {
			if(this == abcMultiname) {
				return true;
			} else if(abcMultiname is ABCMultinameGeneric) {
				const generic:ABCMultinameGeneric = ABCMultinameGeneric(abcMultiname);
				if(multiname.equals(generic.multiname)) {
					var valid:Boolean = true;
					const total:uint = params.length;
					if(total == generic.params.length) {
						for(var i:uint=0; i<total; i++) {
							const m0:IABCMultiname = params[i];
							const m1:IABCMultiname = generic.params[i];
							if(!m0.equals(m1)) {
								valid = false;
								break;
							}
						}
						
						if(valid) {
							return super.equals(abcMultiname);
						}
					}
				}
			}
			return false;
		}

		public function get length():uint { return params.length; }
		
		override public function get name():String { return "ABCMultinameGeneric"; }
		
		override public function toString(indent : uint = 0) : String {
			var str:String = super.toString(indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Multiname: ";
			str += "\n" + multiname.toString(indent + 4);
			
			if(params) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Params: ";
				
				for(var i:int=0; i<params.length; i++) {
					 str += "\n" + params[i].toString(indent + 4);
				}
			}
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Kind: ";
			str += "\n" + kind.toString(indent + 4);
			
			return str;
		}
		
	}
}
