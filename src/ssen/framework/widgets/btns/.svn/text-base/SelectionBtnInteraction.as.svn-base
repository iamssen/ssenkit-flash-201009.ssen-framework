package ssen.framework.widgets.btns {
import ssen.framework.errors.ValueUnMatchError;
import ssen.framework.ss_internal;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.selection.SelectionGroup;

import flash.events.MouseEvent;

use namespace ss_internal;

/**
 * Selector 에 사용되는 Button Interaction
 * @see ssen.framework.widgets.selection.ISelectionItem
 * @see ssen.framework.widgets.selection.SelectionGroup
 * @author ssen (i@ssen.name)
 */
public class SelectionBtnInteraction extends BtnInteraction {
	private var _selection : Boolean;
	private var _selectionGroup : SelectionGroup;
	private var _value : Object;

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	/** @private */
	override protected function wsetting(config : Array) : void {
		var cfg : Array = config[1];
		if (!cfg[8]) throw new ValueUnMatchError("config 에 SelectionGroup 정보가 있어야 함");
		_selectionGroup = cfg[8];
		_selection = cfg[9];
		_value = cfg[10];
		super.wsetting(config);
	}

	/** @private */
	override protected function wunsetting() : void {
		_selectionGroup = null;
		_value = null;
		super.wunsetting();
	}

	/* *********************************************************************
	 * implement btn interaction 
	 ********************************************************************* */
	/** @private */
	override ss_internal function get drawState() : String {
		if (state == WidgetState.RUN && selection) {
			return "selected";
		} else {
			return state;
		}
	}

	/** @private */
	override protected function interactionOnOff() : void {
		if (state == WidgetState.DISABLE || (selection && !_selectionGroup.multiSelection)) {
			eventOff();
		} else {
			eventOn();
		}
	}

	/** @private */
	override protected function eventOn() : void {
		_sprite.mouseEnabled = true;
		_sprite.buttonMode = true;
		_sprite.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		_sprite.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		_sprite.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		_sprite.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		_sprite.addEventListener(MouseEvent.CLICK, click);
	}

	/** @private */
	override protected function eventOff() : void {
		_sprite.mouseEnabled = false;
		_sprite.buttonMode = false;
		_sprite.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		_sprite.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		_sprite.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		_sprite.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		_sprite.removeEventListener(MouseEvent.CLICK, click);
	}

	/* *********************************************************************
	 * interaction
	 ********************************************************************* */
	private function click(event : MouseEvent) : void {
		_selectionGroup.selection(_button, !_selection);
	}

	private function mouseUp(event : MouseEvent) : void {
		drawDefaultAction();
	}

	private function mouseDown(event : MouseEvent) : void {
		setDrawAction("down");
	}

	private function mouseOut(event : MouseEvent) : void {
		setDrawAction("default");
	}

	private function mouseOver(event : MouseEvent) : void {
		if (event.buttonDown) {
			setDrawAction("down");
		} else {
			setDrawAction("over");
		}
	}

	private function drawDefaultAction() : void {
		if ((_sprite.mouseX > 0 && _sprite.mouseX < _button.width) && (_sprite.mouseY > 0 && _sprite.mouseY < _button.height)) {
			setDrawAction("over");
		} else {
			setDrawAction("default");
		}
	}

	/* *********************************************************************
	 * selection 
	 ********************************************************************* */
	/** selection 상태 */
	public function get selection() : Boolean {
		return _selection;
	}

	public function set selection(selection : Boolean) : void {
		if (_selection == selection) return;
		_selection = selection;
		setDrawState(WidgetState.RUN);
		drawDefaultAction();
		interactionOnOff();
	}

	/** selection item 의 value */
	public function get value() : Object {
		return _value;
	}
}
}
