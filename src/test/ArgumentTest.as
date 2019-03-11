package test {
import flash.display.DisplayObject;
import flash.display.Sprite;

/**
 * @author ssen (i@ssen.name)
 */
public class ArgumentTest extends Sprite {
	public function ArgumentTest() {
		a();
		a(null, null, new Sprite());
	}

	private function a(a : int = 100, b : String = "aaaa", c : DisplayObject = null) : void {
		trace(a, b, c);
	}
}
}
