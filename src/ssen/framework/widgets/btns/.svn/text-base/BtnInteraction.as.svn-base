package ssen.framework.widgets.btns {
import ssen.framework.errors.ImplementationError;
import ssen.framework.errors.WidgetFlowError;
import ssen.framework.ss_internal;
import ssen.framework.widgets.core.Widget;
import ssen.framework.widgets.core.WidgetState;

import flash.display.Sprite;

use namespace ss_internal;

/**
 * [Abstract] Button 의 Interaction 정의
 * @author ssen (i@ssen.name)
 */
public class BtnInteraction extends Widget {
	protected var _button : Btn;
	protected var _sprite : Sprite;
	private var _drawState : String;
	private var _drawAction : String;

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	/** @private */
	override protected function wsetting(config : Array) : void {
		_button = config[0];
		_sprite = Sprite(_button.display);
		_drawState = state;
		_drawAction = "default";
	}

	/** @private */
	override protected function wregister() : void {
		_sprite.mouseChildren = false;
		interactionOnOff();
		setDrawState(state);
		setDrawAction("default");
	}

	/** @private */
	override protected function wderegister() : void {
		_sprite.graphics.clear();
		eventOff();
	}

	/** @private */
	override protected function wunsetting() : void {
		_button = null;
		_sprite = null;
		_drawState = null;
		_drawAction = null;
	}

	/** @private */
	override public function set state(state : String) : void {
		super.state = state;
		setDrawState(state);
		setDrawAction("default");
	}

	/* *********************************************************************
	 * implement
	 ********************************************************************* */
	/** @private */
	override protected function run() : void {
		setDrawState(WidgetState.RUN);
		interactionOnOff();
	}

	/** @private */
	override protected function disable() : void {
		setDrawState(WidgetState.DISABLE);
		eventOff();
	}

	/* *********************************************************************
	 * function 
	 ********************************************************************* */
	/** interaction event 의 on, off 를 결정 */
	protected function interactionOnOff() : void {
		if (state == WidgetState.RUN) {
			eventOn();
		} else {
			eventOff();
		}
	}

	/** event 를 off */
	protected function eventOff() : void {
		throw new ImplementationError("disable 상태로의 변환을 구현해야 합니다.");
	}

	/** event 를 on */
	protected function eventOn() : void {
		throw new ImplementationError("run 상태로의 변환을 구현해야 합니다.");
	}

	/* *********************************************************************
	 *	draw 
	 ********************************************************************* */
	/** set draw state */
	final protected function setDrawState(state : String = null) : void {
		if (!setted) throw new WidgetFlowError(this, "setDrawState 는 setting 이후에 설정 가능합니다.");
		if (state) _drawState = state;
		if (registered) _button.setDrawState();
	}

	/** set draw action */
	final protected function setDrawAction(action : String = null) : void {
		if (!setted) throw new WidgetFlowError(this, "setDrawAction 은 setting 이후에 설정 가능합니다.");
		if (action) _drawAction = action;
		if (registered) _button.setDrawAction();
	}

	/** get draw state */
	ss_internal function get drawState() : String {
		return _drawState;
	}

	/** get draw action */
	ss_internal function get drawAction() : String {
		return _drawAction;
	}
}
}
