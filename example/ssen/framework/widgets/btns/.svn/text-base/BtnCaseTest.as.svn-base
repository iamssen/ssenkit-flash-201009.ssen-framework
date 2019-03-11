package ssen.framework.widgets.btns {
import ssen.framework.service.SimpleLauncher;
import ssen.framework.widgets.core.IWidget;

public class BtnCaseTest extends SimpleLauncher {
	override protected function getApplication() : IWidget {
		return new Case;
	}
}
}

import ssen.debug.autocase.AutoCase;
import ssen.debug.autocase.CaseState;
import ssen.debug.autocase.ICaseCommand;
import ssen.debug.autocase.RandomInt;
import ssen.framework.widgets.btns.Btn;
import ssen.framework.widgets.btns.events.ClickEvent;
import ssen.framework.widgets.core.IWidget;
import ssen.framework.widgets.core.WidgetState;

class Case extends AutoCase {
	override protected function getWidget() : IWidget {
		return new Btn();
	}

	override protected function setWidget(widget : IWidget) : void {
		var btn : Btn = Btn(widget);
		btn.setting_Btn(sprite, 0, WidgetState.RUN);
	}

	override protected function getSettedTimeCommand() : Vector.<ICaseCommand> {
		var cmds : Vector.<ICaseCommand> = new Vector.<ICaseCommand>();
		cmds.push(new CaseState("x", new RandomInt(10, 300)));
		cmds.push(new CaseState("y", new RandomInt(10, 300)));
		cmds.push(new CaseState("width", new RandomInt(30, 100)));
		cmds.push(new CaseState("height", new RandomInt(30, 100)));
		return cmds;
	}

	override protected function getRegisteredTimeCommand() : Vector.<ICaseCommand> {
		var cmds : Vector.<ICaseCommand> = new Vector.<ICaseCommand>();
		return cmds;
	}

	override protected function getInteractions() : Vector.<String> {
		var intrs : Vector.<String> = new Vector.<String>();
		intrs.push(ClickEvent.CLICK, ClickEvent.DOUBLE_CLICK, ClickEvent.LONG_DOWN);
		return intrs;
	}

	override protected function traceState() : void {
		str("btn state", ["width", "height", "toggle", "selection", "selectionValue", "x", "y"]);
	}
}
