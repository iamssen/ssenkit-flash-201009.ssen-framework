package ssen.framework.widgets.scroll {
import ssen.framework.service.SimpleLauncher;
import ssen.framework.widgets.core.IWidget;

public class ScrollPaneTest extends SimpleLauncher {
	override protected function getApplication() : IWidget {
		return new App;
	}
}
}

import ssen.core.MathX;
import ssen.debug.TestButtonGroup;
import ssen.debug.TestContents;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.scroll.ScrollPane;

class App extends SpriteWidget {
	private var pane : ScrollPane;

	override protected function wregister() : void {
		pane = new ScrollPane();
		pane.construct();
		pane.setting_ScrollPane(sprite, -1, WidgetState.RUN, TestContents.getLineBox(), 400, 300);
		pane.register();
		pane.x = 10;
		pane.y = 10;
		
		var tb : TestButtonGroup = new TestButtonGroup("resize", resize, "deregister", deregister1, "register", register1);
		tb.x = 10;
		tb.y = 320;
		sprite.addChild(tb);
		
		addToService();
	}

	private function resize() : void {
		pane.width = MathX.rand(100, 500);
		pane.height = MathX.rand(100, 300);
	}

	private function deregister1() : void {
		pane.deregister();
	}

	private function register1() : void {
		pane.register();
	}
}
