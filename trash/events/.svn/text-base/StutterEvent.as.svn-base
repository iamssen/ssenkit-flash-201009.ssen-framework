package ssen.stutter.events {
import ssen.debug.tostr;

import flash.events.Event;

/**
 * @author ssen (i@ssen.name)
 */
public class StutterEvent extends Event {
	public static const VIEW_HEADER_LIST : String = "viewHeaderList";
	public static const TOP : String = "anchorTop";
	public static const MOVE : String = "anchorMove";
	private var _anchorX : Number;
	private var _anchorY : Number;

	public function StutterEvent(type : String, anchorX : Number = 0, anchorY : Number = 0, bubbles : Boolean = false, cancelable : Boolean = false) {
		super(type, bubbles, cancelable);
		_anchorX = anchorX;
		_anchorY = anchorY;
	}

	public function get anchorX() : Number {
		return _anchorX;
	}

	public function get anchorY() : Number {
		return _anchorY;
	}

	override public function clone() : Event {
		return new StutterEvent(type, anchorX, anchorY, bubbles, cancelable);
	}

	override public function toString() : String {
		return tostr("StutterAnchorEvent", {type:type, anchorX:anchorX, anchorY:anchorY});
	}
}
}
