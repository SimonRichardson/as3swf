package com.codeazur.utils
{
	import flash.utils.Dictionary;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class DictionaryUtils {
		
		public static function compare(d0 : Dictionary, d1 : Dictionary) : Boolean {
			if(d0 == d1){
				return true;
			} else if(d0 == null || d1 == null){
				return false;
			} else {
				var count0:uint = 0;
				for(var key:Object in d0)
				{
					if(d0[key] !== d1[key]) {
						return false;
					}	
					count0++;
				}
	
				var count1 : int = 0;
				for(key in d1){
					count1++;
				}
				return (count0 == count1);
			}
		}
	}
}
