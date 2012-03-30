package com.codeazur.as3swf.data.abc.utils
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getInstanceName(value:String):String {
		const index:int = value.lastIndexOf(NAMESPACE_SEPARATOR);
		return index > 0 ? value.substr(index + 1) : value;
	}
}
