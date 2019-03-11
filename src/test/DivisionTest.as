package test {
import flash.utils.getTimer;
import flash.display.Sprite;

/**
 * @author ssen (i@ssen.name)
 */
public class DivisionTest extends Sprite {
	public function DivisionTest() {
		var time : int = 100000000;
		var f : int;
		var d : Number;
		var t : int;
		
		t = getTimer();
		f = time;
		while (--f >= 0) {
			d = f * 0.5;
		}
		trace(getTimer() - t);
		
		t = getTimer();
		f = time;
		while (--f >= 0) {
			d = f >> 1;
		}
		trace(getTimer() - t);
		
		t = getTimer();
		f = time;
		while (--f >= 0) {
			d = f / 2;
		}
		trace(getTimer() - t);
		
		
	}
}
}
