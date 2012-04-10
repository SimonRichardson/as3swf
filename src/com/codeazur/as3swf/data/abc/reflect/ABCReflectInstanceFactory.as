package com.codeazur.as3swf.data.abc.reflect
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCMethodInfo;
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCReflectInstanceFactory {
		
		public static function create(instance:ABCInstanceInfo, 
									  methods:Vector.<ABCMethodInfo>,
									  getters:Vector.<ABCMethodInfo>,
									  setters:Vector.<ABCMethodInfo>):IABCReflectInstance {
			if(instance.isInterface) {
				return ABCReflectInterface.create(instance.multiname);
			} else {
				return ABCReflectClass.create(instance, methods, getters, setters);
			}
		}
	}
}
