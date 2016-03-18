package checks.whitespace;

import checkstyle.checks.whitespace.OperatorWhitespaceCheck;

class OperatorWhitespaceCheckTest extends CheckTestCase<OperatorWhitespaceCheckTests> {

	static inline var MSG_EQUALS:String = 'OperatorWhitespace policy "around" violated by "="';
	static inline var MSG_EQUALS_BEFORE:String = 'OperatorWhitespace policy "before" violated by "="';
	static inline var MSG_EQUALS_AFTER:String = 'OperatorWhitespace policy "after" violated by "="';
	static inline var MSG_UNARY_NONE:String = 'OperatorWhitespace policy "none" violated by "++"';
	static inline var MSG_UNARY_INNER:String = 'OperatorWhitespace policy "inner" violated by "++"';
	static inline var MSG_INTERVAL_NONE:String = 'OperatorWhitespace policy "none" violated by "..."';
	static inline var MSG_INTERVAL_AROUND:String = 'OperatorWhitespace policy "around" violated by "..."';

	public function testCorrectOperatorWhitespace() {
		var check = new OperatorWhitespaceCheck();
		assertNoMsg(check, CORRECT_WHITESPACE_AROUND);
		assertNoMsg(check, ISSUE_70);
		assertNoMsg(check, ISSUE_71);
		assertNoMsg(check, ISSUE_72);
		assertNoMsg(check, ISSUE_77);
		assertNoMsg(check, ISSUE_80);
		assertNoMsg(check, ISSUE_81);
		assertNoMsg(check, ISSUE_98);
		assertNoMsg(check, MINUS_CONSTANT);
		assertNoMsg(check, CONDITIONAL_STAR_IMPORT_ISSUE_160);
		assertNoMsg(check, CONDITIONAL_ELSE_STAR_IMPORT);
		assertNoMsg(check, CONDITIONAL_ELSEIF_STAR_IMPORT);
		assertNoMsg(check, NEGATIVE_VARS);
		assertNoMsg(check, NEGATIVE_NUMS);
		assertNoMsg(check, OPGT);
	}

	public function testIncorrectOperatorWhitespaceToken() {
		var check = new OperatorWhitespaceCheck();
		assertMsg(check, ISSUE_59, MSG_EQUALS);
		assertMsg(check, ISSUE_63, MSG_EQUALS);
		assertMsg(check, NO_WHITESPACE_GT, MSG_EQUALS);
		assertMsg(check, NO_WHITESPACE_OBJECT_DECL, MSG_EQUALS);
		assertMsg(check, NO_WHITESPACE_TYPEDEF, MSG_EQUALS);
		assertMsg(check, NO_WHITESPACE_VAR_INIT, MSG_EQUALS);

		assertNoMsg(check, CORRECT_WHITESPACE_AROUND);
	}

	public function testWhitespaceBefore() {
		var check = new OperatorWhitespaceCheck();
		check.assignOpPolicy = BEFORE;
		assertNoMsg(check, ISSUE_63);
		assertNoMsg(check, NO_WHITESPACE_TYPEDEF);

		assertMsg(check, CORRECT_WHITESPACE_AROUND, MSG_EQUALS_BEFORE);
		assertMsg(check, ISSUE_59, MSG_EQUALS_BEFORE);
		assertMsg(check, NO_WHITESPACE_GT, MSG_EQUALS_BEFORE);
		assertMsg(check, NO_WHITESPACE_OBJECT_DECL, MSG_EQUALS_BEFORE);
		assertMsg(check, NO_WHITESPACE_VAR_INIT, MSG_EQUALS_BEFORE);
	}

	public function testWhitespaceAfter() {
		var check = new OperatorWhitespaceCheck();
		check.assignOpPolicy = AFTER;
		assertNoMsg(check, NO_WHITESPACE_GT);

		assertMsg(check, ISSUE_63, MSG_EQUALS_AFTER);
		assertMsg(check, NO_WHITESPACE_TYPEDEF, MSG_EQUALS_AFTER);
		assertMsg(check, CORRECT_WHITESPACE_AROUND, MSG_EQUALS_AFTER);
		assertMsg(check, ISSUE_59, MSG_EQUALS_AFTER);
		assertMsg(check, NO_WHITESPACE_OBJECT_DECL, MSG_EQUALS_AFTER);
		assertMsg(check, NO_WHITESPACE_VAR_INIT, MSG_EQUALS_AFTER);
	}

