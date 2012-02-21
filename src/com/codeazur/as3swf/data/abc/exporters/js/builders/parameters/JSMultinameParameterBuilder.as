package com.codeazur.as3swf.data.abc.exporters.js.builders.parameters
{
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCParameterBuilder;
	import com.codeazur.utils.StringUtils;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMultinameParameterBuilder implements IABCParameterBuilder
	{
		
		public var multiname:IABCMultiname;
		
		private var _parameter:ABCParameter;

		public function JSMultinameParameterBuilder() {
		}
		
		public static function create(multiname:IABCMultiname):JSMultinameParameterBuilder {
			const builder:JSMultinameParameterBuilder = new JSMultinameParameterBuilder();
			builder.multiname = multiname;
			builder.parameter = ABCParameter.create(multiname);
			return builder;
		}
		
		public function write(data:ByteArray):void {
			data.writeUTF(multiname.fullName);
		}
		
		public function get parameter():ABCParameter { return _parameter; }
		public function set parameter(value:ABCParameter) : void { _parameter = value; }
		
		public function get name():String { return "JSMultinameParameterBuilder"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Parameter:";
			str += "\n" + parameter.toString(indent + 4);
			
			return str;
		}
	}
}
