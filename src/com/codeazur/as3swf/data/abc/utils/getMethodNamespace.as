package com.codeazur.as3swf.data.abc.utils
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getMethodNamespace(value:String):String {
		const nsMethodIndex:int = value.lastIndexOf(NAMESPACE_METHOD_SEPARATOR);
		if(nsMethodIndex > 0) {
			const partial:String = value.substr(nsMethodIndex + 1);
			const nsIndex:int = partial.lastIndexOf(NAMESPACE_SEPARATOR);
			if(nsIndex > 0) {
				return partial.substr(0, nsIndex);
			}
			return "";
		}
		return "";
	}
}
