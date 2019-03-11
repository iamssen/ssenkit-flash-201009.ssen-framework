package ssen.framework.service {
import ssen.framework.widgets.tips.ITipObject;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

/**
 * 기본 top service
 * @author ssen (i@ssen.name)
 */
public class TipService extends Sprite implements ITipService {
	private var _tip : ITipObject;

	/** @inheritDoc */
	public function open(tip : ITipObject) : void {
		if (_tip) _tip.deregister();
		
		_tip = tip;
		_tip.register();
	}

	/** @inheritDoc */
	public function close() : void {
		if (_tip.registered) _tip.deregister();
		_tip = null;
	}

	/** @inheritDoc */
	public function get service() : DisplayObjectContainer {
		return this;
	}
}
}
