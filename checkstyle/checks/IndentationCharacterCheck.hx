package checkstyle.checks;

import checkstyle.LintMessage.SeverityLevel;
import haxeparser.Data.Token;

@name("IndentationCharacter")
@desc("Checks indentation character (tab/space, default is tab)")
class IndentationCharacterCheck extends Check {

	public var severity:String = "WARNING";

	public var character:String = "tab";

	override function actualRun() {
		var re;
		var tab = (character == "tab");
		if (tab) {
			re = ~/^\t*(\S.*)?$/;
		}
		else {
			re = ~/^ *(\S.*)?$/;
		}
		for (i in 0 ... _checker.lines.length) {
			var line = _checker.lines[i];
			if (line.length > 0 && !re.match(line)) log('Wrong indentation character', i + 1, 1, Reflect.field(SeverityLevel, severity));
		}
	}
}