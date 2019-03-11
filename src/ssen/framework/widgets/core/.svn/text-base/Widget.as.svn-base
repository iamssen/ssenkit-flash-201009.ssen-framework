package ssen.framework.widgets.core {
import ssen.framework.errors.ImplementationError;
import ssen.framework.errors.ValueUnMatchError;
import ssen.framework.errors.WidgetFlowError;
import ssen.framework.ss_internal;
import ssen.framework.widgets.core.events.WidgetEvent;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.EventDispatcher;

use namespace ss_internal;

/**
 * IWidget 의 기능을 기초적으로 구현시켜놓은 Class
 * @author ssen (i@ssen.name)
 */
public class Widget extends EventDispatcher implements IWidget {
	private var _constructed : Boolean;
	private var _setted : Boolean;
	private var _registered : Boolean;
	private var _state : String;
	private var _service : DisplayObjectContainer;
	private var _index : int;
	private var _animated : Boolean;
	private var _animationScene : String;
	private var _events : Vector.<EID>;

	/* *********************************************************************
	 * flow 
	 ********************************************************************* */
	/** @inheritDoc */
	final public function construct() : void {
		if (constructed) throw new WidgetFlowError(this, "이미 construct 되어 있음");
		_constructed = true;
		wconstruct();
	}

	/** @inheritDoc */
	final public function setting(service : DisplayObjectContainer = null, index : int = -1, state : String = "run", ...config : Array) : void {
		if (!constructed) throw new WidgetFlowError(this, "construct 되어 있지 않아서, setting 을 진행할 수 없음.");
		if (registered) throw new WidgetFlowError(this, "register 되어 있어서, setting 을 진행할 수 없음.");
		_setted = true;
		_service = service;
		_index = index;
		_state = state;
		_events = new Vector.<EID>;
		wsetting(config);
	}

	/** @inheritDoc */
	final public function register() : void {
		if (registered) throw new WidgetFlowError(this, "이미 register 되어 있음");
		if (!constructed) throw new WidgetFlowError(this, "not constructed");
		if (!setted) throw new WidgetFlowError(this, "not setted");
		_registered = true;
		wregister();
		dispatchEvent(new WidgetEvent(WidgetEvent.REGISTERED));
	}

	/** @inheritDoc */	
	final public function deregister() : void {
		if (!registered) throw new WidgetFlowError(this, "not registered");
		_registered = false;
		wderegister();
		dispatchEvent(new WidgetEvent(WidgetEvent.DEREGISTERED));
	}

	/** @inheritDoc */	
	final public function unsetting() : void {
		if (!setted) throw new WidgetFlowError(this, "not setted");
		if (registered) throw new WidgetFlowError(this, "not deregistered");
		_setted = false;
		_service = null;
		_index = -1;
		_state = WidgetState.NOT_SETTED;
		
		var f : int = _events.length;
		var eid : EID;
		while (--f >= 0) {
			eid = _events[f];
			if (hasEventListener(eid.type)) {
				removeEventListener(eid.type, eid.func, eid.capture);
				eid.clear();
			}
		}
		_events = null;
		wunsetting();
	}

	/** @inheritDoc */	
	final public function deconstruct() : void {
		if (!constructed) throw new WidgetFlowError(this, "not constructed");
		if (setted) throw new WidgetFlowError(this, "not unsetted");
		if (registered) throw new WidgetFlowError(this, "not deregistered");
		_constructed = false;
		wdeconstruct();
	}

	/** @inheritDoc */	
	final public function get registered() : Boolean {
		return _registered;
	}

	/** @inheritDoc */	
	final public function get setted() : Boolean {
		return _setted;
	}

	/** @inheritDoc */	
	final public function get constructed() : Boolean {
		return _constructed;
	}

	/* *********************************************************************
	 * abstract widget flow 
	 ********************************************************************* */
	/** 상속을 통해 생성을 추가적으로 구현할 수 있음 */
	protected function wconstruct() : void {
	}

	/** 상속을 통해 설정을 추가적으로 구현할 수 있음 */
	protected function wsetting(config : Array) : void {
	}

	/** 상속을 통해 등록을 추가적으로 구현할 수 있음 */
	protected function wregister() : void {
	}

	/** 상속을 통해 등록 해제를 추가적으로 구현할 수 있음 */
	protected function wderegister() : void {
	}

	/** 상속을 통해 설정 해제를 추가적으로 구현할 수 있음 */
	protected function wunsetting() : void {
	}

	/** 상속을 통해 파괴를 추가적으로 구현할 수 있음 */
	protected function wdeconstruct() : void {
	}

	/* *********************************************************************
	 * protected members
	 ********************************************************************* */
	/** display 를 service 에 addChild {register} */
	final protected function addToService() : void {
		addToServiceOther(display);
	}

	/** display 를 service 에 removeChild {register} */
	final protected function removeFromService() : void {
		removeFromServiceOther(display);
	}

	/** service {setting} */
	ss_internal function get service() : DisplayObjectContainer {
		return _service;
	}

	/** index {setting} */
	ss_internal function get index() : int {
		return _index;
	}

	/** display 를 service 에 addChild {setting} */
	final ss_internal function addToServiceOther(display : DisplayObject) : void {
		if (index > -1) {
			service.addChildAt(display, index);
		} else {
			service.addChild(display);
		}
	}

	/** display 를 service 에 removeChild {setting} */
	final ss_internal function removeFromServiceOther(display : DisplayObject) : void {
		display.parent.removeChild(display);
	}

	/** animation 을 시작 {register} */
	protected function startAnimation(scene : String) : void {
		_animationScene = scene;
		_animated = true;
	}

	/** animation 을 끝냄  {register} */
	protected function endAnimation() : void {
		_animated = false;
		_animationScene = null;
	}

	/** 현재 animation 의 scene  {register} */
	final protected function get animationScene() : String {
		return _animationScene;
	}

	/** 설정된 state 와 새 state 가 같은지 비교  {setting} */
	final protected function sameStateCheck(state : String) : Boolean {
		return _state == state;
	}

	/* *********************************************************************
	 * event 
	 ********************************************************************* */
	override public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
		super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		_events.push(new EID(type, listener, useCapture));
	}

	/* *********************************************************************
	 * after setted
	 ********************************************************************* */
	/** @inheritDoc */
	public function get state() : String {
		if (!setted) return WidgetState.NOT_SETTED;
		if (_animated) return WidgetState.ANIMATED;
		return _state;
	}

	public function set state(state : String) : void {
		if (!setted) throw new WidgetFlowError(this, "state 는 setted 이후 시점부터 교체가 가능합니다.");
		if (state != WidgetState.RUN && state != WidgetState.DISABLE) throw new ValueUnMatchError("set state 에는 WidgetState.RUN 이나 WidgetState.DISABLE 만 입력 가능합니다.");
		if (_animated) throw new WidgetFlowError(this, "animation 중에는 상태 입력이 불가합니다.");
		if (_state == state) return;
		_state = state;
		// 등록된 상태이면 상태를 바꾸는 메서드를 호출해준다
		if (registered) _state == WidgetState.RUN ? run() : disable();
	}

	/* *********************************************************************
	 * abstract 
	 ********************************************************************* */
	/** disable 상태로 widget 을 전환시킴 */
	protected function disable() : void {
		throw new ImplementationError("disable 상태로의 변환을 구현해야 합니다.");
	}

	/** run 상태로 widget 을 전환시킴 */
	protected function run() : void {
		throw new ImplementationError("run 상태로의 변환을 구현해야 합니다.");
	}

	/** widget 의 display */
	ss_internal function get display() : DisplayObject {
		return null;
	}
}
}

class EID {
	private var _type : String;
	private var _func : Function;
	private var _capture : Boolean;

	public function EID(type : String, func : Function, capture : Boolean) {
		_type = type;
		_func = func;
		_capture = capture;
	}

	public function clear() : void {
		_func = null;
	}

	public function get type() : String {
		return _type;
	}

	public function get func() : Function {
		return _func;
	}

	public function get capture() : Boolean {
		return _capture;
	}
}
