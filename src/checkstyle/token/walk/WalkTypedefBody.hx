package checkstyle.token.walk;

import haxe.macro.Expr;
import haxeparser.Data.Token;
import haxeparser.Data.TokenDef;

import checkstyle.token.TokenStream;
import checkstyle.token.TokenStreamProgress;
import checkstyle.token.TokenTree;

class WalkTypedefBody {
	public static function walkTypedefBody(stream:TokenStream, parent:TokenTree) {
		if (stream.is(BrOpen)) {
			var openTok:TokenTree = stream.consumeTokenDef(BrOpen);
			parent.addChild(openTok);
			var progress:TokenStreamProgress = new TokenStreamProgress(stream);
			while (progress.streamHasChanged()) {
				switch (stream.token()) {
					case BrClose: break;
					default:
						WalkFieldDef.walkFieldDef(stream, openTok);
				}
				if (stream.is(BrClose)) break;
				WalkFieldDef.walkFieldDef(stream, openTok);
			}
			openTok.addChild(stream.consumeTokenDef(BrClose));
		}
		else WalkTypeNameDef.walkTypeNameDef(stream, parent);
	}
}