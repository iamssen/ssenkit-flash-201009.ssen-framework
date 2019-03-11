package ssen.core.draw {
import ssen.core.draw.material.SolidMaterial;

import flash.display.Graphics;
import flash.display.GraphicsPath;

/**
 * 간단하게 선을 그어주는 기능 
 * @author ssen (i@ssen.name)
 */
public class Line implements IDrawData {
	private var _x0 : Number;
	private var _y0 : Number;
	private var _x1 : Number;
	private var _y1 : Number;
	private var _path : GraphicsPath;
	private var _material : SolidMaterial;
	private var _changed : Boolean;

	public function Line(x0 : Number = 0, y0 : Number = 0, x1 : Number = 100, y1 : Number = 0, material : SolidMaterial = null) {
		_path = new GraphicsPath();
			
		_x0 = x0;
		_y0 = y0;
		_x1 = x1;
		_y1 = y1;
		_material = material;
		_changed = true;
	}

	/** x0, x1 을 한꺼번에 교체 */
	public function setX(x : Number) : void {
		_x0 = _x1 = x;
		_changed = true;
	}

	/** y0, y1 을 한꺼번에 교체 */
	public function setY(y : Number) : void {
		_y0 = _y1 = y;
		_changed = true;
	}

	public function get x0() : Number {
		return _x0;
	}

	public function set x0(x0 : Number) : void {
		_x0 = x0;
		_changed = true;
	}

	public function get y0() : Number {
		return _y0;
	}

	public function set y0(y0 : Number) : void {
		_y0 = y0;
		_changed = true;
	}

	public function get x1() : Number {
		return _x1;
	}

	public function set x1(x1 : Number) : void {
		_x1 = x1;
		_changed = true;
	}

	public function get y1() : Number {
		return _y1;
	}

	public function set y1(y1 : Number) : void {
		_y1 = y1;
		_changed = true;
	}

	/** @inheritDoc */
	public function draw(graphics : Graphics, state : String = "run", action : String = "default") : void {
		if (_changed) PathMaker.line(x0, y0, x1, y1, _path);
		_material.draw(graphics, 0, 0, 0, 0, _path);
	}

	/** 그리는데 사용될 material, stroke 정보가 있어야 한다 */
	public function get material() : SolidMaterial {
		return _material;
	}

	public function set material(material : SolidMaterial) : void {
		_material = material;
	}

	/** @inheritDoc */
	public function deconstruct() : void {
		_path = null;
		_material = null;
	}
}
}
