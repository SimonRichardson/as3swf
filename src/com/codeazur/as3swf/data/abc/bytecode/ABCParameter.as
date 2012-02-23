package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
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
		
		public static function create(qname:IABCMultiname, label:String = "", defaultValue:* = null):ABCParameter {
			const argument:ABCParameter = new ABCParameter();
			argument.qname = qname;
			argument.label = label;
			argument.defaultValue = defaultValue;
			return argument;
		}
		
		public function get name():String { return "ABCParameter"; }
		
		public function toString(indent:uint = 0) : String {
			var str:String = ABC.toStringCommon(name, indent);
			
			if(!StringUtils.isEmpty(label)) {
				str += "\n" + StringUtils.repeat(indent + 2) + "";
				str += "Label: " + label + "";
			}
			
			if(qname) {
				str += "\n" + StringUtils.repeat(indent + 2) + "QName: ";
				str += "\n" + qname.toString(indent + 4);
			}
			
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
