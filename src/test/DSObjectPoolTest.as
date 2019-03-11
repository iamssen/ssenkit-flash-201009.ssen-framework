package test {
import de.polygonal.ds.Itr;
import de.polygonal.ds.pooling.ObjectPool;

import flash.display.Sprite;
import flash.utils.getTimer;

/**
 * @author ssen (i@ssen.name)
 */
public class DSObjectPoolTest extends Sprite {
	public function DSObjectPoolTest() {
		var f : int;
		var max : int = 50000;
		var t : int;
		var o : Obj;
		
		t = getTimer();
		f = -1;
		while(++f < max) {
			o = new Obj();
			o = null;
		}
		trace("new", getTimer() - t);
		
		t = getTimer();
		f = -1;
		while(++f < max) {
			o = getObject();
			putObject(o);
		}
		trace("pool", getTimer() - t);
	}

	/* *********************************************************************
	 * pooling
	 ********************************************************************* */
	private var _pool : ObjectPool;

	public function getObject() : Obj {
		if (!_pool) {
			_pool = new ObjectPool(10);
			_pool.allocate(Obj);
		}
		try {
			var pid : int = _pool.next();
			var obj : Obj = Obj(_pool.get(pid));
			obj.pid = pid;
			return obj;
		} catch (error : Error) {
			return null;
		}
		return null;
	}

	public function putObject(obj : Obj) : void {
		_pool.put(obj.pid);
	}

	public function freePool() : void {
		var itr : Itr = Itr(_pool.iterator());
		var obj : Obj;
		while(itr.hasNext()) {
			obj = Obj(itr.next());
		}
		_pool.free();
		_pool = null;
	}
}
}

import flash.geom.Point;

class Obj extends Point {
	public var pid : int;
}