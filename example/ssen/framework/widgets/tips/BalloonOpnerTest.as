package ssen.framework.widgets.tips {
import ssen.framework.service.SimpleLauncher;
import ssen.framework.widgets.core.IWidget;

/**
 * @author ssen (i@ssen.name)
 */
public class BalloonOpnerTest extends SimpleLauncher {
	override protected function getApplication() : IWidget {
		return new Test;
	}
}
}

import ssen.framework.service.SS;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.tips.BalloonOpner;

class Test extends SpriteWidget {
	override protected function wregister() : void {
		var bal : BalloonOpner = new BalloonOpner();
		bal.construct();
		bal.setting_BalloonOpner(sprite);
		bal.register();
		bal.x = (SS.sw >> 1) - (bal.width >> 1);
		//bal.y = (SS.sh >> 1) - (bal.height >> 1);
		bal.y = SS.sh - 100;
		
		addToService();
	}
}