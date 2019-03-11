package ds {
import de.polygonal.ds.ArrayedQueue;

import flash.display.Sprite;

public class QueueTest extends Sprite {
	public function QueueTest() {
		var que : ArrayedQueue = new ArrayedQueue(4);
		que.enqueue(new QueueSprite(1));
		que.enqueue(new QueueSprite(2));
		que.enqueue(new QueueSprite(3));
		que.enqueue(new QueueSprite(4));

		trace("dequeue", que.dequeue());
		trace(que);
	}
}
}

import flash.display.Sprite;

class QueueSprite extends Sprite {
	private var _queueID : int;

	public function QueueSprite(queueID : int) {
		_queueID = queueID;
	}

	override public function toString() : String {
		return "QueueSprite id " + _queueID;
	}
}