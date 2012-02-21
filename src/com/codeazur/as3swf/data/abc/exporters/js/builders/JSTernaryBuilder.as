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
	public class JSTernaryBuilder implements IABCTernaryBuilder {
		
		public var matcher:IABCMatcher;
		
		public var expr0:IABCValueBuilder;
		public var expr1:IABCValueBuilder;
		
		public function JSTernaryBuilder() {
		}
		
		public static function create(matcher:IABCMatcher, expr0:IABCValueBuilder, expr1:IABCValueBuilder):JSTernaryBuilder {
			const builder:JSTernaryBuilder = new JSTernaryBuilder();
			builder.matcher = matcher;
			builder.expr0 = expr0;
			builder.expr1 = expr1;
			return builder;
		}
		
		public function write(data:ByteArray):void {
			matcher.write(data);
			JSTokenKind.QUESTION_MARK.write(data);
			expr0.write(data);
			JSTokenKind.COLON.write(data);
			expr1.write(data);
		}
		
		public function get name():String { return "JSTernaryBuilder"; }
		
		public function toString(indent:uint=0):String {
			return ABC.toStringCommon(name, indent);
		}
	}
}
