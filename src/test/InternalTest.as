package test {
import flash.display.Sprite;

/**
 * @author ssen (i@ssen.name)
 */
public class InternalTest extends Sprite {
	public function InternalTest() {
		var a : AAA = new AAA(new CCC());
		a.a();
		new CCC().c();
	}

	internal function b() : void {
		trace("b");
	}
}
}

class CCC {
	internal function c() : void {
		trace("CCC c");
	}
}

class AAA {
	private var _ccc : CCC;

	public function AAA(test : CCC) {
		_ccc = test;
	}

	internal function a() : void {
		trace("AAA a");
		trace(_ccc.c());
	}
}
