package ssen.core.draw.material {
import ssen.core.draw.PathMaker;

import flash.display.Graphics;
import flash.display.GraphicsPath;

/**
 * 한방향으로 반복되는 형태의 패턴을 그릴때 사용되는 material [path 를 받지 않는다] 
 * @author ssen (i@ssen.name)
 */
public class StripeMaterial implements IDrawMaterial {
	/** 좌에서 우로 진행되는 Stripe */
	public static const VERTICAL : Boolean = false;
	/** 위에서 아래로 진행되는 Stripe */
	public static const HORIZONTAL : Boolean = true;
	private var _direction : Boolean;
	private var _lines : Vector.<StripeLine>;
	private var _solid : SolidMaterial;

	/**
	 * construct
	 * @param lines Stripe 요소들
	 * @param direction Stripe 의 방향
	 */
	public function StripeMaterial(lines : Vector.<StripeLine>, direction : Boolean = false) {
		_lines = lines;
		_direction = direction;
		_solid = new SolidMaterial();
	}

	/** @inheritDoc */
	public function draw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		var start : Number;
		var end : Number;
		var size : Number;
		var line : StripeLine;
		var f : int = 0;
		var draw : Boolean = true;
		var p : GraphicsPath = new GraphicsPath();
		
		if (_direction) {
			start = y;
			end = y + height;
			
			while(draw) {
				line = _lines[f];
				size = line.size;
				if (start + size > end) {
					size = end - start;
					draw = false;
				}
				_solid.fill = line.fill;
				_solid.draw(graphics, x, start, width, size, PathMaker.rect(x, start, width, size, p));
				
				start += size;
				f++;
				if (f >= _lines.length) f = 0;
			}
		} else {
			start = x;
			end = x + width;
			
			while(draw) {
				line = _lines[f];
				size = line.size;
				if (start + size > end) {
					size = end - start;
					draw = false;
				}
				_solid.fill = line.fill;
				_solid.draw(graphics, start, y, size, height, PathMaker.rect(start, y, size, height, p));
				
				start += size;
				f++;
				if (f >= _lines.length) f = 0;
			}
		}
	}

	/** Stripe 의 방향 */
	public function get direction() : Boolean {
		return _direction;
	}

	public function set direction(direction : Boolean) : void {
		_direction = direction;
	}
}
}
