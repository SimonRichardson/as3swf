package com.codeazur.as3swf.data.abc.bytecode
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCMethodInfoFlags
	{
		
		public static const NEED_ARGUMENTS:ABCMethodInfoFlags = new ABCMethodInfoFlags(0x01);
		public static const NEED_ACTIVATION:ABCMethodInfoFlags = new ABCMethodInfoFlags(0x02);
		public static const NEED_REST:ABCMethodInfoFlags = new ABCMethodInfoFlags(0x04);
		public static const HAS_OPTIONAL:ABCMethodInfoFlags = new ABCMethodInfoFlags(0x08);
		public static const SET_DXNS:ABCMethodInfoFlags = new ABCMethodInfoFlags(0x40);
		public static const HAS_PARAM_NAMES:ABCMethodInfoFlags = new ABCMethodInfoFlags(0x80);

		private var _type:uint;

		public function ABCMethodInfoFlags(type:uint) {
			_type = type;
		}
		
		public static function isType(flag:uint, type:ABCMethodInfoFlags):Boolean {
			return ((flag & type._type) != 0); 
		}
		
	}
}
