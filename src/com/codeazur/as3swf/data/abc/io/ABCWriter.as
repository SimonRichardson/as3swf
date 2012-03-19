package com.codeazur.as3swf.data.abc.io
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.abc.ABCData;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCWriter {

		private var _data:ABCData;

		public function ABCWriter(data:ABCData) {
			_data = data;
		}

		public function write(bytes:SWFData):void {
			bytes.writeUI16(_data.minorVersion);
			bytes.writeUI16(_data.majorVersion);
			
			_data.constantPool.write(bytes);
			_data.methodInfoSet.write(bytes);
			_data.metadataSet.write(bytes);
			
			_data.instanceInfoSet.write(bytes);
			_data.classInfoSet.write(bytes);
			_data.scriptInfoSet.write(bytes);
			_data.methodBodySet.write(bytes);
		}
	}
}
