package ssen.framework.widgets.scroll {
import ssen.framework.service.SimpleLauncher;
import ssen.framework.widgets.core.IWidget;

public class ScrollVerify extends SimpleLauncher {
	override protected function getApplication() : IWidget {
		return new Verify;
	}
}
}

import ssen.core.MathX;
import ssen.debug.TestButtonGroup;
import ssen.debug.tostr;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.scroll.Scroll;
import ssen.framework.widgets.scroll.ScrollDirection;
import ssen.framework.widgets.scroll.ScrollTrackMode;

import flash.events.Event;

class Verify extends SpriteWidget {
	private var scroll : Scroll;
	private var dummy : Dummy;

	override protected function wregister() : void {
		dummy = new Dummy();
		
		
		scroll = new Scroll();
		scroll.construct();
		scroll.setting_Scroll(sprite, -1, WidgetState.RUN, ScrollDirection.VERTICAL, 10, 200, dummy.min, dummy.max, dummy.total, dummy.pos, null, null, ScrollTrackMode.PAGE, false);
		
		scroll.addEventListener(Event.SCROLL, sc);
		
		str("setting 이후 아무 작업도 하지 않음");
		
		scroll.state = WidgetState.DISABLE;
		scroll.width = 30;
		scroll.height = 300;
		scroll.scrollPosition = 70;
		
		str("setting 이후 상태를 변환시킴");
		
		scroll.register();
		
		str("register 시킴");
		
		var tb : TestButtonGroup = new TestButtonGroup();
		tb.test("디레지스터 시킴", tderegister);
		tb.test("레지스터 시킴", tregister);
		tb.test("상태변화 시킴", treset);
		tb.test("언셋팅 이후 다시 셋팅", tunset);
		tb.test("스테이트를 변화", tstate);
		tb.x = 10;
		tb.y = 350;
		sprite.addChild(tb);
		
		addToService();
	}

	private function tstate() : void {
		scroll.state = MathX.rand(0, 1) > 0 ? WidgetState.RUN : WidgetState.DISABLE;
	}

	private function tunset() : void {
		if (scroll.registered) scroll.deregister();
		scroll.unsetting();
		
		str("unsetting 이후 상태");
		
		scroll.setting_Scroll(sprite, -1, WidgetState.DISABLE, ScrollDirection.HORIZONTAL, 200, 100, dummy.min, dummy.max, dummy.total, dummy.pos, null, null, ScrollTrackMode.PAGE, true);
		
		str("unsetting 이후 다시 setting");
		
		scroll.x = 0;
		scroll.y = 0;
		scroll.width = 300;
		scroll.height = 10;
		scroll.state = WidgetState.RUN;
		
		str("unsetting, setting 이후 상태 변환");
		
		scroll.register();
	}

	private function tregister() : void {
		scroll.register();
		str("register 됨");
	}

	private function treset() : void {
		scroll.state = WidgetState.RUN;
		scroll.x = 30;
		scroll.y = 30;
		scroll.width = 10;
		scroll.height = 150;
		str("상태변화 시킴");
	}

	private function tderegister() : void {
		scroll.deregister();
		str("deregister 됨");
	}

	private function sc(event : Event) : void {
		dummy.pos = scroll.scrollPosition;
	}

	private function str(msg : String) : void {
		trace(msg);
		tostr("scroll", {state:scroll.state, width:scroll.width, height:scroll.height, pos:scroll.scrollPosition, ratio:scroll.scrollPositionRatio}, true);
		tostr("dummy", {min:dummy.min, max:dummy.max, total:dummy.total, pos:dummy.pos}, true);
	}
}

class Dummy {
	public var min : Number = 10;
	public var max : Number = 1000;
	public var total : Number = 1100;
	public var pos : Number = 100;
}