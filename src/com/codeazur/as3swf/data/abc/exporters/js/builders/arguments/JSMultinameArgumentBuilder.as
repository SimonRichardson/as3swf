package com.codeazur.as3swf.data.abc.exporters.js.builders.arguments
{
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedNameType;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCParameter;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMultinameAttributeBuilder;
	import com.codeazur.utils.StringUtils;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSMultinameArgumentBuilder implements IABCMultinameAttributeBuilder
	{
		
		private var _multiname:IABCMultiname;
		private var _argument:ABCParameter;

		public function JSMultinameArgumentBuilder() {
		}
		
		public static function create(multiname:IABCMultiname):JSMultinameArgumentBuilder {
			const builder:JSMultinameArgumentBuilder = new JSMultinameArgumentBuilder();
			builder.multiname = multiname;
			builder.argument = ABCParameter.create(multiname);
			return builder;
		}
		
		public function write(data:ByteArray):void {
			const qname:ABCQualifiedName = multiname.toQualifiedName();
			if(qname && ABCQualifiedNameType.isBuiltin(qname)) {
				data.writeUTF(qname.label);
			} else {
				data.writeUTF(multiname.fullName);
			}
		}
		
		public function get multiname():IABCMultiname { return _multiname; }
		public function set multiname(value:IABCMultiname):void { _multiname = value; }
		
		public function get argument():ABCParameter { return _argument; }
		public function set argument(value:ABCParameter) : void { _argument = value; }
		
		public function get name():String { return "JSMultinameArgumentBuilder"; }
		
		public function toString(indent:uint=0):String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Argument:";
			str += "\n" + argument.toString(indent + 4);
			
			return str;
		}
	}
}
