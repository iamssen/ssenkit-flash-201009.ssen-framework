package test {
import de.polygonal.ds.Heap;
import de.polygonal.ds.Itr;

import flash.display.Sprite;

/**
 * @author ssen (i@ssen.name)
 */
public class DSHeapTest extends Sprite {
	public function DSHeapTest() {
		/*
		 * 크기 순으로 정렬된다
		 * 가장 작은 값을 가진 노드나 가장 큰 값을 가진 노드를
		 * 빠르게 찾아내기 위한 자료구조 이다.
		 * 
		 * -- 현재로서는 가장 큰 값만을 구할 수 있다
		 */
		var heap : Heap = new Heap();
		var comp : Comp = new Comp(30);
		heap.enqueue(new Comp(1));
		heap.enqueue(comp);
		heap.enqueue(new Comp(40));
		heap.enqueue(new Comp(35));
		trace("===============");
		trace(heap);
		
		// 특정 아이템을 지운다. 왜 에러가 나는걸까?
		trace(comp);
		try {
			trace(heap.remove);
			heap.remove(comp);
		} catch (err : Error) {
			trace(err);
		}
		
		trace(heap);
		
		// 가장 큰 값을 가진 녀석을 내보낸다
		trace(heap.dequeue());
		
		heap.enqueue(new Comp(28));
		trace(heap);
		
		// 가장 큰 값을 가진 오브젝트를 불러온다
		trace(heap.front());
		
		// 한계수량이 정해져있을 경우 한계수량치를 가져온다
		trace(heap.maxSize());
		
		var itr : Itr = Itr(heap.iterator());
		while(itr.hasNext()) {
			trace(itr.next());
		}
	}
}
}

import ssen.debug.tostr;

import de.polygonal.ds.Comparable;

class Comp implements Comparable {
	public var value : int;

	public function Comp(value : int) {
		this.value = value;
	}

	public function compare(other : Object) : int {
		return value - Comp(other).value;
	}

	public function toString() : String {
		return tostr("comp", {value:value});
	}
}
