package com.codeazur.as3swf.data.abc.bytecode
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCInstanceInfoFlags
	{
		
		public static const SEALED:ABCInstanceInfoFlags = new ABCInstanceInfoFlags(0x01);
		public static const FINAL:ABCInstanceInfoFlags = new ABCInstanceInfoFlags(0x02);
		public static const INTERFACE:ABCInstanceInfoFlags = new ABCInstanceInfoFlags(0x04);
		public static const PROTECTED:ABCInstanceInfoFlags = new ABCInstanceInfoFlags(0x08);

		private var _type:uint;

		public function ABCInstanceInfoFlags(type:uint) {
			_type = type;
		}
		
		public static function isType(flag:uint, type:ABCInstanceInfoFlags):Boolean {
			return ((flag & type._type) != 0); 
		}
		
	}
}
