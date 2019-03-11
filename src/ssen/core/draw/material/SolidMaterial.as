package ssen.core.draw.material {
import ssen.core.draw.PathMaker;

import flash.display.Graphics;
import flash.display.GraphicsEndFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.display.IGraphicsFill;
import flash.display.IGraphicsStroke;

/**
 * 기본적인 벡터 드로윙 material
 * @author ssen(i@ssen.name)
 */
public class SolidMaterial implements IDrawMaterial {
	/** 채우기로 쓸 graphics fill */
	public var fill : IGraphicsFill;
	/** 라인으로 쓸 graphics stroke */
	public var stroke : IGraphicsStroke;

	/**
	 * construct
	 * @param fill 채우기로 쓸 graphics fill
	 * @param stroke 라인으로 쓸 graphics stroke
	 */
	public function SolidMaterial(fill : IGraphicsFill = null, stroke : IGraphicsStroke = null) {
		this.fill = fill;
		this.stroke = stroke;
	}

	/** @inheritDoc */
	public function draw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		graphics.drawGraphicsData(Vector.<IGraphicsData>([fill, stroke, path ? path : PathMaker.rect(x, y, width, height, path), new GraphicsEndFill()]));
	}
}
}
