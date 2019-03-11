package ssen.core.draw.material {
import ssen.core.MathX;
import ssen.debug.TestButtonGroup;

import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.Sprite;

/**
 * @author ssen (i@ssen.name)
 */
public class ArrowRectTest extends Sprite {
	private var arr : ArrowRectMaterial;

	public function ArrowRectTest() {
		arr = new ArrowRectMaterial();
		arr.fill = new GraphicsSolidFill(0xeeeeee);
		var strk : GraphicsStroke = new GraphicsStroke(1);
		strk.fill = new GraphicsSolidFill(0x333333);
		arr.stroke = strk;
		
		var t : TestButtonGroup = new TestButtonGroup("generate", generate);
		t.x = 10;
		t.y = 300;
		addChild(t);
	}

	private function generate() : void {
		graphics.clear();
		arr.direction = MathX.rand(0, 3);
		arr.arrowSize = MathX.rand(5, 10);
		arr.draw(graphics, MathX.rand(10, 300), MathX.rand(10, 200), MathX.rand(20, 100), MathX.rand(20, 100));
	}
}
}
