package ssen.framework.widgets.btns {import ssen.framework.service.SimpleLauncher;import ssen.framework.widgets.core.IWidget;public class LableBtnMultilineTest extends SimpleLauncher {	override protected function getApplication() : IWidget {		return new App;	}}}import flashx.textLayout.factory.TruncationOptions;import ssen.framework.widgets.btns.LableBtn;import ssen.framework.widgets.core.SpriteWidget;class App extends SpriteWidget {	override protected function wregister() : void {		var btn : Button = new Button;		btn.construct();		btn.setting_LableBtn(sprite, -1, state, "button\nbutton button button", null, null, false, 100, 60);		btn.register();		addToService();	}}class Button extends LableBtn {	override protected function getTruncationOptions() : TruncationOptions {
		return new TruncationOptions("", 2);
	}
}