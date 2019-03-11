package ssen.core.draw {
import flash.filters.BitmapFilterQuality;
import flash.filters.DropShadowFilter;
import flash.display.GraphicsPath;
import flash.display.JointStyle;

import ssen.core.MathX;
import ssen.core.draw.material.SolidMaterial;

import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

/**
 * @private
 * @author ssen (i@ssen.name)
 */
public class TailBoxTest extends Sprite {
	private var tail : TailBox;

	public function TailBoxTest() {
		var stroke : GraphicsStroke = new GraphicsStroke(4, true, "normal", "none", JointStyle.MITER);
		stroke.fill = new GraphicsSolidFill(0xffffff);
		tail = new TailBox(new Point(129, 54), 100, 100, 100, 100, 20, new SolidMaterial(null, stroke));
		tail.draw(graphics);
		stage.addEventListener(MouseEvent.CLICK, draw);
		
		var path : GraphicsPath = new GraphicsPath();
		path.moveTo(100, 100);
		
		filters = [new DropShadowFilter(2, 90, 0, 0.3, 8, 8, 1, BitmapFilterQuality.MEDIUM)];
	}

	private function draw(event : MouseEvent) : void {
		graphics.clear();
		SolidMaterial(tail.material).fill = new GraphicsSolidFill(MathX.rand(0x000000, 0xffffff));
		tail.tailPoint = new Point(event.stageX, event.stageY);
		tail.draw(graphics);
	}
}
}
