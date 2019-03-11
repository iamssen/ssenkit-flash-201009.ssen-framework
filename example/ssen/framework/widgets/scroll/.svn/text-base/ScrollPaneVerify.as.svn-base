package ssen.framework.widgets.scroll {
import ssen.framework.service.SimpleLauncher;
import ssen.framework.widgets.core.IWidget;

public class ScrollPaneVerify extends SimpleLauncher {
	override protected function getApplication() : IWidget {
		return new Verify;
	}
}
}

import ssen.core.MathX;
import ssen.debug.TestButtonGroup;
import ssen.debug.TestContents;
import ssen.debug.tostr;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.scroll.ScrollPane;

import flash.display.Bitmap;
import flash.display.BitmapData;

class Verify extends SpriteWidget {
	private var pane : ScrollPane;

	override protected function wregister() : void {
		pane = new ScrollPane();
		pane.construct();
		pane.setting_ScrollPane(sprite, -1, WidgetState.DISABLE, new Bitmap(new BitmapData(10, 10, false, 0)), 200, 150, true, true, 50, 50);
		
		str("setting 이후");
		
		pane.scrollV = 100;
		pane.scrollH = 10;
		pane.width = 400;
		pane.height = 80;
		pane.state = WidgetState.RUN;
		pane.x = 10;
		pane.y = 10;
		
		str("setting 이후 상태 변환");
		
		pane.register();
		
		str("register");
		
		var tb : TestButtonGroup = new TestButtonGroup();
		tb.test("디레지스터 시킴", tderegister);
		tb.test("레지스터 시킴", tregister);
		tb.test("상태변화 시킴", treset);
		tb.test("언셋팅 이후 다시 셋팅", tunset);
		tb.test("스테이트를 변화", tstate);
		tb.test("컨텐츠를 교체", tcontents);
		tb.x = 10;
		tb.y = 310;
		sprite.addChild(tb);
		
		addToService();
	}

	private function tcontents() : void {
		pane.content = TestContents.getLineBox();
		
		str("content 교체");
	}

	private function tstate() : void {
		pane.state = MathX.rand(0, 1) > 0 ? WidgetState.RUN : WidgetState.DISABLE;
		
		str("state 변환");
	}

	private function tunset() : void {
		if (pane.registered) pane.deregister();
		pane.unsetting();
		
		str("unsetting 이후 상태");
		
		pane.setting_ScrollPane(sprite, -1, WidgetState.DISABLE, TestContents.getLineBox(), 400, 300, false, true, 100, 100);
		
		str("unsetting 이후 다시 setting");
		
		pane.x = 0;
		pane.y = 0;
		pane.width = 300;
		pane.height = 200;
		pane.state = WidgetState.RUN;
		pane.scrollV = 500;
		pane.scrollH = 1000;
		
		str("unsetting, setting 이후 상태 변환");
		
		pane.register();
	}

	private function tregister() : void {
		pane.register();
		str("register 됨");
	}

	private function treset() : void {
		pane.state = WidgetState.RUN;
		pane.x = 30;
		pane.y = 30;
		pane.width = 210;
		pane.height = 150;
		str("상태변화 시킴");
	}

	private function tderegister() : void {
		pane.deregister();
		str("deregister 됨");
	}

	private function str(msg : String) : void {
		trace(msg);
		tostr("i", {state:pane.state, width:pane.width, height:pane.height, x:pane.x, y:pane.y}, true);
		tostr("v", {pos:pane.scrollV, min:pane.minScrollV, max:pane.maxScrollV, total:pane.totalScrollV}, true);
		tostr("h", {pos:pane.scrollH, min:pane.minScrollH, max:pane.maxScrollH, total:pane.totalScrollH}, true);
		trace("===========================================================");
	}
}