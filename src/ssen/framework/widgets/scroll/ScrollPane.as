package ssen.framework.widgets.scroll {
import ssen.framework.errors.WidgetFlowError;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

/**
 * DisplayObject 를 보는 용도로 사용하는 스크롤팬
 * @includeExample ScrollPaneTest.as
 * @includeExample ScrollPaneVerify.as
 * @author ssen (i@ssen.name)
 */
public class ScrollPane extends ScrollPaneBase {
	private var _container : Container;

	/** setting */
	public function setting_ScrollPane(service : DisplayObjectContainer = null, index : int = -1, state : String = "run",
		content : DisplayObject = null,
		width : int = 100, // 0
		height : int = 100, // 1
		vScrollEnabled : Boolean = true, // 2
		hScrollEnabled : Boolean = true, // 3
		initScrollV : Number = 0, // 4
		initScrollH : Number = 0 // 5
		) : void {
		setting(service, index, state, width, height, vScrollEnabled, hScrollEnabled, initScrollV, initScrollH, content);
	}

	/** @private */
	override protected function getContainer() : IScrollContainer {
		_container = new Container;
		return _container;
	}

	/** @private */
	override protected function wdeconstruct() : void {
		super.wdeconstruct();
		_container = null;
	}

	/** content 를 교체한다 */
	public function get content() : DisplayObject {
		return setted ? _container.content : null;
	}

	public function set content(content : DisplayObject) : void {
		if (!setted) throw new WidgetFlowError(this, "content 는 setting 이후에 설정이 가능합니다.");
		_container.content = content;
		
		resetScroll();
		scrollV = minScrollV;
		scrollH = minScrollH;
		
		if (registered) drawBox();
	}
}
}

import ssen.core.draw.Rect;
import ssen.core.draw.material.SolidMaterial;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.scroll.IScrollContainer;

import flash.display.DisplayObject;
import flash.display.GraphicsSolidFill;
import flash.display.Shape;

class Container extends SpriteWidget implements IScrollContainer {
	private var _mask : Shape;
	private var _content : DisplayObject;
	private var _width : int;
	private var _height : int;

	override protected function wconstruct() : void {
		super.wconstruct();
		_mask = new Shape();
		new Rect(0, 0, 10, 10, new SolidMaterial(new GraphicsSolidFill(0x000000))).draw(_mask.graphics);
	}

	override protected function wsetting(config : Array) : void {
		//var cfg : ScrollPaneConfig = ScrollPaneConfig(config);
		_content = config[6];
		_width = config[0];
		_height = config[1];
		
		if (config[2]) scrollV = config[4];
		if (config[3]) scrollH = config[5];
	}

	override protected function wregister() : void {
		sprite.addChild(_content);
		sprite.addChild(_mask);
		sprite.mask = _mask;
		
		_mask.width = _width;
		_mask.height = _height;
		
		state == WidgetState.RUN ? run() : disable();
		
		addToService();
	}

	override protected function wderegister() : void {
		sprite.removeChild(_content);
		sprite.removeChild(_mask);
		sprite.mask = null;
		
		removeFromService();
	}

	override protected function wunsetting() : void {
		super.wunsetting();
		_content = null;
	}

	override protected function wdeconstruct() : void {
		super.wdeconstruct();
		
		_mask.graphics.clear();
		_mask = null;
	}

	/* *********************************************************************
	 * implement
	 ********************************************************************* */
	/** @private */
	override protected function disable() : void {
		sprite.mouseEnabled = false;
		sprite.mouseChildren = false;
	}

	/** @private */
	override protected function run() : void {
		sprite.mouseEnabled = true;
		sprite.mouseChildren = true;
	}

	public function get scrollV() : Number {
		return -_content.y;
	}

	public function get scrollH() : Number {
		return -_content.x;
	}

	public function get minScrollV() : Number {
		return 0;
	}

	public function get maxScrollV() : Number {
		var max : Number = _content.height - _height;
		return max > 0 ? max : 0;
	}

	public function get minScrollH() : Number {
		return 0;
	}

	public function get maxScrollH() : Number {
		var max : Number = _content.width - _width;
		return max > 0 ? max : 0;
	}

	public function get totalScrollV() : Number {
		return _content.height;
	}

	public function get totalScrollH() : Number {
		return _content.width;
	}

	public function set scrollV(value : Number) : void {
		if (value < minScrollV) value = minScrollV;
		if (value > maxScrollV) value = maxScrollV;
		_content.y = -value;
	}

	public function set scrollH(value : Number) : void {
		if (value < minScrollH) value = minScrollH;
		if (value > maxScrollH) value = maxScrollH;
		_content.x = -value;
	}

	override public function get width() : Number {
		return _width;
	}

	public function set width(width : Number) : void {
		_width = width;
		resize();
	}

	override public function get height() : Number {
		return _height;
	}

	public function set height(height : Number) : void {
		_height = height;
		resize();
	}

	private function resize() : void {
		_mask.width = _width;
		_mask.height = _height;
	}

	public function get content() : DisplayObject {
		return _content;
	}

	public function set content(content : DisplayObject) : void {
		if (_content) {
			if (registered) sprite.removeChild(_content);
			_content = null;
		}
		if (registered) sprite.addChild(content);
		_content = content;
	}
}
