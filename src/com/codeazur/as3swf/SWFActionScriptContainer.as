package com.codeazur.as3swf
{
	import com.codeazur.as3swf.events.SWFProgressEvent;
	import flash.events.Event;
	import com.codeazur.as3swf.data.abc.ABCData;
	import com.codeazur.as3swf.data.abc.ABCDataSet;
	import com.codeazur.as3swf.data.abc.io.ABCReader;
	import com.codeazur.as3swf.data.abc.io.ABCWriter;
	import com.codeazur.as3swf.data.abc.tools.ABCMerge;
	import com.codeazur.as3swf.data.abc.tools.ABCSortConstantPool;
	import com.codeazur.as3swf.data.abc.tools.IABCVistor;
	import com.codeazur.as3swf.tags.ITag;
	import com.codeazur.as3swf.tags.TagDoABC;

	import flash.display.Sprite;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class SWFActionScriptContainer extends SWFTimelineContainer {
		
		private var _abcTags:Vector.<TagDoABC>;
		private var _abcDataSet:ABCDataSet;
		
		private var _mergeTotal:int;
		private var _mergeTagIterator:int;
		
		private var _enterFrameProvider:Sprite;
		
		public function SWFActionScriptContainer() {
			_enterFrameProvider = new Sprite();
		}
		
		public function get mergeTotal():int { return _mergeTotal; }
		
		public function mergeABCTags():Boolean {
			initialiseMerge();
			
			if(_abcTags.length > 1) {
				while(--_mergeTagIterator > -1) {
					readABCTag();
				}
				mergeDataSet();
				writeDataSet();
			}
			
			const result:Vector.<ITag> = getTagsByClassType(TagDoABC);
			return result && result.length == _mergeTotal;
		}
		
		public function mergeABCTagsAsync():void {
			initialiseMerge();
			if(_abcTags.length > 1) {
				_enterFrameProvider.addEventListener(Event.ENTER_FRAME, readABCTagAsyncHandler);
			}
		}
		
		private function initialiseMerge():void {
			_abcTags = Vector.<TagDoABC>(getTagsByClassType(TagDoABC));
			
			_mergeTotal = _abcTags.length;
			_mergeTagIterator = _mergeTotal;
			
			_abcDataSet = new ABCDataSet();
		}
		
		private function readABCTag():void {
			const tag:TagDoABC = _abcTags[_mergeTagIterator];
			const tagIndex:int = tags.indexOf(tag);
			if(tagIndex > -1) {
				// Read the abc data via the reader
				const abcReader:ABCReader = new ABCReader(tag.bytes);
				const abcData:ABCData = new ABCData();
				abcReader.read(abcData);
				// We don't want to mess about with alchemy, so don't merge
				if(!abcData.methodBodySet.hasAlchemyOpcodes) {
					// We want the first TagDoABC
					if(_abcTags[0] != tag) {
						tags.splice(tagIndex, 1);
					}
					// Add it to the stack
					_abcDataSet.add(abcData);
				} else {
					_mergeTotal--;
				}
			} else {
				throw new Error("Invalid TagDoABC index");
			}
		}
		
		private function readABCTagAsyncHandler(event:Event):void {
			_enterFrameProvider.removeEventListener(Event.ENTER_FRAME, readABCTagAsyncHandler);
			if(--_mergeTagIterator > -1) {
				readABCTag();
				_enterFrameProvider.addEventListener(Event.ENTER_FRAME, readABCTagAsyncHandler);
			} else {
				_enterFrameProvider.addEventListener(Event.ENTER_FRAME, mergeDataSetAsyncHandler);
			}
		}
		
		private function mergeDataSet():void {
			// TODO : make this a much better async version
			// Merge the abc files into one.
			_abcDataSet.visit(new ABCMerge(_abcDataSet.abc));
			
			// Sort the resulting file.
			const sort:IABCVistor = new ABCSortConstantPool();
			sort.visit(_abcDataSet.abc);
		}
		
		private function mergeDataSetAsyncHandler(event:Event):void {
			_enterFrameProvider.removeEventListener(Event.ENTER_FRAME, mergeDataSetAsyncHandler);
			mergeDataSet();
			_enterFrameProvider.addEventListener(Event.ENTER_FRAME, writeDataSetAsyncHandler);
		}
		
		private function writeDataSet():void {
			// Write the merged files to onwe abc file
			const abcWriter:ABCWriter = new ABCWriter(_abcDataSet.abc);
			const bytes:SWFData = new SWFData();
			abcWriter.write(bytes);
			
			// Push the bytes on the first tag
			TagDoABC(_abcTags[0]).bytes = bytes;
		}
		
		private function writeDataSetAsyncHandler(event:Event):void {
			_enterFrameProvider.removeEventListener(Event.ENTER_FRAME, writeDataSetAsyncHandler);
			writeDataSet();
			dispatchEvent(new SWFProgressEvent(SWFProgressEvent.COMPLETE, _mergeTagIterator, _mergeTotal));
		}
	}
}
