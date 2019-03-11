package ssen.framework.widgets.panels {
import ssen.framework.service.SimpleLauncher;
import ssen.framework.widgets.core.IWidget;

[SWF(backgroundColor="#FFFFFF", frameRate="51", width="550", height="480")]

public class PanelTest extends SimpleLauncher {
	override protected function getApplication() : IWidget {
		return new App;
	}
}
}

import ssen.framework.service.SS;
import ssen.framework.widgets.btns.LableBtn;
import ssen.framework.widgets.btns.events.ClickEvent;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.panels.Alert;

import de.polygonal.ds.HashMap;

import flash.filters.BlurFilter;

class App extends SpriteWidget {
	private var opner : LableBtn;
	private var panel : Alert;

	override protected function wregister() : void {
		opner = new LableBtn();
		opner.construct();
		opner.setting_LableBtn(sprite, -1, WidgetState.RUN, "open panel");
		opner.register();
		opner.x = 10;
		opner.y = 10;
		opner.addEventListener(ClickEvent.CLICK, click);

		panel = new Alert();
		panel.construct();
		panel.setting_Alert("가나다라마바사아자차카타파하\nabcdefghiabcdefghi", "가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하", "OK", callback);

		addToService();

		SS.panel.open(panel);
	}

	private function callback(state : Boolean, value : HashMap = null) : void {
		trace(state, value);
	}

	override protected function run() : void {
		sprite.mouseEnabled = true;
		sprite.mouseChildren = true;
		sprite.filters = [];
	}

	override protected function disable() : void {
		sprite.mouseEnabled = false;
		sprite.mouseChildren = false;
		sprite.filters = [new BlurFilter()];
	}

	private function click(event : ClickEvent) : void {
		SS.panel.open(panel);
	}
}