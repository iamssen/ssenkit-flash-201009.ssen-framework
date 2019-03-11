package ssen.framework.widgets.scroll {
import ssen.core.draw.material.IDrawMaterialSet;
import ssen.core.geom.Padding;
import ssen.framework.errors.ImplementationError;
import ssen.framework.errors.WidgetFlowError;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.styles.flour.scroll.FlourScrollBoxStyleSet;

import flash.events.Event;

/**
 * [Abstract] 스크롤팬의 베이스 Class
 * @author ssen (i@ssen.name)
 */
public class ScrollPaneBase extends SpriteWidget implements IScrollContainer {
	private var _scrollV : Scroll;
	private var _scrollH : Scroll;
	private var _xMaterial : IDrawMaterialSet;
	private var _width : Number;
	private var _height : Number;
	private var _container : IScrollContainer;
	private var _padding : Padding;
	private var _material : IDrawMaterialSet;

	/* *********************************************************************
	 * default setting
	 ********************************************************************* */
	/** 좌우 스크롤의 높이 */
	protected function getHScrollHeight() : int {
		return 5;
	}

	/** 상하 스크롤의 넓이 */
	protected function getVScrollWidth() : int {
		return 5;
	}

	/** 좌우 스크롤의 설정 */
	protected function settingScrollH(scroll : Scroll, width : Number, trackMode : Boolean, trackHide : Boolean) : void {
		scroll.setting_Scroll(sprite, -1, state, ScrollDirection.HORIZONTAL, width, getHScrollHeight(), 0, 0, 0, 0, FlourScrollBoxStyleSet.thumb, FlourScrollBoxStyleSet.track, trackMode, trackHide);
	}

	/** 상하 스크롤의 설정 */
	protected function settingScrollV(scroll : Scroll, height : Number, trackMode : Boolean, trackHide : Boolean) : void {
		scroll.setting_Scroll(sprite, -1, state, ScrollDirection.VERTICAL, getVScrollWidth(), height, 0, 0, 0, 0, FlourScrollBoxStyleSet.thumb, FlourScrollBoxStyleSet.track, trackMode, trackHide);
	}

	/** 기본 교차점의 material set */
	protected function getScrollX() : IDrawMaterialSet {
		return FlourScrollBoxStyleSet.track;
	}

	/** 배경 material */
	protected function getMaterial() : IDrawMaterialSet {
		return FlourScrollBoxStyleSet.box;
	}

	/** 전체 box 에서 content 의 공간을 결정하는 padding */
	protected function getPadding() : Padding {
		return new Padding(1, 1, 1, 1);
	}

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	/** @private */
	override protected function wconstruct() : void {
		super.wconstruct();
		_scrollV = new Scroll();
		_scrollV.construct();
		_scrollH = new Scroll();
		_scrollH.construct();
		_container = getContainer();
		_container.construct();
	}

	/** @private */
	override protected function wsetting(config : Array) : void {
		var vw : int = getVScrollWidth();
		var hh : int = getHScrollHeight();
		
		_xMaterial = getScrollX();
		_padding = getPadding();
		_material = getMaterial();
		
		if (_padding) {
			config[0] -= _padding.leftAndRight;
			config[1] -= _padding.topAndBottom;
		} else {
			_padding = new Padding;
		}
		
		
		_width = config[0];
		_height = config[1];
		
		var ve : Boolean;
		var he : Boolean;
		
		if (config[3] && config[2]) {
			config[0] -= vw;
			config[1] -= hh;
			ve = true;
			he = true;
		} else if (config[3] && !config[2]) {
			config[1] -= hh;
			ve = false;
			he = true;
		} else {
			config[0] -= vw;
			ve = true;
			he = false;
		}
		
		if (ve) {
			settingScrollV(_scrollV, config[1], ScrollTrackMode.PAGE, false);
		} else if (!ve && _scrollV.setted) {
			_scrollV.unsetting();
		}
		if (he) {
			settingScrollH(_scrollH, config[0], ScrollTrackMode.PAGE, false);
		} else if (!he && _scrollH.setted) {
			_scrollH.unsetting();
		}
		_container.setting.apply(null, [sprite, -1, state].concat(config));
	}

	/** @private */
	override protected function wregister() : void {
		if (_scrollV.setted) _scrollV.register();
		if (_scrollH.setted) _scrollH.register();
		_container.register();
		
		if (_scrollV.registered) _scrollV.addEventListener(Event.SCROLL, scroll);
		if (_scrollH.registered) _scrollH.addEventListener(Event.SCROLL, scroll);
		contentEventOn();
		
		align();
		resetScroll();
		drawBox();
		
		addToService();
		
		state == WidgetState.RUN ? run() : disable();
	}	

	/** @private */
	override protected function wderegister() : void {
		contentEventOff();
		if (_scrollV.registered) {
			_scrollV.removeEventListener(Event.SCROLL, scroll);
			_scrollV.deregister();
		}
		if (_scrollH.registered) {
			_scrollH.removeEventListener(Event.SCROLL, scroll);
			_scrollH.deregister();
		} 
		_container.deregister();
		graphics.clear();
		
		removeFromService();
	}

	/** @private */
	override protected function wunsetting() : void {
		super.wunsetting();
		if (_scrollV.setted) _scrollV.unsetting();
		if (_scrollH.setted) _scrollH.unsetting();
		_container.unsetting();
	}

	/** @private */
	override protected function wdeconstruct() : void {
		super.wdeconstruct();
		if (_scrollV.constructed) _scrollV.deconstruct();
		if (_scrollH.constructed) _scrollH.deconstruct();
		_container.deconstruct();
	}

	/* *********************************************************************
	 * implement 
	 ********************************************************************* */
	/** @private */
	override public function set state(state : String) : void {
		super.state = state;
		if (_scrollV.setted) _scrollV.state = state;
		if (_scrollH.setted) _scrollH.state = state;
		_container.state = state;
		drawBox();
	}

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

	/* *********************************************************************
	 * implement IScrollContainer 
	 ********************************************************************* */
	/** @inheritDoc */
	public function get scrollV() : Number {
		return setted ? _container.scrollV : 0;
	}

	public function set scrollV(value : Number) : void {
		if (_scrollV.setted) {
			if (value > _container.maxScrollV) value = _container.maxScrollV;
			_container.scrollV = value;
			_scrollV.scrollPosition = value;
		}
	}

	/** @inheritDoc */
	public function get scrollH() : Number {
		return setted ? _container.scrollH : 0;
	}

	public function set scrollH(value : Number) : void {
		if (_scrollH.setted) {
			if (value > _container.maxScrollH) value = _container.maxScrollH;
			_container.scrollH = value;
			_scrollH.scrollPosition = value;
		}
	}

	/** @inheritDoc */
	public function get minScrollV() : Number {
		return setted ? _container.minScrollV : 0;
	}

	/** @inheritDoc */
	public function get maxScrollV() : Number {
		return setted ? _container.maxScrollV : 0;
	}

	/** @inheritDoc */
	public function get minScrollH() : Number {
		return setted ? _container.minScrollH : 0;
	}

	/** @inheritDoc */
	public function get maxScrollH() : Number {
		return setted ? _container.maxScrollH : 0;
	}

	/** @inheritDoc */
	public function get totalScrollV() : Number {
		return setted ? _container.totalScrollV : 0;
	}

	/** @inheritDoc */
	public function get totalScrollH() : Number {
		return setted ? _container.totalScrollH : 0;
	}

	/* *********************************************************************
	 * event 
	 ********************************************************************* */
	private function scroll(event : Event) : void {
		if (_scrollV.setted) _container.scrollV = _scrollV.scrollPosition;
		if (_scrollH.setted) _container.scrollH = _scrollH.scrollPosition;
	}

	/* *********************************************************************
	 * implement 
	 ********************************************************************* */
	/** 가로 사이즈 */
	override public function get width() : Number {
		return setted ? _width + _padding.leftAndRight : 0;
	}

	public function set width(width : Number) : void {
		if (!setted) throw new WidgetFlowError(this, "width 는 setting 이후에 설정이 가능합니다");
		_width = width - _padding.leftAndRight;
		resize();
	}

	/** 세로 사이즈 */
	override public function get height() : Number {
		return setted ? _height + _padding.topAndBottom : 0;
	}

	public function set height(height : Number) : void {
		if (!setted) throw new WidgetFlowError(this, "height 는 setting 이후에 설정이 가능합니다");
		_height = height - _padding.topAndBottom;
		resize();
	}

	/** 사이즈를 새로고침 한다 */
	protected function resize() : void {
		_container.width = _scrollV.setted ? _width - _scrollV.width : _width;
		_container.height = _scrollH.setted ? _height - _scrollH.height : _height;
		if (_scrollV.setted) _scrollV.height = _container.height;
		if (_scrollH.setted) _scrollH.width = _container.width;
		if (registered) {
			align();
			resetScroll();
			drawBox();
		}
	}

	/** 오브젝트들을 정렬 시킨다 */
	protected function align() : void {
		_container.x = _padding.left;
		_container.y = _padding.top;
		if (_scrollV.setted) {
			_scrollV.x = _container.x + _container.width;
			_scrollV.y = _container.y;
		}
		if (_scrollH.setted) {
			_scrollH.x = _container.x;
			_scrollH.y = _container.y + _container.height;
		}
	}

	/** 교차점을 그린다 */
	protected function drawBox() : void {
		graphics.clear();
		if (_material) _material.draw(state, "default", graphics, 0, 0, _width + _padding.leftAndRight, _height + _padding.topAndBottom);
		if (_scrollV.registered && _scrollH.registered) _xMaterial.draw(state, "default", graphics, _scrollV.x, _scrollH.y, _scrollV.width, _scrollH.height);
	}

	/** content 의 scroll info 에 따라 스크롤을 재설정 한다 */
	public function resetScroll() : void {
		if (_scrollV.setted) _scrollV.resetScrollInfo(_container.minScrollV, _container.maxScrollV, _container.totalScrollV);
		if (_scrollH.setted) _scrollH.resetScrollInfo(_container.minScrollH, _container.maxScrollH, _container.totalScrollH);
		
		if (_scrollV.setted && _container.scrollV > _container.maxScrollV) {
			_container.scrollV = _container.maxScrollV;
			_scrollV.scrollPosition = _container.scrollV;
		}
		if (_scrollH.setted && _container.scrollH > _container.maxScrollH) {
			_container.scrollH = _container.maxScrollH;
			_scrollH.scrollPosition = _container.scrollH;
		}
	}

	/* *********************************************************************
	 * content 
	 ********************************************************************* */
	/** content 의 인터렉션을 활성화 시킨다 */
	protected function contentEventOn() : void {
	}

	/** content 의 인터렉션을 비활성 시킨다 */
	protected function contentEventOff() : void {
	}

	/** content 를 만든다 {구현 필요} */
	protected function getContainer() : IScrollContainer {
		throw new ImplementationError("container 에 대한 구현이 필요합니다");
	}

	/** v scroll 의 활성상태 */
	public function get scrollVEnabled() : Boolean {
		return _scrollV.setted;
	}

	/** h scroll 의 활성상태 */
	public function get scrollHEnabled() : Boolean {
		return _scrollH.setted;
	}
}
}


