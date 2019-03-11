package ssen.core.draw {
import ssen.core.draw.material.IDrawMaterial;
import ssen.core.draw.material.IDrawMaterialSet;
import ssen.debug.tostr;

import flash.display.Graphics;
import flash.display.GraphicsPath;

/**
 * 네모 상자 그리기
 * @author ssen(i@ssen.name)
 */
public class Rect implements IDrawData {
	/** 상자의 x 위치 */
	public var x : Number;
	/** 상자의 y 위치 */
	public var y : Number;
	/** 상자의 가로 크기 */
	public var width : Number;
	/** 상자의 세로 크기 */
	public var height : Number;
	/** 그리는데 사용될 material */
	public var material : IDrawMaterial;
	private var _path : GraphicsPath;
	public var materialSet : IDrawMaterialSet;

	public function Rect(x : Number = 0, y : Number = 0, width : Number = 100, height : Number = 100, material : IDrawMaterial = null, materialSet : IDrawMaterialSet = null) {
		_path = new GraphicsPath();
			
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.material = material;
		this.materialSet = materialSet;
	}

	/** @inheritDoc */
	public function draw(graphics : Graphics, state : String = "run", action : String = "default") : void {
		if (materialSet) {
			materialSet.draw(state, action, graphics, x, y, width, height, PathMaker.rect(x, y, width, height, _path));
		} else {
			material.draw(graphics, x, y, width, height, PathMaker.rect(x, y, width, height, _path));
		}
	}

	/** @inheritDoc */
	public function deconstruct() : void {
		_path = null;
		material = null;
		materialSet = null;
	}

	public function toString() : String {
		return tostr("Rect", {x:x, y:y, width:width, height:height});
	}
}
}
