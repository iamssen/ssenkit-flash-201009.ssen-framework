package ssen.core.draw {
import ssen.core.draw.material.IDrawMaterial;

import flash.display.Graphics;
import flash.geom.Point;

/**
 * 말풍선 형태의 상자를 만든다
 * @author ssen (i@ssen.name)
 */
public class TailBox implements IDrawData {
	/** 상자의 x 위치 */
	public var x : Number;
	/** 상자의 y 위치 */
	public var y : Number;
	/** 상자의 가로 사이즈 */
	public var width : Number;
	/** 상자의 세로 사이즈 */
	public var height : Number;
	/** 말풍선의 꼬리가 향할 위치 */
	public var tailPoint : Point;
	/** 말풍선이 상자와 닿는 부분의 사이즈 */
	public var tailWidth : int;
	/** 그리는데 사용될 material [path 를 받는 material 만 작동합니다] */
	public var material : IDrawMaterial;

	public function TailBox(tailPoint : Point, x : int = 0, y : int = 0, width : int = 100, height : int = 100, tailWidth : int = 10, material : IDrawMaterial = null) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.material = material;
		this.tailPoint = tailPoint;
		this.tailWidth = tailWidth;
	}

	/** @inheritDoc */
	public function draw(graphics : Graphics, state : String = "run", action : String = "default") : void {
		material.draw(graphics, x, y, width, height, PathMaker.tailBox(x, y, width, height, tailPoint, tailWidth));
	}

	/** @inheritDoc */
	public function deconstruct() : void {
		material = null;
	}
}
}
