package com.codeazur.as3swf.data.abc.exporters.js.builders
{

	import com.codeazur.as3swf.data.abc.exporters.builders.IABCValueBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCMatcher;
	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCTernaryBuilder;

	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSTernaryBuilder extends JSConsumableBlock implements IABCTernaryBuilder {
		
		public var matcher:IABCMatcher;
		
		public function JSTernaryBuilder() {
		}
		
		public static function create(matcher:IABCMatcher, left:IABCValueBuilder, right:IABCValueBuilder):JSTernaryBuilder {
			const builder:JSTernaryBuilder = new JSTernaryBuilder();
			builder.matcher = matcher;
			builder.left = left;
			builder.right = right;
			return builder;
		}
		
		override public function write(data:ByteArray):void {
			matcher.write(data);
			JSTokenKind.QUESTION_MARK.write(data);
			
			left.write(data);
			JSTokenKind.COLON.write(data);
			right.write(data);
			
			JSTokenKind.SEMI_COLON.write(data);
		}
		
		override public function get name():String { return "JSTernaryBuilder"; }
		
		override public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