	public function testStarImport() {
		var check = new OperatorWhitespaceCheck();
		assertNoMsg(check, ISSUE_70);
		assertNoMsg(check, CONDITIONAL_STAR_IMPORT_ISSUE_160);
		assertNoMsg(check, CONDITIONAL_ELSE_STAR_IMPORT);
		assertNoMsg(check, CONDITIONAL_ELSEIF_STAR_IMPORT);
	}

	public function testUnary() {
		var check = new OperatorWhitespaceCheck();

		assertNoMsg(check, UNARY_NO_WHITESPACE);
		assertMsg(check, UNARY_INNER_WHITESPACE, MSG_UNARY_NONE);

		check.unaryOpPolicy = INNER;
		assertMsg(check, UNARY_NO_WHITESPACE, MSG_UNARY_INNER);
		assertNoMsg(check, UNARY_INNER_WHITESPACE);
	}

	public function testInterval() {
		var check = new OperatorWhitespaceCheck();

		assertNoMsg(check, INTERVAL_NO_WHITESPACE);
		assertMsg(check, INTERVAL_WHITESPACE, MSG_INTERVAL_NONE);

		check.intervalOpPolicy = AROUND;
		assertMsg(check, INTERVAL_NO_WHITESPACE, MSG_INTERVAL_AROUND);
		assertNoMsg(check, INTERVAL_WHITESPACE);
	}

	public function testIgnore() {
		var check = new OperatorWhitespaceCheck();
		check.assignOpPolicy = IGNORE;
		check.unaryOpPolicy = IGNORE;
		check.intervalOpPolicy = IGNORE;

		assertNoMsg(check, CORRECT_WHITESPACE_AROUND);
		assertNoMsg(check, ISSUE_70);
		assertNoMsg(check, ISSUE_71);
		assertNoMsg(check, ISSUE_72);
		assertNoMsg(check, ISSUE_77);
		assertNoMsg(check, ISSUE_80);
		assertNoMsg(check, ISSUE_81);
		assertNoMsg(check, ISSUE_98);
		assertNoMsg(check, MINUS_CONSTANT);
		assertNoMsg(check, CONDITIONAL_STAR_IMPORT_ISSUE_160);
		assertNoMsg(check, CONDITIONAL_ELSE_STAR_IMPORT);
		assertNoMsg(check, CONDITIONAL_ELSEIF_STAR_IMPORT);
		assertNoMsg(check, NEGATIVE_VARS);
		assertNoMsg(check, NEGATIVE_NUMS);
		assertNoMsg(check, OPGT);
		assertNoMsg(check, ISSUE_59);
		assertNoMsg(check, ISSUE_63);
		assertNoMsg(check, NO_WHITESPACE_GT);
		assertNoMsg(check, NO_WHITESPACE_OBJECT_DECL);
		assertNoMsg(check, NO_WHITESPACE_TYPEDEF);
		assertNoMsg(check, NO_WHITESPACE_VAR_INIT);
		assertNoMsg(check, UNARY_NO_WHITESPACE);
		assertNoMsg(check, UNARY_INNER_WHITESPACE);
		assertNoMsg(check, INTERVAL_NO_WHITESPACE);
		assertNoMsg(check, INTERVAL_WHITESPACE);
	}
}

