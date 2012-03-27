package com.codeazur.as3swf
{
	import com.codeazur.as3swf.events.SWFMergeProgressEvent;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCDataSet;
	import com.codeazur.as3swf.data.abc.io.ABCReader;
	import com.codeazur.as3swf.data.abc.io.ABCWriter;
	import com.codeazur.as3swf.data.abc.tools.ABCMerge;
	import com.codeazur.as3swf.data.abc.tools.ABCSortConstantPool;
	import com.codeazur.as3swf.data.abc.tools.IABCVistor;
	import com.codeazur.as3swf.tags.ITag;
	import com.codeazur.as3swf.tags.TagDoABC;

	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class SWFActionScriptContainer extends SWFTimelineContainer {
		
		private static const ABC_THRESHOLD:uint = 50;
		private static const TAG_DO_ABC_MERGE_NAME:String = "TagDoABCMerge";
		
		private var _abcTags:Vector.<TagDoABC>;
		private var _abcDataSets:Vector.<ABCDataSet>;
		
		private var _estimatedNumDataSet:int;
		private var _estimatedDataSetLength:int;
		
		private var _tmpIndex:int;
		private var _tmpTagsIndex:int;
		
		private var _timeout:int;
		
		public function SWFActionScriptContainer() {
		}
		
		private function initialiseMerge():void {
			clearTimeout(_timeout);
			
			_abcTags = Vector.<TagDoABC>(getTagsByClassType(TagDoABC));
			_abcDataSets = new Vector.<ABCDataSet>();
			
			const total:uint = _abcTags.length;
			const aboveThreshold:Boolean = total > ABC_THRESHOLD;
			_estimatedNumDataSet = aboveThreshold ? Math.ceil(Math.sqrt(total)) : total;
			_estimatedDataSetLength = aboveThreshold ? Math.ceil(total / _estimatedNumDataSet) : total;
		}
		
		public function mergeABCTags():Boolean {
			initialiseMerge();
			
			const total:uint = _abcTags.length;
			if(total > 1) {
				var index:int = total;
				while(--index > -1) {
					readABCTag(index);
				}
				const setsTotal:uint = _abcDataSets.length;
				index = setsTotal;
				while(--index > -1) {
					mergeDataSet(index);
				}
				index = setsTotal;
				while(--index > -1) {
					writeDataSet(index);
				}
			}
			
			const result:Vector.<ITag> = getTagsByClassType(TagDoABC);
			return result && result.length == _estimatedNumDataSet;
		}
		
		public function mergeABCTagsAsync():void {
			initialiseMerge();
			
			const total:uint = _abcTags.length;
			if(total > 1) {
				_tmpIndex = total;
				_timeout = setTimeout(readABCTagAsyncHandler, 1);
			}
		}
		
		private function readABCTag(index:uint):void {
			const tag:TagDoABC = _abcTags[(_abcTags.length - 1) - index];
			const tagIndex:int = tags.indexOf(tag);
			if(tagIndex > -1) {
				tags.splice(tagIndex, 1);
				// Read the abc data via the reader
				const abcReader:ABCReader = new ABCReader(tag.bytes);
				const abcData:ABCData = ABCData.create();
				abcReader.read(abcData);
				// Add abc data to the correct data set
				const abcDataSet:ABCDataSet = getAvailableABCDataSet();
				abcDataSet.add(abcData);
				_tmpTagsIndex = tagIndex;
			} else {
				throw new Error("Invalid TagDoABC index");
			}
			trace("READ", index, tag);
		}
		
		private function readABCTagAsyncHandler():void {
			if(--_tmpIndex > -1) {
				readABCTag(_tmpIndex);
				_timeout = setTimeout(readABCTagAsyncHandler, 1);
			} else {
				mergeDataSetAsync();
			}
		}
		
		private function mergeDataSet(index:uint):void {
			// TODO: split the merging of sets in async
			const abcDataSet:ABCDataSet = _abcDataSets[index];
			abcDataSet.visit(new ABCMerge(abcDataSet.abc));
			// Sort the constants pool
			//const sort:IABCVistor = new ABCSortConstantPool();
			//sort.visit(abcDataSet.abc);
			trace("MERGE", index);
		}
		
		private function mergeDataSetAsync():void {
			_tmpIndex = _abcDataSets.length;
			_timeout = setTimeout(mergeDataSetAsyncHandler, 1);
		}
		
		private function mergeDataSetAsyncHandler():void {
			if(--_tmpIndex > -1) {
				mergeDataSet(_tmpIndex);
				_timeout = setTimeout(mergeDataSetAsyncHandler, 1);
			} else {
				writeDataSetAsync();
			}
		}
		
		private function writeDataSet(index:uint):void {
			const abcDataSet:ABCDataSet = _abcDataSets[index];
			const abcWriter:ABCWriter = new ABCWriter(abcDataSet.abc);
			const bytes:SWFData = new SWFData();
			abcWriter.write(bytes);
			
			const tag:TagDoABC = TagDoABC.create(bytes, TAG_DO_ABC_MERGE_NAME + index);
			tags.splice(_tmpTagsIndex, 0, tag);
			trace("WRITE", index, tags.length);
		}
		
		private function writeDataSetAsync():void {
			_tmpIndex = _abcDataSets.length;
			_timeout = setTimeout(writeDataSetAsyncHandler, 1);
		}
		
		private function writeDataSetAsyncHandler():void {
			if(--_tmpIndex > -1) {
				writeDataSet(_tmpIndex);
				_timeout = setTimeout(writeDataSetAsyncHandler, 1);
			} else {
				trace("DONE");
				dispatchEvent(new SWFMergeProgressEvent(SWFMergeProgressEvent.MERGE_COMPLETE, 1, 1));
			}
		}
		
		private function getAvailableABCDataSet():ABCDataSet {
			var result:ABCDataSet;
			const total:uint = _abcDataSets.length;
			for(var i:uint=0; i<total; i++) {
				const abcDataSet:ABCDataSet = _abcDataSets[i];
				if(abcDataSet.length < _estimatedDataSetLength) {
					result = abcDataSet;
					break;
				}
			}
			if(!result) {
				result = new ABCDataSet();
				_abcDataSets.push(result);
			}
			return result;
		}
	}
}
