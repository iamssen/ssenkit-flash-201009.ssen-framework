package ssen.framework.widgets.core {
import ssen.framework.errors.WidgetFlowError;
import ssen.framework.ss_internal;

import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Sprite;

use namespace ss_internal;

/**
 * Sprite 의 기초기능을 확장시킨 Widget
 * @author ssen (i@ssen.name)
 */
public class SpriteWidget extends Widget implements IDisplayWidget {
	private var _display : Sprite;

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	/** @private */
	override protected function wconstruct() : void {
		_display = new Sprite();
	}

	/** @private */
	override protected function wunsetting() : void {
		_display.x = 0;
		_display.y = 0;
	}

	/** @private */
	override protected function wdeconstruct() : void {
		_display = null;
	}

	/* *********************************************************************
	 * after setted 
	 ********************************************************************* */
	/** x 위치 {setting} */
	public function get x() : Number {
		return setted ? _display.x : 0;
	}

	public function set x(x : Number) : void {
		if (!setted) throw new WidgetFlowError(this, "x 는 setting 이후에 교체가 가능합니다.");
		_display.x = x;
	}

	/** y 위치 {setting} */
	public function get y() : Number {
		return setted ? _display.y : 0;
	}

	public function set y(y : Number) : void {
		if (!setted) throw new WidgetFlowError(this, "y  는 setting 이후에 교체가 가능합니다.");
		_display.y = y;
	}

	/** width {setting} */
	public function get width() : Number {
		return setted ? _display.width : 0;
	}

	/** height {setting} */
	public function get height() : Number {
		return setted ? _display.height : 0;
	}

	/* *********************************************************************
	 * protected members 
	 ********************************************************************* */
	/** @private */
	final override ss_internal function get display() : DisplayObject {
		return _display;
	}

	/** widget 의 graphics */
	final protected function get graphics() : Graphics {
		return _display.graphics;
	}

	/** widget 의 sprite, display 와 같다 */
	final protected function get sprite() : Sprite {
		return _display;
	}
}
}
