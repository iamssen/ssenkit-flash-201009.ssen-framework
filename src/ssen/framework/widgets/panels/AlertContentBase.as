package ssen.framework.widgets.panels {
import ssen.core.draw.Rect;
import ssen.core.draw.material.SolidMaterial;
import ssen.framework.widgets.core.SpriteWidget;

import flash.display.GraphicsSolidFill;
import flash.events.MouseEvent;

/**
 * AlertBase 의 내부 내용
 * @author ssen (i@ssen.name)
 */
public class AlertContentBase extends SpriteWidget {
	private var _callback : Function;

	/** @private */
	override protected function wsetting(config : Array) : void {
		_callback = config[1];
	}

	/** @private */
	override protected function wregister() : void {
		new Rect(0, 0, 300, 200, new SolidMaterial(new GraphicsSolidFill(0xeeeeee))).draw(graphics);
		sprite.addEventListener(MouseEvent.CLICK, okClick);
		
		addToService();
	}

	private function okClick(event : MouseEvent) : void {
		_callback(false);
	}

	/** @private */
	override protected function wderegister() : void {
		sprite.removeEventListener(MouseEvent.CLICK, okClick);
		removeFromService();
	}

	/** @private */
	override protected function wunsetting() : void {
		super.wunsetting();
		_callback = null;
	}

	/** ok 를 눌러서 form 의 내용을 전달한다 */
	protected function submit() : void {
		_callback(true);
	}

	/** cancel 을 눌러서 form 의 내용을 취소한다 */
	protected function cancel() : void {
		_callback(false);
	}

	/** form 이 선택한 값 */
	public function value() : Object {
		return null;
	}
}
}
