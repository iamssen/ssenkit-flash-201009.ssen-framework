package ssen.framework.widgets.input {
import ssen.framework.service.SimpleLauncher;
import ssen.framework.widgets.core.IWidget;

public class TextWidgetTest extends SimpleLauncher {
	override protected function getApplication() : IWidget {
		return new TestApp();
	}
}
}

import flashx.textLayout.edit.EditingMode;

import ssen.core.draw.material.IDrawMaterialSet;
import ssen.core.geom.Padding;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.input.TextArea;
import ssen.framework.widgets.scroll.Scroll;
import ssen.framework.widgets.scroll.ScrollDirection;
import ssen.styles.flour.scroll.FlourScrollStyleSet;

import flash.events.Event;
import flash.events.TextEvent;

class TestApp extends SpriteWidget {
	private var area : TextArea;
	private var area2 : TextArea2;

	override protected function wregister() : void {
		area = new TextArea();
		area.construct();
		area.setting_TextArea(sprite, -1, WidgetState.RUN, 200, 100, "", "test init text", null, new Padding(10, 10, 10, 10), 0xcccccc, EditingMode.READ_WRITE, true);
		area.x = 10;
		area.y = 10;
		area.register();
		
		area2 = new TextArea2();
		area2.construct();
		area2.setting_TextArea(sprite, -1, WidgetState.RUN, 200, 200, "", "test init text", null, new Padding(10, 10, 10, 10), 0xcccccc, EditingMode.READ_WRITE, true);
		area2.x = 10;
		area2.y = 120;
		area2.register();
		
		addToService();
	}

	private function link(event : TextEvent) : void {
		trace(event);
	}

	private function textInput(event : TextEvent) : void {
		trace(event);
	}

	private function change(event : Event) : void {
		trace(event);
	}

	private function scroll(event : Event) : void {
		//trace(txt.scrollH, txt.scrollV);
	}
}

class TextArea2 extends TextArea {
	/* *********************************************************************
	 * abstract 
	 ********************************************************************* */
	override protected function getHScrollHeight() : int {
		return 17;
	}

	override protected function getVScrollWidth() : int {
		return 17;
	}

	override protected function settingScrollH(scroll : Scroll, width : Number, trackMode : Boolean, trackHide : Boolean) : void {
		scroll.setting_Scroll(sprite, -1, state, ScrollDirection.HORIZONTAL, width, getHScrollHeight(), 0, 0, 0, 0, FlourScrollStyleSet.thumbH, FlourScrollStyleSet.trackH, trackMode, trackHide);
	}

	override protected function settingScrollV(scroll : Scroll, height : Number, trackMode : Boolean, trackHide : Boolean) : void {
		scroll.setting_Scroll(sprite, -1, state, ScrollDirection.VERTICAL, getVScrollWidth(), height, 0, 0, 0, 0, FlourScrollStyleSet.thumbV, FlourScrollStyleSet.trackV, trackMode, trackHide);
	}

	override protected function getScrollX() : IDrawMaterialSet {
		return FlourScrollStyleSet.trackX;
	}
}