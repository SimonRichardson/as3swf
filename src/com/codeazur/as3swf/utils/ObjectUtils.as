package com.codeazur.as3swf.utils
{
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ObjectUtils {
		
		public static function toString(object:Object, indent:uint=0):String {
			var buffer:String = "";
        	for(var i:String in object) {
				buffer += StringUtils.repeat(indent + 2) + i + ":" + object[i] + "\n";
			}
			return buffer;
    	}
	}
}
