package ssen.stutter {
import ssen.core.draw.Rect;
import ssen.core.draw.material.IDrawMaterial;
import ssen.core.draw.material.StripeLine;
import ssen.core.draw.material.StripeMaterial;

import de.polygonal.ds.pooling.LinkedObjectPool;

import flash.display.Shape;

/**
 * @author ssen (i@ssen.name)
 */
public class StutterLine extends Shape {
	private function register(compositionWidth : int, border : Number) : void {
		new Rect(0, 0, compositionWidth, border, getMaterial()).draw(graphics);
	}

	private function deregister() : void {
		graphics.clear();
	}

	public static var _material : IDrawMaterial;

	private function getMaterial() : IDrawMaterial {
		if (!_material) _material = new StripeMaterial(Vector.< StripeLine >([new StripeLine(4, 0x000000, 1), new StripeLine(4, 0x000000, 0)]));
		return _material;
	}

	/* *********************************************************************
	 * pooling
	 ********************************************************************* */
	private static var _pool : LinkedObjectPool;

	public static function get(compositionWidth : int, border : Number = 1) : StutterLine {
		if (!_pool) {
			_pool = new LinkedObjectPool(5, false);
			_pool.allocate(StutterLine);
		}
		var obj : StutterLine = StutterLine(_pool.get());
		obj.register(compositionWidth, border);
		return obj;
	}

	public static function put(obj : StutterLine) : void {
		_pool.put(obj);
		obj.deregister();
	}

	public static function free() : void {
		_pool.free();
		_pool = null;
	}
}
}
