package com.codeazur.as3swf.data.abc.utils
{
	import com.codeazur.utils.StringUtils;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function normaliseName(value : String) : String {
		const separator : String = NAMESPACE_SEPARATOR;

		var result : String = "";

		if (!StringUtils.isEmpty(value)) {
			value = StringUtils.clean(value);
			value = value.replace(/ /g, '');
			value = value.replace(/::/g, separator);
			value = value.replace(/\./g, separator);
			value = value.replace(/\Anull(\Z|:)/g, '');
			value = value.replace(/\//g, separator);
			value = value.replace(/\A:/, '');

			result += value;
		}

		return result;
	}
}
