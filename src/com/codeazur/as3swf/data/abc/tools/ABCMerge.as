package com.codeazur.as3swf.data.abc.tools
{
	import com.codeazur.as3swf.data.abc.ABCData;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCMerge implements IABCVistor {
		
		private var _abc:ABCData;
		
		public function ABCMerge(abc:ABCData) {
			_abc = abc;
		}

		public function visit(value:ABCData):void {
			_abc.minorVersion = value.minorVersion;
			_abc.majorVersion = value.majorVersion;
			
			_abc.constantPool.merge(value.constantPool);
						
			_abc.methodInfoSet.merge(value.methodInfoSet);
			_abc.metadataSet.merge(value.metadataSet);
			
			_abc.instanceInfoSet.merge(value.instanceInfoSet);
			_abc.classInfoSet.merge(value.classInfoSet);
			_abc.scriptInfoSet.merge(value.scriptInfoSet);
			
			_abc.methodBodySet.merge(value.methodBodySet);
		}
	}
}
