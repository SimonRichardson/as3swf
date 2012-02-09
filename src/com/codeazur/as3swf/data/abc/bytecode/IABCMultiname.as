package com.codeazur.as3swf.data.abc.bytecode
{
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public interface IABCMultiname
	{
		
		function get kind():ABCMultinameKind;
		function set kind(value:ABCMultinameKind):void;
		
		function get fullName():String;
		
		function toQualifiedName():ABCQualifiedName;
		
		function toString(indent:uint = 0):String;
	}
}
