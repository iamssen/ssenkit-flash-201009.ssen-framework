package ssen.framework.widgets.btns {
import ssen.framework.service.SimpleLauncher;
import ssen.framework.widgets.core.IWidget;

public class BtnTest extends SimpleLauncher {
	override protected function getApplication() : IWidget {
		return new TestApp();
	}
}
}

import ssen.core.DisplayX;
import ssen.core.MathX;
import ssen.debug.TestButtonGroup;
import ssen.debug.tostr;
import ssen.framework.widgets.btns.Btn;
import ssen.framework.widgets.btns.LableBtn;
import ssen.framework.widgets.btns.SelectionBtnInteraction;
import ssen.framework.widgets.btns.ToggleBtnInteraction;
import ssen.framework.widgets.btns.events.ClickEvent;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.selection.ISelectionItem;
import ssen.framework.widgets.selection.SelectionGroup;
import ssen.framework.widgets.selection.events.SelectionEvent;
import ssen.framework.widgets.togglers.events.ToggleEvent;

internal class TestApp extends SpriteWidget {
	private var btn0 : Btn;
	private var btn1 : Btn;
	private var group : SelectionGroup;
	private var btn2 : LableBtn;
	private var btn3 : LableBtn;

	override protected function wregister() : void {
		var tb : TestButtonGroup = new TestButtonGroup("open alert", openAlert);
		tb.x = 10;
		tb.y = 10;
		sprite.addChild(tb);
		
		btn0 = new Btn();
		btn0.construct();
		btn0.setting_Btn(sprite, -1, WidgetState.RUN, 100, 30, null, null, 200, true, 1000);
		btn0.register();
		btn0.addEventListener(ClickEvent.CLICK, click);
		btn0.addEventListener(ClickEvent.DOUBLE_CLICK, dbclick);
		btn0.addEventListener(ClickEvent.LONG_DOWN, longDown);
		
		
		btn1 = new Btn();
		btn1.construct();
		btn1.setting_Btn(sprite, -1, WidgetState.RUN, 100, 30, null, new ToggleBtnInteraction(), 200, false, 4000, true);
		btn1.register();
		btn1.addEventListener(ToggleEvent.TOGGLE, toggle);
		
		trace(btn0.width, btn0.height, btn1.width, btn1.height);
		
		DisplayX.align([btn0, btn1], 10, 100);
		
		var f : int = -1;
		var sel : Btn;
		var sels : Array = [];
		group = new SelectionGroup(true);
		group.addEventListener(SelectionEvent.SELECTION, selection);
		while(++f < 8) {
			sel = MathX.rand(0, 1) > 0 ? new LableBtn() : new Btn();
			sel.construct();
			if (sel is LableBtn) {
				LableBtn(sel).setting_LableBtn(sprite, -1, WidgetState.RUN, "button" + f + "가나다라마바사아자차카타파하", null, null, MathX.rand(0, 1) > 0, 100, 30, null, new SelectionBtnInteraction(), 0, false, 0, false, group, MathX.rand(0, 1) > 0, {value:"test" + f});
			} else {
				sel.setting_Btn(sprite, -1, WidgetState.RUN, 100, 30, null, new SelectionBtnInteraction(), 0, false, 0, false, group, MathX.rand(0, 1) > 0, {value:"test" + f});
			}
			sel.register();
			group.addItem(sel);
			sels.push(sel);
		}
		
		DisplayX.align(sels, 10, 200);
		
		btn2 = new LableBtn();
		btn2.construct();
		btn2.setting_LableBtn(sprite, -1, WidgetState.RUN, "가나다라마바사아자차카타파하");
		btn2.register();
		
		btn3 = new LableBtn();
		btn3.construct();
		btn3.setting_LableBtn(sprite, -1, WidgetState.RUN, "가나다라마바사아자차카타파하", null, null, false);
		btn3.register();
		DisplayX.align([btn2, btn3], 10, 350);
		
		
		addToService();
	}

	private function longDown(event : ClickEvent) : void {
		trace(event);
	}

	private function dbclick(event : ClickEvent) : void {
		trace(event);
	}

	private function click(event : ClickEvent) : void {
		trace(event);
		btn1.state = btn1.state == WidgetState.DISABLE ? WidgetState.RUN : WidgetState.DISABLE;
		//btn1.toggle = !btn1.toggle;
//		btn1.setting(BtnConfig.getToggleSetting(false));
//		trace(btn1.toggle);
	}

	private function selection(event : SelectionEvent) : void {
		var list : Vector.<ISelectionItem> = event.selectionGroup.selectedItems();
		var f : int = -1;
		while(++f < list.length) {
			tostr(String(f), list[f].selectionValue, true);
		}
	}

	private function toggle(event : ToggleEvent) : void {
		trace(event);
	}

	private function openAlert() : void {
		trace("hello world");
	}
}
