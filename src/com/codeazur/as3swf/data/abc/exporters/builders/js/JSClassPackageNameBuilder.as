package com.codeazur.as3swf.data.abc.exporters.builders.js
{
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCNamespace;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCClassPackageNameBuilder;
	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSClassPackageNameBuilder implements IABCClassPackageNameBuilder {
		
		private var _qname:ABCQualifiedName;
		
		public function JSClassPackageNameBuilder() {
			
		}
		
		public static function create(qname:ABCQualifiedName):JSClassPackageNameBuilder {
			const builder:JSClassPackageNameBuilder = new JSClassPackageNameBuilder();
			builder.qname = qname;
			return builder; 
		}
		
		public function write(data:ByteArray):void {
			const ns:ABCNamespace = qname.ns;
			const nsValue:String = ns.value;
			const parts:Array = nsValue.split(".");
			const total:uint = parts.length;
			
			for(var i:uint=0; i<total; i++) {
				const pns:String = merge(parts, i + 1);
				
				JSReservedKind.VAR.write(data);
				JSTokenKind.SPACE.write(data);
				
				data.writeUTF(pns);
				
				JSTokenKind.EQUALS.write(data);
				
				data.writeUTF(pns);
				
				JSOperatorKind.LOGICAL_OR.write(data);
				JSLiteralKind.OBJECT.write(data);
				JSTokenKind.SEMI_COLON.write(data);
			}
		}
		
		private function merge(parts:Array, index:uint):String {
			return parts.slice(0, index).join(".");
		}

		public function get qname():ABCQualifiedName { return _qname; }
		public function set qname(value:ABCQualifiedName) : void { _qname = value; }
		
		public function get name():String { return "JSClassPackageNameBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
