package com.codeazur.as3swf.data.abc.exporters.builders
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCIfStatementType {
		
		public static const EQUAL:ABCIfStatementType = new ABCIfStatementType();
		public static const FALSE:ABCIfStatementType = new ABCIfStatementType();
		public static const NOT_EQUAL:ABCIfStatementType = new ABCIfStatementType();
		public static const NOT_GREATER_THAN:ABCIfStatementType = new ABCIfStatementType();
		public static const TRUE:ABCIfStatementType = new ABCIfStatementType();

		public function ABCIfStatementType(){
		}

		public static function equals(type0:ABCIfStatementType, type1:ABCIfStatementType):Boolean {
			return type0 == type1;
		}
	}
}
