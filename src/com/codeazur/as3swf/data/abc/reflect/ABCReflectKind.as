package com.codeazur.as3swf.data.abc.reflect
{

	import com.codeazur.as3swf.data.abc.ABC;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectKind {
		
		public static const CLASS:ABCReflectKind = new ABCReflectKind(0x01);
		public static const INTERFACE:ABCReflectKind = new ABCReflectKind(0x02);
		
		private var _type:int;

		public function ABCReflectKind(type:int){
			_type = type;
		}
		
		public static function isType(type:ABCReflectKind, kind:ABCReflectKind):Boolean {
			return type.type == kind.type;
		}
		
		public function get type():int { return _type; }
		public function get name():String { return "ABCReflectKind"; }
		
		public function toString(indent:uint = 0):String {
			return ABC.toStringCommon(name, indent) + 
				"Type: " + type;
		}
	}
}
