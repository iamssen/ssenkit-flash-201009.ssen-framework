package test {
import flash.display.Sprite;

/**
 * @author ssen (i@ssen.name)
 */
public class ThrowTest extends Sprite {
	/**
	 * @throws
	 */
	public function ThrowTest() {
		var err : Err = new Err();
		try {
			err.err3();
		} catch (e : Error) {
			trace("???");
		} catch (e : Err1) {
			trace(e);
		} catch (e : Err2) {
			trace(e);
		} catch (e : Err3) {
			trace(e);
		} finally {
			trace("final");
		}
	}
}
}

class Err {
	public function err1() : void {
		throw new Err1();
	}

	public function err2() : void {
		throw new Err2();
	}

	public function err3() : void {
		throw new Err3();
	}
}

class Err1 extends Error {
	public function Err1() {
		super("err1");
	}
}

class Err2 extends Error {
	public function Err2() {
		super("err2");
	}
}

class Err3 extends Error {
	public function Err3() {
		super("err3");
	}
}