package ssen.framework.widgets.btns {
import ssen.framework.ss_internal;
import ssen.framework.widgets.btns.events.ClickEvent;

import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;
import flash.utils.getTimer;

use namespace ss_internal;

/**
 * 누르는 형태의 Button Interaction
 * @author ssen (i@ssen.name)
 */
public class ClickBtnInteraction extends BtnInteraction {
	private var _timer : Timer;
	private var _clickTime : int;
	private var _longDownEnable : Boolean;
	private var _longDownTime : int;
	private var _doubleClickTime : int;

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	/** @private */
	override protected function wsetting(config : Array) : void {
		var cfg : Array = config[1];
		_doubleClickTime = cfg[4];
		_longDownEnable = cfg[5];
		_longDownTime = cfg[6];
		super.wsetting(config);
	}

	/* *********************************************************************
	 * implement btn interaction
	 ********************************************************************* */
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
	 * interaction
	 ********************************************************************* */
	private function click(event : MouseEvent) : void {
		_button.dispatchEvent(new ClickEvent(ClickEvent.CLICK));
		if (getTimer() - _clickTime < _doubleClickTime) {
			_button.dispatchEvent(new ClickEvent(ClickEvent.DOUBLE_CLICK));
			_clickTime = 0;
		} else {
			_clickTime = getTimer();
		}
	}

	private function stageUp(event : MouseEvent) : void {
		_timer.stop();
		_timer.removeEventListener(TimerEvent.TIMER, downTimeCheck);
		_sprite.stage.removeEventListener(MouseEvent.MOUSE_UP, stageUp);
		_timer = null;
	}

	private function mouseUp(event : MouseEvent) : void {
		if ((_sprite.mouseX > 0 && _sprite.mouseX < _button.width) && (_sprite.mouseY > 0 && _sprite.mouseY < _button.height)) {
			setDrawAction("over");
		} else {
			setDrawAction("default");
		}
	}

	private function mouseDown(event : MouseEvent) : void {
		setDrawAction("down");
		if (_longDownEnable) {
			_timer = new Timer(_longDownTime);
			_timer.addEventListener(TimerEvent.TIMER, downTimeCheck);
			_timer.start();
			_sprite.stage.addEventListener(MouseEvent.MOUSE_UP, stageUp);
		}
	}

	private function downTimeCheck(event : TimerEvent) : void {
		_button.dispatchEvent(new ClickEvent(ClickEvent.LONG_DOWN));
		_timer.stop();		
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
}
}
