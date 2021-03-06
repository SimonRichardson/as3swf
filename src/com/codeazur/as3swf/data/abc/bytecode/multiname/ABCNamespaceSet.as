package com.codeazur.as3swf.data.abc.bytecode.multiname
{
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCSet;
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABCNamespaceSet extends ABCSet {
		
		public var namespaces : Vector.<ABCNamespace>;

		public function ABCNamespaceSet(abcData:ABCData = null) {
			super(abcData);
		}
		
		public static function create(namespaces:Vector.<ABCNamespace> = null):ABCNamespaceSet {
			const nsSet:ABCNamespaceSet = new ABCNamespaceSet();
			nsSet.namespaces = namespaces || new Vector.<ABCNamespace>();
			return nsSet; 
		}
		
		public function equals(namespaceSet:ABCNamespaceSet):Boolean {
			var result:Boolean = false;
			if(this == namespaceSet) {
				result = true;
			} else if(this.length == namespaceSet.length) {
				result = true;
				const total:uint = namespaces.length;
				for(var i:uint=0; i<total; i++) {
					const ns0:ABCNamespace = getAt(i);
					const ns1:ABCNamespace = namespaceSet.getAt(i);
					if(!ns0.equals(ns1)) {
						result = false;
						break;
					}
				}
			}
			return result;
		}
		
		public function getAt(index:uint):ABCNamespace {
			return namespaces[index];
		}
		
		override public function get name():String { return "ABCNamespaceSet"; }
		override public function get length():uint { return namespaces ? namespaces.length : 0; }
		
		override public function toString(indent:uint = 0) : String {
			var str:String = super.toString(indent);
			
			if(namespaces.length > 0) { 
				str += "\n" + StringUtils.repeat(indent + 2) + "NamespacePool:";
				for(var i:uint = 0; i < namespaces.length; i++) {
					str += "\n" + namespaces[i].toString(indent + 4);
				}
			}
			
			return str;
		}
	}
}
