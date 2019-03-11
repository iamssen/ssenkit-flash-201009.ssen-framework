package ssen.framework.widgets.btns {
import ssen.framework.ss_internal;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.togglers.events.ToggleEvent;

import flash.events.MouseEvent;

use namespace ss_internal;

/**
 * On, Off 형태로 Toggle 되는 Button 의 Interaction
 * @see ssen.framework.widgets.togglers.IToggler
 * @author ssen (i@ssen.name)
 */
public class ToggleBtnInteraction extends BtnInteraction {
	private var _toggle : Boolean;

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	/** @private */
	override protected function wsetting(config : Array) : void {
		var cfg : Array = config[1];
		_toggle = cfg[7];
		super.wsetting(config);
	}

	/* *********************************************************************
	 * implement btn interaction 
	 ********************************************************************* */
	/** @private */
	override ss_internal function get drawState() : String {
		if (state == WidgetState.RUN && toggle) {
			return "selected";
		} else {
			return state;
		}
	}

	/** @private */
	override protected function eventOn() : void {
		_sprite.buttonMode = true;
		_sprite.mouseEnabled = true;
		_sprite.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		_sprite.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		_sprite.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		_sprite.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		_sprite.addEventListener(MouseEvent.CLICK, click);
	}

	/** @private */
	override protected function eventOff() : void {
		_sprite.buttonMode = false;
		_sprite.mouseEnabled = false;
		_sprite.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		_sprite.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		_sprite.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		_sprite.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		_sprite.removeEventListener(MouseEvent.CLICK, click);
	}

	/* *********************************************************************
	 * event
	 ********************************************************************* */
	private function click(event : MouseEvent) : void {
		_toggle = !_toggle;
		setDrawState(WidgetState.RUN);
		_button.dispatchEvent(new ToggleEvent(ToggleEvent.TOGGLE, _toggle));
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
	 * toggle 
	 ********************************************************************* */
	/** toggle 상태 */
	public function get toggle() : Boolean {
		return _toggle;
	}

	public function set toggle(toggle : Boolean) : void {
		_toggle = toggle;
		setDrawState(WidgetState.RUN);
		drawDefaultAction();
	}
}
}
