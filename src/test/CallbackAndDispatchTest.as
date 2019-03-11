package test {
import flash.display.Sprite;
import flash.events.Event;

/**
 * @author ssen (i@ssen.name)
 */
public class CallbackAndDispatchTest extends Sprite {
	private var test1 : Callback;
	private var test2 : Dispatch;

	public function CallbackAndDispatchTest() {
		test2 = new Dispatch();
		test2.addEventListener(Event.CHANGE, change);
		test2.start();
		test1 = new Callback(callback);
		test1.start();
	}

	private function change(event : Event) : void {
		//trace("dispatch");
	}

	private function callback() : void {
		//trace("callback");
	}
}
}

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.getTimer;

var time : int = 10000;

class Dispatch extends EventDispatcher {
	public function Dispatch() {
	}

	public function start() : void {
		var t : int = getTimer();
		var f : int = -1;
		while(++f < time) {
			dispatchEvent(new Event(Event.CHANGE));
		}
		trace("dispatch", getTimer() - t);
	}
}

class Callback {
	private var _callback : Function;

	public function Callback(callback : Function) {
		_callback = callback;
	}

	public function start() : void {
		var t : int = getTimer();
		var f : int = -1;
		while(++f < time) {
			_callback();
		}
		trace("callback", getTimer() - t);
	}
}
