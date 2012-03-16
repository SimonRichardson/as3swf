package com.codeazur.as3swf.data.abc
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCDataSet {

		private var _data:Vector.<ABCData>;

		public function ABCDataSet() {
			_data = new Vector.<ABCData>();
		}
		
		public function add(data:ABCData):ABCData {
			_data.push(data);
			return data;
		}
		
		public function getAt(index:uint):ABCData {
			return _data[index];
		}

		public function merge():ABCData {
			var result:ABCData;
			
			const total:uint = _data.length;
			if(total == 0) {
				result = null;
			} else if(total == 1) {
				result = _data[0];
			} else {
				
				const data:ABCData = new ABCData();
				for(var i:uint=0; i<total; i++) {
					mergeABCData(data, _data[i]);
				}
				
				result = data;
			}
			
			return result;
		}
		
		private function mergeABCData(master:ABCData, value:ABCData):void {
			master.minorVersion = value.minorVersion;
			master.majorVersion = value.majorVersion;
			
			trace(master.minorVersion, master.majorVersion);
			
			master.constantPool.merge(value.constantPool);
			
			master.methodInfoSet.merge(value.methodInfoSet);
			master.metadataSet.merge(value.metadataSet);
			
			master.instanceInfoSet.merge(value.instanceInfoSet);
			master.classInfoSet.merge(value.classInfoSet);
			master.scriptInfoSet.merge(value.scriptInfoSet);
			
			master.methodBodySet.merge(value.methodBodySet);
		}
		
		public function get length():uint { return _data.length; }
	}
}
