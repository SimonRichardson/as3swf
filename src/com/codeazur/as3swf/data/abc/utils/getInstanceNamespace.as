package com.codeazur.as3swf.data.abc.utils
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getInstanceNamespace(value:String):String {
		const index:int = value.indexOf(NAMESPACE_SEPARATOR);
		return index > 0 ? value.substr(0, index) : value;
	}
}
