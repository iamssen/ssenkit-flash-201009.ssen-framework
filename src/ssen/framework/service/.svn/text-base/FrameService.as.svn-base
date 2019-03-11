package ssen.framework.service {
import ssen.framework.widgets.core.IWidget;

import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.EventDispatcher;

/**
 * 기본 frmae service
 * @author ssen (i@ssen.name)
 */
public class FrameService extends EventDispatcher implements IFrameService {
	private var _stage : Stage;
	private var _sw : int;
	private var _sh : int;
	private var _flashvars : Object;

	/** @inheritDoc */
	public function get stage() : Stage {
		return _stage;
	}

	public function set stage(stage : Stage) : void {
		if (_stage) return;
		_stage = stage;
		_sw = _stage.stageWidth;
		_sh = _stage.stageHeight;
		_stage.addEventListener(Event.RESIZE, stageResize);
	}

	private function stageResize(event : Event) : void {
		_sw = _stage.stageWidth;
		_sh = _stage.stageHeight;
		dispatchEvent(event);
	}

	private var _root : Sprite;
	private var _tip : ITipService;
	private var _panel : IPanelService;
	private var _app : IWidget;

	/** @inheritDoc */
	public function get root() : Sprite {
		return _root;
	}

	public function set root(root : Sprite) : void {
		_root = root;
	}

	/** @inheritDoc */
	public function get tip() : ITipService {
		return _tip;
	}

	public function set tip(tip : ITipService) : void {
		_tip = tip;
	}

	/** @inheritDoc */
	public function get panel() : IPanelService {
		return _panel;
	}

	public function set panel(panel : IPanelService) : void {
		_panel = panel;
	}

	/** @inheritDoc */
	public function get sw() : int {
		return _sw;
	}

	/** @inheritDoc */
	public function get sh() : int {
		return _sh;
	}

	/** @inheritDoc */
	public function get app() : IWidget {
		return _app;
	}

	public function set app(app : IWidget) : void {
		_app = app;
	}
	
	public function get flashvars() : Object {
		return _flashvars;
	}
	
	public function set flashvars(vars : Object) : void {
		_flashvars = vars;
	}
}
}
