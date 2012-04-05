package com.codeazur.as3swf.data.abc.utils
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getScopeName(value:String):String {
		const nsMethodIndex:int = value.indexOf(NAMESPACE_METHOD_SEPARATOR);
		if(nsMethodIndex > 0) {
			return value.substr(0, nsMethodIndex); 
		}
		const nsIndex:int = value.indexOf(NAMESPACE_SEPARATOR);
		if(nsIndex > 0) {
			return value.substr(0, nsIndex);
		}
		return ""; 
	}
}
