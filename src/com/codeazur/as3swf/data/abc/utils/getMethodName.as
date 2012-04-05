package com.codeazur.as3swf.data.abc.utils
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getMethodName(value:String):String {
		const nsMethodIndex:int = value.lastIndexOf(NAMESPACE_METHOD_SEPARATOR);
		if(nsMethodIndex > 0) {
			const partial:String = value.substr(nsMethodIndex + 1);
			const nsIndex0:int = partial.lastIndexOf(NAMESPACE_SEPARATOR);
			if(nsIndex0 > 0) {
				return partial.substr(nsIndex0 + 1);
			}
			return partial;
		}
		const nsIndex1:int = value.lastIndexOf(NAMESPACE_SEPARATOR);
		if(nsIndex1 > 0) {
			return value.substr(nsIndex1 + 1);
		}
		return value;
	}
}
