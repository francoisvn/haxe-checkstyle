package checks;

import checkstyle.checks.AvoidStarImportCheck;

class AvoidStarImportCheckTest extends CheckTestCase<AvoidStarImportCheckTests> {

	static inline var MSG_STAR_IMPORT:String = 'Import line uses a star (.*) import - consider using full type names';

	public function testNoStarImport() {
		var check = new AvoidStarImportCheck();
		assertNoMsg(check, IMPORT);
	}

	public function testStarImport() {
		var check = new AvoidStarImportCheck();
		assertMsg(check, STAR_IMPORT, MSG_STAR_IMPORT);
		assertMsg(check, CONDITIONAL_STAR_IMPORT_ISSUE_160, MSG_STAR_IMPORT);
	}
}

@:enum
abstract AvoidStarImportCheckTests(String) to String {
	var IMPORT = "
	package haxe.checkstyle;

	import haxe.checkstyle.Check;
	import haxe.checkstyle.Check2;
	import haxe.checkstyle.Check3;

	using haxe.checkstyle.Check;

	class Test {
		public function new() {}
	}";

	var STAR_IMPORT = "
	package haxe.checkstyle;

	import haxe.checkstyle.*;
	import haxe.checkstyle.Check2;
	import haxe.checkstyle.Check3;

	using haxe.checkstyle.Check;

	class Test {
		public function new() {}
	}";

	var CONDITIONAL_STAR_IMPORT_ISSUE_160 = "
	#if macro
		import haxe.macro.*;
	#end";
}