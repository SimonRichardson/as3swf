package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCParameter {

		public var qname:IABCMultiname;
		public var optional:Boolean;
		public var optionalKind:ABCConstantKind;

		public var label : String;
		public var defaultValue : *;

		public function ABCParameter() {
			optional = false;
		}
		
		public static function create(qname:IABCMultiname):ABCParameter {
			const argument:ABCParameter = new ABCParameter();
			argument.qname = qname;
			return argument;
		}
		
		public function get name():String { return "ABCParameter"; }
		
		public function toString(indent:uint = 0) : String {
			var str:String = ABC.toStringCommon(name, indent);
			
			if(!StringUtils.isEmpty(label)) {
				str += "\n" + StringUtils.repeat(indent + 2) + "";
				str += "Label: " + label + "";
			}
			
			str += "\n" + StringUtils.repeat(indent + 2) + "";
			str += "QName: ";
			str += "\n" + qname.toString(indent + 4);
			
			if(optional) {
				str += "\n" + StringUtils.repeat(indent + 2) + "";
				str += "Optional: " + optional + "";
				str += "\n" + StringUtils.repeat(indent + 2) + "";
				str += "OptionalKind: ";
				str += "\n" + optionalKind.toString(indent + 4);
				str += "\n" + StringUtils.repeat(indent + 2) + "";
				str += "DefaultValue: " + defaultValue;
			}
			
			return str;
		}
	}
}