@:enum
abstract OperatorWhitespaceCheckTests(String) to String {
	var CORRECT_WHITESPACE_AROUND = "
	import haxe.macro.*;

	class Test {
		function test(param1:String, param2:String) {
			var x = { x: 100, y: 100,
				z: 20 * 10
			};
			var y:Array<String> = [];
		}
	}

	typedef Test = {
		x:Int,
		y:Int, z:Int
	}

	enum Test {
		Monday;
		Tuesday;
		Wednesday;
		Thursday;
		Friday; Weekend(day:String);
	}";

	var NO_WHITESPACE_OBJECT_DECL = "
	class Test {
		function test(param1:String, param2:String) {
			var x={ x: 100, y: 100,z: 20 };
		}
	}";

	var NO_WHITESPACE_TYPEDEF = "
	typedef Test ={
		x:Int,
		y:Int,z:Int
	}";

	var NO_WHITESPACE_VAR_INIT = "
	class Test {
		function test(param1:String, param2:String) {
			var test:Array<String>=[];
		}
	}";

	var NO_WHITESPACE_GT = "
	class Test {
		function test(param1:String, param2:String) {
			var test:Array<String>= [];
		}
	}";

	var ISSUE_58 = "
	class Test {
		public function new() {
			var x:Int, y:Int;
		}
	}";

	var ISSUE_59 = "
	typedef Test=Int
	";

	var ISSUE_63 = "
	typedef Test =#if true Int #else String #end
	";

	var ISSUE_70 = "
		import haxe.macro.*;
	";

	var ISSUE_71 = "
		class Test {
		function foo<T, X>() {
			trace((null : Array<Int, String>));
		}
	}";

	var ISSUE_72 = "
	abstract Test<T>(Array<T>) {}
	";

	var ISSUE_77 = "
	// comment
	class Test // comment
	{ // comment
		function foo() // comment
		{ // comment
			switch ('Test') // comment
			{ // comment
			} // comment
		} // comment
	} // comment
	";

	var ISSUE_80 = "
	interface Test implements Dynamic {}
	";

	var ISSUE_81 = "
	class Test {
		function foo() {
			do a++ while (true);
			do ++a while (true);
		}
	}";

	var ISSUE_98 = "
	class Test {
		// °öäüßÖÄÜ@łĸŋđđðſðæµ”“„¢«»Ø→↓←Ŧ¶€Ł}][{¬½¼³²
		var test:Int = 0;
	}";

	var MINUS_CONSTANT = "
	class Test {
		function test() {
			if (re.match(line) && line.indexOf('//') == -1) {
				log('Tab after non-space character, Use space for aligning', i + 1, line.length, null, Reflect.field(SeverityLevel, severity));
				return -1;
			}
			a = 1 - -2;
			b = 1.2 - -2.1;
			return -1;
		}
	}";

	var CONDITIONAL_STAR_IMPORT_ISSUE_160 = "
	#if macro
		import haxe.macro.*;
	#end";

	var CONDITIONAL_ELSEIF_STAR_IMPORT = "
	#if macro
		import haxe.macro.Type;
	#elseif neko
		import haxe.macro.*;
	#elseif neko
		import haxe.macro.*;
	#else
		#if linux
			import haxe.macro.Type;
		#else
			import haxe.macro.*;
		#end
	#end
	import haxe.macro.Type;";

	var CONDITIONAL_ELSE_STAR_IMPORT = "
	#if macro
		import haxe.macro.Type;
	#else
		import haxe.macro.*;
	#end
	import haxe.macro.Type;";

	var NEGATIVE_VARS = "
	class Test {
		function test() {
			var rest = if (neg) { -noFractions; }
			else { -noFractions; }
			var rest = if (neg) -noFractions;
			else -noFractions;
			var x = neg ? -frag : -frag;
			calc ([-width, -node.right, root], -node.left, {x : -x, y: -y});
			(-a);
			(1 * -a);
			do -a * 2 while(true);
			for (a in [-1, -2]) -a + 2;
			return -a;
		}
	}";

	var NEGATIVE_NUMS = "
	class Test {
		function test() {
			var rest = if (neg) { -8; }
			else { -9; }
			var rest = if (neg) -10;
			else -11;
			var x = neg ? -12 : -13;
			calc ([-14, -node.right, root], -node.left, {x : -xi15x, y: -16});
			(-16);
			(1 * -17);
			do -18 * 2 while(true);
			for (a in [-1, -2]) -18 + 2;
		}
	}";

	var OPGT = "
	class Test {
		function test() {
			if (a > b) return a >= b;
			if (a >> b > c) return a >>= b;
			if (a >>> b > c) return a >>>= b;
		}
	}";

	var UNARY_NO_WHITESPACE = "
	class Test {
		function test() {
			if (!test) return a++;
			++a;
		}
	}";

	var UNARY_INNER_WHITESPACE = "
	class Test {
		function test() {
			if (! test) return a ++;
			++ a;
		}
	}";

	var INTERVAL_NO_WHITESPACE = "
	class Test {
		function test() {
			for (i in 0...100) trace(i);
			for (i in a...b) trace(i);
		}
	}";

	var INTERVAL_WHITESPACE = "
	class Test {
		function test() {
			for (i in 0 ... 100) trace(i);
			for (i in a ... b) trace(i);
		}
	}";
}