package ssen.styles.flour.boxes {
import ssen.core.MathX;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * @private
 * @author ssen (i@ssen.name)
 */
public class FlourWindowTest extends Sprite {
	private var material : FlourToolWindowBoxMaterial;

	public function FlourWindowTest() {
		material = new FlourToolWindowBoxMaterial();
		addEventListener(Event.ADDED_TO_STAGE, addedToStage);
	}

	private function addedToStage(event : Event) : void {
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		stage.addEventListener(MouseEvent.CLICK, stageClick);
	}

	private function stageClick(event : MouseEvent) : void {
		graphics.clear();
		material.headerHeight = MathX.rand(15, 30);
		material.toolHeight = MathX.rand(10, 50);
		material.draw(graphics, MathX.rand(10, 100), MathX.rand(10, 100), MathX.rand(100, 300), MathX.rand(100, 300));
	}
}
}
