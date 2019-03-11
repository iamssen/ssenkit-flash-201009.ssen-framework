package ssen.core.draw.material {
import ssen.core.draw.PathMaker;

import flash.display.Graphics;
import flash.display.GraphicsEndFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.display.IGraphicsFill;
import flash.display.IGraphicsStroke;

/**
 * 둥근 모서리를 가진 네모 박스를 그림 [path 옵션을 받지 않는다]
 * @author ssen (i@ssen.name)
 */
public class RoundRectMaterial implements IDrawMaterial {
	/** 채우기로 쓸 graphics fill */
	public var fill : IGraphicsFill;
	/** 라인으로 쓸 graphics stroke */
	public var stroke : IGraphicsStroke;
	/** 모서리의 가로 사이즈 */
	public var ellipseWidth : Number;
	/** 모서리의 세로 사이즈 */
	public var ellipseHeight : Number;
	private var _path : GraphicsPath;

	/**
	 * construct
	 * @param ellipseWidth 모서리의 가로 사이즈
	 * @param ellipseHeight 모서리의 세로 사이즈
	 * @param fill 채우기로 쓸 graphics fill
	 * @param stroke 라인으로 쓸 graphics stroke
	 */
	public function RoundRectMaterial(ellipseWidth : Number = 10, ellipseHeight : Number = 10, fill : IGraphicsFill = null, stroke : IGraphicsStroke = null) {
		this.ellipseWidth = ellipseWidth;
		this.ellipseHeight = ellipseHeight;
		this.fill = fill;
		this.stroke = stroke;
		_path = new GraphicsPath();
	}

	/** @inheritDoc */
	public function draw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		graphics.drawGraphicsData(Vector.<IGraphicsData>([fill, stroke, PathMaker.roundRect(x, y, width, height, ellipseWidth, ellipseHeight, _path), new GraphicsEndFill()]));
	}
}
}
