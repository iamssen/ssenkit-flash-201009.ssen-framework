package ssen.framework.widgets.core {
import ssen.framework.errors.ImplementationError;
import ssen.framework.service.SS;
import ssen.framework.widgets.core.events.WidgetEvent;

import de.polygonal.ds.HashMap;

import flash.events.Event;

/**
 * Invalidation 기능이 추가된 Widget
 * @author ssen (i@ssen.name)
 */
public class InvalidSpriteWidget extends SpriteWidget {
	private var _invalid : HashMap;

	/** @private */
	override protected function wconstruct() : void {
		super.wconstruct();
		_invalid = new HashMap();
	}

	/** @private */
	override protected function wdeconstruct() : void {
		super.wdeconstruct();
		clearInvalid();
		_invalid = null;
	}

	/* *********************************************************************
	 * invalidate 
	 ********************************************************************* */
	private function invalidate() : void {
		if (registered) {
			SS.stage.addEventListener(Event.RENDER, render, false, 0, true);
			SS.stage.addEventListener(Event.ENTER_FRAME, render, false, 0, true);
			SS.stage.invalidate();
		} else {
			addEventListener(WidgetEvent.REGISTERED, onRegistered, false, 0, true);
		}
	}

	private function onRegistered(event : WidgetEvent) : void {
		removeEventListener(WidgetEvent.REGISTERED, onRegistered);
		invalidate();
	}

	private function render(event : Event = null) : void {
		if (registered) {
			SS.stage.removeEventListener(Event.RENDER, render);
			SS.stage.removeEventListener(Event.ENTER_FRAME, render);
			if (_invalid.size() > 0) rendering();
		}
	}

	/** invalidate 에 사용된 자원들을 삭제시킴 */
	final protected function unsetInvalidate() : void {
		if (SS.stage.hasEventListener(Event.RENDER)) SS.stage.removeEventListener(Event.RENDER, render);
		if (SS.stage.hasEventListener(Event.ENTER_FRAME)) SS.stage.removeEventListener(Event.ENTER_FRAME, render);
		if (hasEventListener(WidgetEvent.REGISTERED)) removeEventListener(WidgetEvent.REGISTERED, onRegistered);
		clearInvalid();
	}

	/** 렌더링 {register} */
	protected function rendering() : void {
		throw new ImplementationError("rendering 을 구현시켜줘야함");
	}

	/** invalid 요소를 추가함 */
	protected final function setInvalid(key : String, val : Boolean) : void {
		if (_invalid.has(key)) {
			_invalid.remap(key, val);
		} else {
			_invalid.set(key, val);
		}
		invalidate();
	}

	/** invalid 요소를 읽음 */
	protected final function getInvalid(key : String) : * {
		return _invalid.get(key);
	}

	/** 모든 invalid 요소를 삭제함 */
	protected final function clearInvalid() : void {
		_invalid.clear();
	}
}
}
