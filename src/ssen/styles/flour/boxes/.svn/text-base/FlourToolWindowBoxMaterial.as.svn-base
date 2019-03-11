package ssen.styles.flour.boxes {
import ssen.core.draw.material.Bitmap15GridMaterial;
import ssen.core.draw.material.BitmapMaterial;
import ssen.core.draw.material.IDrawMaterial;

import flash.display.Graphics;
import flash.display.GraphicsPath;
import flash.geom.Rectangle;

/**
 * @author ssen (i@ssen.name)
 */
public class FlourToolWindowBoxMaterial implements IDrawMaterial {

	[Embed(source="window-bg-run-default.png")]
	public static var bgImage : Class;

	[Embed(source="window-tool-inner-run-default.png")]
	public static var innerImage : Class;
	private static var _bg : BitmapMaterial;
	private static var _inner : Bitmap15GridMaterial;
	public var headerHeight : int;
	public var toolHeight : int;

	public function FlourToolWindowBoxMaterial(headerHeight : int = 22, toolHeight : int = 30) {
		this.headerHeight = headerHeight;
		this.toolHeight = toolHeight;
		if (!_bg) {
			_bg = new BitmapMaterial(new bgImage().bitmapData, false, new Rectangle(12, 20, 26, 18));
			_inner = new Bitmap15GridMaterial(new innerImage().bitmapData, [12, 26, 12], [12, 12, 2, 12, 12], 4, toolHeight);
		}
	}

	public function draw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		_bg.draw(graphics, x, y, width, height, path);
		_inner.fixedYHeight = toolHeight;
		_inner.draw(graphics, x + 4, y + headerHeight, width - 8, height - headerHeight - 4);
	}
}
}

