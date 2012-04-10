package com.codeazur.as3swf.data.abc.utils
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getMethodType(value:String):String {
		const regexp:RegExp = new RegExp(NAMESPACE_GET_OR_SET);
		if(regexp.exec(value)) {
			return value.substr(-3);
		}
		return "";
	}
}
