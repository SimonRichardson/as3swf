package com.codeazur.as3swf.data.abc.utils
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getClassFromInstance(object:Object):Class {
	    var type : Class = (object as Class) || (object.constructor as Class);
	    if (type == null) {
	        type = getDefinitionByName(getQualifiedClassName(object)) as Class;
	    }
	    return type;
	}
}
