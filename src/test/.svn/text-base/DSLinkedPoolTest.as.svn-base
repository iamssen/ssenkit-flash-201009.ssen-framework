package test {
import flash.display.Sprite;

/**
 * @author ssen (i@ssen.name)
 */
public class DSLinkedPoolTest extends Sprite {
	public function DSLinkedPoolTest() {
		var f : int = -1;
		var max : int = 100;
		while(++f < max) {
			Dummy.get();
		}
	}
}
}

import de.polygonal.ds.pooling.LinkedObjectPool;

import flash.display.Sprite;

class Dummy extends Sprite {
	/* *********************************************************************
	 * pooling
	 ********************************************************************* */
	private static var _pool : LinkedObjectPool;

	public static function get() : Dummy {
		if (!_pool) {
			_pool = new LinkedObjectPool(5, true);
			_pool.allocate(Dummy);
		}
		var obj : Dummy = Dummy(_pool.get());
		trace(_pool.getUsageCount(), _pool.getWasteCount(), _pool.getSize());
		return obj;
	}

	public static function put(obj : Dummy) : void {
		_pool.put(obj);
	}

	public static function free() : void {
		_pool.free();
		_pool = null;
	}
}