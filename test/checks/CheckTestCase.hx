package checks;

import haxe.PosInfos;

import checkstyle.LintMessage;
import checkstyle.LintFile;
import checkstyle.reporter.IReporter;
import checkstyle.Checker;
import checkstyle.checks.Check;

class CheckTestCase<T:String> extends haxe.unit.TestCase {

	static inline var FILE_NAME:String = "Test.hx";

	var checker:Checker;
	var reporter:TestReporter;

	override public function setup() {}

	function assertMsg(check:Check, testCase:T, expected:String, ?defines:Array<Array<String>>, ?pos:PosInfos) {
		var re = ~/abstractAndClass ([a-zA-Z0-9]*)/g;
		if (re.match(testCase)) {
			actualAssertMsg(check, re.replace(testCase, "class $1"), expected, pos);
			actualAssertMsg(check, re.replace(testCase, "abstract $1(Int)"), expected, pos);
		}
		else actualAssertMsg(check, testCase, expected, defines, pos);
	}

	function assertNoMsg(check:Check, testCase:T, ?pos:PosInfos) {
		assertMsg(check, testCase, '', null, pos);
	}

	function actualAssertMsg(check:Check, testCase:String, expected:String, ?defines:Array<Array<String>>, ?pos:PosInfos) {
		var msg = checkMessage(testCase, check, defines);
		assertEquals(expected, msg, pos);
	}

	function checkMessage(src:String, check:Check, defines:Array<Array<String>>):String {
		// a fresh Checker and Reporter for every checkMessage
		// to allow multiple independant checkMessage calls in a single test
		checker = new Checker();
		reporter = new TestReporter();

		if (defines != null) checker.defineCombinations = defines;
		checker.addCheck(check);
		checker.addReporter(reporter);
		checker.process([{name:FILE_NAME, content:src, index:0}]);
		return reporter.message;
	}

	override public function tearDown() {
		checker = null;
		reporter = null;
	}
}

class TestReporter implements IReporter {

	public var message:String;

	public function new() {
		message = "";
	}

	public function start() {}

	public function finish() {}

	public function fileStart(f:LintFile) {}

	public function fileFinish(f:LintFile) {}

	public function addMessage(m:LintMessage) {
		message = m.message;
	}
}