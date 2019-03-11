package ssen.core.draw.material {
import ssen.core.MathX;
import ssen.core.draw.PathMaker;

import flash.display.GradientType;
import flash.display.Graphics;
import flash.display.GraphicsEndFill;
import flash.display.GraphicsGradientFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.display.IGraphicsStroke;
import flash.geom.Matrix;

/**
 * 그래디언트 색상을 그려줌
 * @author ssen (i@ssen.name)
 */
public class LinerGradientMaterial implements IDrawMaterial {
	/** 그래디언트의 각도 */
	public var degree : int;
	/** 선 */
	public var stroke : IGraphicsStroke;
	private var _fill : GraphicsGradientFill;

	public function LinerGradientMaterial(colors : Array, alphas : Array, ratios : Array, degree : int = 90, stroke : IGraphicsStroke = null) {
		_fill = new GraphicsGradientFill(GradientType.LINEAR, colors, alphas, ratios, new Matrix);
		this.degree = degree;
		this.stroke = stroke;
	}

	/** 색상 배열 */
	public function get colors() : Array {
		return _fill.colors;
	}

	public function set colors(colors : Array) : void {
		_fill.colors = colors;
	}

	/** 투명도 배열 */
	public function get alphas() : Array {
		return _fill.alphas;
	}

	public function set alphas(alphas : Array) : void {
		_fill.alphas = alphas;
	}

	/** 색상 배분 비율 배열 */
	public function get ratios() : Array {
		return _fill.ratios;
	}

	public function set ratios(ratios : Array) : void {
		_fill.ratios = ratios;
	}

	/** @inheritDoc */
	public function draw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		_fill.matrix.createGradientBox(width, height, MathX.RADIAN[degree], x, y);
		graphics.drawGraphicsData(Vector.<IGraphicsData>([_fill, stroke, path ? path : PathMaker.rect(x, y, width, height, path), new GraphicsEndFill()]));
	}
}
}
