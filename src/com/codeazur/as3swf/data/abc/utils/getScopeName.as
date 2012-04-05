package com.codeazur.as3swf.data.abc.utils
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getScopeName(value:String):String {
		const index:int = value.indexOf(NAMESPACE_METHOD_SEPARATOR);
		if(index > 0) {
			return value.substr(0, index); 
		}
		return ""; 
	}
}
