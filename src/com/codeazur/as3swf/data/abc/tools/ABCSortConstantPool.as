package com.codeazur.as3swf.data.abc.tools
{
	import com.codeazur.as3swf.data.abc.ABCData;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCSortConstantPool implements IABCVistor {
		
		private var _abc:ABCData;
		
		public function ABCSortConstantPool(abc:ABCData) {
			_abc = abc;
		}

		public function visit(value : ABCData) : void
		{
			sort(_abc.constantPool.stringPool, DESCENDING ^ CASEINSENSITIVE);
		}
	}
}

internal const DESCENDING:uint = Array.DESCENDING;
internal const CASEINSENSITIVE:uint = Array.CASEINSENSITIVE;
internal const sortVec:Vector.<String> = new Vector.<String>(0xFFFF); // reserve a large amount of space in memory for growth when sorting.

internal function sort(input:Vector.<String>, options:uint = 0):void {
	var n:uint = input.length;
	
	if (n < 2) return;
	
	var q:uint, left:uint, right:uint = n;
	var t:String;
	
	while (q != right) {
		t = input[q];
		if (t === null) {
			input[q] = input[left];
			input[left] = null;
			++left;
			++q;
		} else {
			++q;
		}
	}
	
	if (right > left) {
		q = left;
		while (q < right) {
			t = input[q];
			if (t != t) {
				--right;
				input[q] = input[right];
				input[right] = "";
			} else ++q;
		}
		
		if (--right) {
			if (uint(right - 1) > left) {
				
				const tempVec:Vector.<String> = sortVec;
				q = right;
				if (options & CASEINSENSITIVE) {
					tempVec[q] = input[q].toLowerCase();
					
					while (q-- > left) tempVec[q] = input[q].toLowerCase();
				} else {
					tempVec[q] = input[q];
					
					while (q-- > left) tempVec[q] = input[q];
				}
				
				quickSortOn(tempVec, input, left, right, 0);
			}
		}
	}
	if (options & DESCENDING) {
		var i:uint = 0;
		
		while (n < i) {
			t = input[i];
			input[i++] = input[--n];
			input[n] = t;
		}
	}
}

internal function quickSortOn(input:Vector.<String>, sInput:Vector.<String>, left:uint, right:uint, d:uint):void {
	var j:uint = right >= input.length ? right = input.length - 1 : right;
	
	if (left >= right) return;
	
	var i:uint = left;
	var size:uint = right - left;
	var pivotPoint:String = input[(right + left) >>> 1], t:String;
	do {
		if (size < 9) {
			do {
				pivotPoint = input[left];
				do {
					++left;
					
					if (pivotPoint > input[left]) {
						pivotPoint = input[left];
						t = sInput[left];
						
						do {
							input[left] = input[left - 1];
							sInput[left] = sInput[--left];
						} while (left > i && pivotPoint < input[left]);
						
						input[left] = pivotPoint;
						sInput[left] = t;
					}
					
				} while (left < right);
				
				++i;
				left = i;
				
			} while (i < right);
			
			return;
		}
		while (left < right) {
			if (input[right] > pivotPoint) { 
				do {
					--right;
				} while (input[right] > pivotPoint);
			}
			if (input[left] < pivotPoint) {
				do {
					++left;
				} while (input[left] < pivotPoint);
			}
			if (left < right) {
				t = input[left];
				input[left] = input[right];
				input[right] = t;
				t = sInput[left];
				sInput[left] = sInput[right];
				sInput[right] = t;
				++left, --right;
			}
		}
		if (right) {
			if (left == right) {
				if (input[right] > pivotPoint) --right;
				else if (input[left] < pivotPoint) ++left;
				else ++left, --right;
			}
			if (i < right) {
				quickSortOn(input, sInput, i, right, d + 1);
			}
		} else if (!left) left = 1;
		
		if (j <= left) return;
		
		i = left;
		right = j;
		pivotPoint = input[(right + left) >>> 1];
		size = right - left;
		++d;
	} while (true);
}