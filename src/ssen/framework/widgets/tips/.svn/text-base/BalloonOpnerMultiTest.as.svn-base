package ssen.framework.widgets.tips {
import ssen.framework.service.SimpleLauncher;
import ssen.framework.widgets.core.IWidget;

public class BalloonOpnerMultiTest extends SimpleLauncher {
	override protected function getApplication() : IWidget {
		return new App;
	}
}
}

import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.tips.BalloonOpner;

class App extends SpriteWidget {
	override protected function wregister() : void {
		var a : BalloonOpner = new BalloonOpner();
		var b : BalloonOpner = new BalloonOpner();
		a.construct();
		b.construct();
		a.setting_BalloonOpner(sprite);
		b.setting_BalloonOpner(sprite);
		a.x = 100;
		a.y = 10;
		b.x = 200;
		b.y = 10;
		a.register();
		b.register();
		
		addToService();
	}
}
