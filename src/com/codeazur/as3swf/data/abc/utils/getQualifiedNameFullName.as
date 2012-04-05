package com.codeazur.as3swf.data.abc.utils
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getQualifiedNameFullName(ns:String, name:String):String {
		return ns + NAMESPACE_SEPARATOR + name;
	}
}
