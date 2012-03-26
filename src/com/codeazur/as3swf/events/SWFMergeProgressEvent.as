package com.codeazur.as3swf.events
{

	import flash.events.Event;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class SWFMergeProgressEvent extends Event
	{
		public static const MERGE_PROGRESS:String = "mergeProgress";
		public static const MERGE_COMPLETE:String = "mergeComplete";
		
		protected var processed:uint;
		protected var total:uint;
		
		public function SWFMergeProgressEvent(type:String, processed:uint, total:uint, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.processed = processed;
			this.total = total;
		}
		
		public function get progress():Number {
			return processed / total;
		}
		
		public function get progressPercent():Number {
			return Math.round(progress * 100);
		}
		
		override public function clone():Event {
			return new SWFMergeProgressEvent(type, processed, total, bubbles, cancelable);
		}
		
		override public function toString():String {
			return "[SWFMergeProgressEvent] processed: " + processed + ", total: " + total + " (" + progressPercent + "%)";
		}
	}
}
