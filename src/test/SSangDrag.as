package test {
import flash.events.MouseEvent;

import ssen.core.draw.Rect;
import ssen.core.draw.material.SolidMaterial;

import flash.display.GraphicsSolidFill;
import flash.display.Sprite;

/**
 * @author ssen (i@ssen.name)
 */
public class SSangDrag extends Sprite {
	private var sp : Sprite;
	private var _sx : Number;
	private var _sy : Number;
	private var _ox : Number;
	private var _oy : Number;

	public function SSangDrag() {
		sp = new Sprite;
		new Rect(0, 0, 100, 100, new SolidMaterial(new GraphicsSolidFill(0x000000))).draw(sp.graphics);
		addChild(sp);
		
		sp.addEventListener(MouseEvent.MOUSE_DOWN, down);
	}

	private function down(event : MouseEvent) : void {
		sp.removeEventListener(MouseEvent.MOUSE_DOWN, down);
		stage.addEventListener(MouseEvent.MOUSE_UP, up);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, move);
		
		_sx = event.stageX;
		_sy = event.stageY;
		_ox = sp.x;
		_oy = sp.y;
	}

	private function move(event : MouseEvent) : void {
		var x : Number = _ox + (event.stageX - _sx);
		var y : Number = _oy + (event.stageY - _sy);
		if (x < 0) x = 0;
		if (x > stage.stageWidth - sp.width) x = stage.stageWidth - sp.width;
		if (y < 0) y = 0;
		if (y > stage.stageHeight - sp.height) y = stage.stageHeight - sp.height;
		sp.x = x;
		sp.y = y;
		
		event.updateAfterEvent();
	}

	private function up(event : MouseEvent) : void {
		sp.addEventListener(MouseEvent.MOUSE_DOWN, down);
		stage.removeEventListener(MouseEvent.MOUSE_UP, up);
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, move);
	}
}
}
