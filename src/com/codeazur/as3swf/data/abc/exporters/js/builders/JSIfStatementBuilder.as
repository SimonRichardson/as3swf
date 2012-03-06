package com.codeazur.as3swf.data.abc.exporters.js.builders
{

	import com.codeazur.as3swf.data.abc.ABC;
	import com.codeazur.as3swf.data.abc.bytecode.ABCOpcodeKind;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCIfStatementBuilder;
	import com.codeazur.as3swf.data.abc.exporters.builders.IABCIfStatementExpression;
	import com.codeazur.as3swf.data.abc.io.IABCWriteable;
	import com.codeazur.utils.StringUtils;

	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class JSIfStatementBuilder implements IABCIfStatementBuilder {

		public var kind:ABCOpcodeKind;
		public var statement:IABCWriteable;
		public var body:IABCWriteable;

		public function JSIfStatementBuilder() {
		}
		
		public static function create(kind:ABCOpcodeKind, statement:IABCWriteable, body:IABCWriteable):JSIfStatementBuilder {
			const builder:JSIfStatementBuilder = new JSIfStatementBuilder();
			builder.kind = kind;
			builder.statement = statement;
			builder.body = body;
			return builder;
		}

		public function write(data : ByteArray) : void {
			if(ABCOpcodeKind.isIfType(kind)) {
				JSReservedKind.IF.write(data);
			} else if(ABCOpcodeKind.isType(kind, ABCOpcodeKind.JUMP)) {
				if(statement && 
					(statement is IABCIfStatementExpression || 
					(statement is JSConsumableBlock && JSConsumableBlock(statement).left is IABCIfStatementExpression))) {
					JSReservedKind.ELSE.write(data);
					JSTokenKind.SPACE.write(data);
					JSReservedKind.IF.write(data);
				} else {
					JSReservedKind.ELSE.write(data);
				}
			}
			
			if(statement) {
				JSTokenKind.LEFT_PARENTHESES.write(data);
				statement.write(data);
				JSTokenKind.RIGHT_PARENTHESES.write(data);
			}
			
			JSTokenKind.LEFT_CURLY_BRACKET.write(data);
			
			if(body) {
				body.write(data);
			}
			
			JSTokenKind.RIGHT_CURLY_BRACKET.write(data);
		}

		public function get name() : String { return "JSIfStatementBuilder"; }
		
		public function toString(indent : uint = 0) : String {
			var str:String = ABC.toStringCommon(name, indent);
			
			str += "\n" + StringUtils.repeat(indent + 2) + "Statement:";
			str += "\n" + statement.toString(indent + 4);
			
			if(body) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Body:";
				str += "\n" + body.toString(indent + 4);
			}
			
			return str;
		}
	}
}
