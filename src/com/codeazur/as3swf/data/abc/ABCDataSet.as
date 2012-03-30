package com.codeazur.as3swf.data.abc
{
	import com.codeazur.as3swf.data.abc.bytecode.ABCInstanceInfo;
	import com.codeazur.as3swf.data.abc.bytecode.IABCMultiname;
	import com.codeazur.as3swf.data.abc.tools.IABCVistor;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCDataSet {

		
		private var _abc:ABCData;
		private var _data:Vector.<ABCData>;
		
		public function ABCDataSet() {
			_abc = new ABCData();
			_data = new Vector.<ABCData>();
		}
		
		public function add(data:ABCData):ABCData {
			_data.push(data);
			return data;
		}
		
		public function getAt(index:uint):ABCData {
			return _data[index];
		}
		
		public function visit(vistor:IABCVistor):void {
			const total:uint = _data.length;
			if(total == 0) {
				throw new Error("Invalid ABCData");
			} else if(total == 1) {
				_abc = _data[0];
			} else {
				for(var i:uint=0; i<total; i++) {
					vistor.visit(_data[i]);
				}
			}
		}
		
		public function getInstanceInfoByMultiname(multiname:IABCMultiname):ABCInstanceInfo {
			var result:ABCInstanceInfo;
			
			const total:uint = _data.length;
			for(var i:uint=0; i<total; i++){
				const data:ABCData = _data[i];
				const info:ABCInstanceInfo = data.instanceInfoSet.getByMultiname(multiname);
				if(info){
					result = info;
					break;
				}
			}
			
			return result;
		}
		
		public function get abc():ABCData { return _abc; }
		public function get length():uint { return _data.length; }
	}
}
