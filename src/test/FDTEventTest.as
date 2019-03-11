package test {
import flash.display.Sprite;

/**
 * @author ssen (i@ssen.name)
 */
public class FDTEventTest extends Sprite {
	public function FDTEventTest() {
		var disp : XDisp = new XDisp();
	}
}
}

import flash.events.EventDispatcher;

class XDisp extends EventDispatcher {

	[Event(name="change", type="flash.events.Event")]
	public function XDisp() {
		trace("???");
	}
}