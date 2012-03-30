package com.codeazur.as3swf.data.abc.utils
{
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function normaliseInstanceName(...rest):String {
		var result:String = "";
		
		const separator:String = NAMESPACE_SEPARATOR;
		
		const total:uint = rest.length;
		for(var i:uint=0; i<total; i++) {
			var value:String = rest[i];
			
			value = StringUtils.clean(value);
			value = value.replace(/ /g, '');
			value = value.replace(/\./g, separator);
			value = value.replace(/\Anull(\Z|:)/g, '');
			value = value.replace(/\//g, separator);
			value = value.replace(/\A:/, '');
			
			if(i < total - 1) {
				value += separator;
			}
			
			result += value;
		}
		
		result = result.replace(/\Anull(\Z|:)/g, '');
		result = result.replace(/\A:/, '');
		
		return result;
	}
}
