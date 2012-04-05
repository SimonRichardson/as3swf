package com.codeazur.as3swf.data.abc.reflect
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCConstantKind;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectParameter implements IABCReflectObject {

		private var _parameter:ABCParameter;

		public function ABCReflectParameter(parameter:ABCParameter) {
			_parameter = parameter;
		}
		
		public static function create(parameter:ABCParameter):ABCReflectParameter {
			return new ABCReflectParameter(parameter);
		}

		public function get label():String { return _parameter.label; }
		public function get optional():Boolean { return _parameter.optional; }
		public function get optionalKind():ABCConstantKind { return _parameter.optionalKind; }
		public function get defaultValue():* { return _parameter.defaultValue; }
		
		public function get multiname():IABCMultiname { return _parameter.multiname; }
		
		public function get name():String { return "ABCReflectParameter"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			const paramName:String = StringUtils.isEmpty(label) ? "no name" : label;
			str += "\n" + StringUtils.repeat(indent + 2) + "Label: " + paramName;
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Optional: " + optional;
			
			if(optional) {
				str += "\n" + StringUtils.repeat(indent + 2) + "OptionalKind:";
				str += "\n" + optionalKind.toString(indent + 4);
			}
			
			str += "\n" + StringUtils.repeat(indent + 2) + "DefaultValue:";
			str += "\n" + StringUtils.repeat(indent + 4) + defaultValue;
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Multiname:";
			str += "\n" + StringUtils.repeat(indent + 4) + multiname.fullPath;
						
			return str;
		}
	}
}
