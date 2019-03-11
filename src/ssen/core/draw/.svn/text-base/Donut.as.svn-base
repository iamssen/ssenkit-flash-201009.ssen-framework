package ssen.core.draw {
import ssen.core.draw.material.SolidMaterial;

import flash.display.Graphics;
import flash.display.GraphicsPath;

/**
 * 그래프등에 사용되는 도넛 조각 형태를 그린다
 * @author ssen (i@ssen.name)
 */
public class Donut implements IDrawData {
	private var _x : Number;
	private var _y : Number;
	private var _radius : Number;
	private var _innerRadius : Number;
	private var _startDeg : Number;
	private var _endDeg : Number;
	private var _path : GraphicsPath;
	private var _changed : Boolean;
	private var _material : SolidMaterial;

	/* *********************************************************************
	 * polygonal ds 의 graph data 와 합치는 방법을 생각해보자
	 ********************************************************************* */
	public function Donut(x : Number = 50, y : Number = 50, radius : Number = 100, innerRadius : Number = 50, startDeg : Number = 0, endDeg : Number = 360, material : SolidMaterial = null) {
		_path = new GraphicsPath();
			
		_x = x;
		_y = y;
		_radius = radius;
		_innerRadius = innerRadius;
		_startDeg = startDeg;
		_endDeg = endDeg;
			
		_material = material;
			
		_changed = true;
	}

	/** 중앙점 x */
	public function get x() : Number {
		return _x;
	}

	public function set x(x : Number) : void {
		_x = x;
		_changed = true;
	}

	/** 중앙점 y */
	public function get y() : Number {
		return _y;
	}

	public function set y(y : Number) : void {
		_y = y;
		_changed = true;
	}

	/** 반지름 */
	public function get radius() : Number {
		return _radius;
	}

	public function set radius(radius : Number) : void {
		_radius = radius;
		_changed = true;
	}

	/** 뚫린 부분의 반지름 */
	public function get innerRadius() : Number {
		return _innerRadius;
	}

	public function set innerRadius(innerRadius : Number) : void {
		_innerRadius = innerRadius;
		_changed = true;
	}

	/** 도넛 조각이 시작될 각도 */
	public function get startDeg() : Number {
		return _startDeg;
	}

	public function set startDeg(startDeg : Number) : void {
		_startDeg = startDeg;
		_changed = true;
	}

	/** 도넛 조각이 끝날 각도 */
	public function get endDeg() : Number {
		return _endDeg;
	}

	public function set endDeg(endDeg : Number) : void {
		_endDeg = endDeg;
		_changed = true;
	}

	/** @inheritDoc */
	public function draw(graphics : Graphics, state : String = "run", action : String = "default") : void {
		if (_changed) {
			PathMaker.donut(_x, _y, _radius, _innerRadius, _startDeg, _endDeg, _path);
			_changed = false;
		}
		_material.draw(graphics, 0, 0, 0, 0, _path);
	}

	/** 그리는데 사용될 material */
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
