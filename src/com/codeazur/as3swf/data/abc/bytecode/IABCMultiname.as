package com.codeazur.as3swf.data.abc.bytecode
{
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCMultinameKind;
	import com.codeazur.as3swf.data.abc.bytecode.multiname.ABCQualifiedName;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public interface IABCMultiname
	{
		
		function get kind():ABCMultinameKind;
		function set kind(value:ABCMultinameKind):void;
		
		function get byte():int;
		function set byte(value:int):void;
		
		function get fullName():String;
		
		function toQualifiedName():ABCQualifiedName;
		
		function toString(indent:uint = 0):String;
	}
}
