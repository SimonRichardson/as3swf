package com.codeazur.as3swf.data.abc.utils
{
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getQualifiedNameFullName(ns:String, name:String):String {
		return (!StringUtils.isEmpty(ns) ? ns + NAMESPACE_SEPARATOR : "") + name;
	}
}
