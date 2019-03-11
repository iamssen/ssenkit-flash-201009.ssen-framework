package test {
import de.polygonal.ds.ArrayedDeque;
import de.polygonal.ds.ArrayedQueue;
import de.polygonal.ds.ArrayedStack;

import flash.display.Sprite;
import flash.utils.getTimer;

/**
 * @author ssen (i@ssen.name)
 */
public class DSQueueAndStackSpeedTest extends Sprite {
	public function DSQueueAndStackSpeedTest() {
		//var queue : Array = new Array;
		//queue.push(1);
		//queue.push(2);
		//queue.push(3);
		//queue.push(4);
		//trace(queue);
		//trace(queue.shift());
		//trace(queue);
		//
		//var stack : Array = new Array;
		//stack.push(1);
		//stack.push(2);
		//stack.push(3);
		//stack.push(4);
		//trace(stack);
		//trace(stack.pop());
		//trace(stack);
		//
		//var deque : Array = new Array;
		//deque.push(1);
		//deque.push(2);
		//deque.unshift(3);
		//deque.unshift(4);
		//trace(deque);
		//trace(deque.shift(), deque.pop());
		//trace(deque);
		//		
		var t : int;
		var f : int;
		var max : int = Math.pow(2, 15);
		trace(max);

		var que : ArrayedQueue = new ArrayedQueue(max << 1);
		var stk : ArrayedStack = new ArrayedStack(max << 1);
		var deq : ArrayedDeque = new ArrayedDeque(max << 1);
		var arr : Array = new Array;

		t = getTimer();
		f = -1;
		while(++f < max) {
			que.enqueue(f);
		}
		trace("queue enqueue", getTimer() - t);

		t = getTimer();
		f = -1;
		while(++f < max) {
			stk.push(f);
		}
		trace("stack push", getTimer() - t);

		t = getTimer();
		f = -1;
		while(++f < max) {
			deq.pushBack(f);
		}
		trace("deque pushBack", getTimer() - t);

		t = getTimer();
		f = -1;
		while(++f < max) {
			deq.pushFront(f);
		}
		trace("deque pushFront", getTimer() - t);

		t = getTimer();
		f = -1;
		while(++f < max) {
			arr.push(f);
		}
		trace("array push", getTimer() - t);

		t = getTimer();
		f = -1;
		while(++f < max) {
			arr.unshift(f);
		}
		trace("array unshift", getTimer() - t);



		t = getTimer();
		f = -1;
		while(++f < max) {
			que.dequeue();
		}
		trace("queue dequeue", getTimer() - t);

		t = getTimer();
		f = -1;
		while(++f < max) {
			stk.pop();
		}
		trace("stack pop", getTimer() - t);

		t = getTimer();
		f = -1;
		while(++f < max) {
			deq.popBack();
		}
		trace("deque popBack", getTimer() - t);

		t = getTimer();
		f = -1;
		while(++f < max) {
			deq.popFront();
		}
		trace("deque popFront", getTimer() - t);

		t = getTimer();
		f = -1;
		while(++f < max) {
			arr.pop();
		}
		trace("array pop", getTimer() - t);

		t = getTimer();
		f = -1;
		while(++f < max) {
			arr.shift();
		}
		trace("array shift", getTimer() - t);
	}
}
}
