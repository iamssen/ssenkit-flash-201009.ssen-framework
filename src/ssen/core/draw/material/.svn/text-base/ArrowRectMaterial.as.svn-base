package ssen.core.draw.material {
import ssen.core.draw.PathMaker;

import flash.display.Graphics;
import flash.display.GraphicsEndFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.display.IGraphicsFill;
import flash.display.IGraphicsStroke;

/**
 * @author ssen (i@ssen.name)
 */
public class ArrowRectMaterial implements IDrawMaterial {
	/**
	 * arrow 의 방향
	 * @see ssen.core.geom.Direction
	 */
	public var direction : int;
	/** arrow 의 size */
	public var arrowSize : int;
	/** 채우기로 쓸 graphics fill */
	public var fill : IGraphicsFill;
	/** 라인으로 쓸 graphics stroke */
	public var stroke : IGraphicsStroke;

	/**
	 * construct
	 * @param fill 채우기로 쓸 graphics fill
	 * @param stroke 라인으로 쓸 graphics stroke
	 */
	public function ArrowRectMaterial(direction : int = 1, arrowSize : int = 5, fill : IGraphicsFill = null, stroke : IGraphicsStroke = null) {
		this.direction = direction;
		this.arrowSize = arrowSize;
		this.fill = fill;
		this.stroke = stroke;
	}

	/** @inheritDoc */
	public function draw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		graphics.drawGraphicsData(Vector.<IGraphicsData>([fill, stroke, PathMaker.arrowRect(direction, arrowSize, x, y, width, height), new GraphicsEndFill()]));
	}
}
}
