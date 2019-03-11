package ssen.framework.widgets.btns {
import ssen.framework.service.SimpleLauncher;
import ssen.framework.widgets.core.IWidget;

public class BtnVerify extends SimpleLauncher {
	override protected function getApplication() : IWidget {
		return new Verify;
	}
}
}

import ssen.debug.TestButtonGroup;
import ssen.debug.tostr;
import ssen.framework.widgets.btns.LableBtn;
import ssen.framework.widgets.btns.ToggleBtnInteraction;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.core.WidgetState;

class Verify extends SpriteWidget {
	private var btn : LableBtn;

	//private var config : BtnConfig;
	override protected function wregister() : void {
		btn = new LableBtn();
		btn.construct();
		btn.setting_LableBtn(sprite, -1, WidgetState.RUN, "my btn, my btn, my btn", null, null, true, 100, 30, null, new ToggleBtnInteraction());
		
		btnstr(btn, "setting 이후 아무런 작동도 하지 않았을때");
		
		btn.state = WidgetState.DISABLE;
		btn.width = 200;
		btn.height = 100;
		btn.x = 10;
		btn.y = 10;
		btn.lableText = "가나다라마바사아자차카타파하아아아아아아아";
		btn.toggle = true;
		
		btnstr(btn, "setting 이후 상태들을 변화시킴");
		
		btn.register();
		
		btnstr(btn, "register 이후 상태");
		
		var tb : TestButtonGroup = new TestButtonGroup();
		tb.test("디레지스터 시킴", tderegister);
		tb.test("레지스터 시킴", tregister);
		tb.test("상태변화 시킴", treset);
		tb.test("언셋팅 이후 다시 셋팅", tunset);
		tb.x = 10;
		tb.y = 300;
		sprite.addChild(tb);
		
		addToService();
	}

	private function tunset() : void {
		if (btn.registered) btn.deregister();
		btn.unsetting();
		
		btnstr(btn, "unsetting 이후 상태");
		
		btn.setting_LableBtn(sprite, -1, WidgetState.RUN, "button", null, null, true, 300, 10);
		btn.x = 10;
		btn.y = 10;
		
		btnstr(btn, "unsetting 이후 다시 setting");
		
		btn.x = 20;
		btn.y = 0;
		btn.width = 200;
		btn.height = 20;
		btn.state = WidgetState.RUN;
		btn.toggle = true;
		btn.lableText = "new my text";
		
		btnstr(btn, "unsetting, setting 이후 상태 변환");
		
		btn.register();
	}

	private function tregister() : void {
		btn.register();
		btnstr(btn, "register 됨");
	}

	private function treset() : void {
		btn.state = WidgetState.RUN;
		btn.x = 30;
		btn.y = 30;
		btn.width = 50;
		btn.height = 20;
		btnstr(btn, "상태변화 시킴");
	}

	private function tderegister() : void {
		btn.deregister();
		btnstr(btn, "deregister 됨");
	}

	private function btnstr(btn : LableBtn, msg : String) : void {
		trace(msg);
		tostr(btn.toString(), {state:btn.state, width:btn.width, height:btn.height, toggle:btn.toggle, selection:btn.selection, value:btn.selectionValue, x:btn.x, y:btn.y, text:btn.lableText}, true);
	}
}
