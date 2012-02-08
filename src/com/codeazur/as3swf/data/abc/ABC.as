package com.codeazur.as3swf.data.abc
{
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - stickupkid@gmail.com
	 */
	public class ABC {
		
		public static function toStringCommon(name:String, indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + name + "] ";
		}
	}
}
