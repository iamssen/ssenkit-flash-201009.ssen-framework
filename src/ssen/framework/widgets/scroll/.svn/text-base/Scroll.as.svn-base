package ssen.framework.widgets.scroll {
import net.kawa.tween.KTJob;
import net.kawa.tween.KTween;
import net.kawa.tween.easing.Quad;

import ssen.core.draw.material.IDrawMaterialSet;
import ssen.framework.errors.WidgetFlowError;
import ssen.framework.widgets.core.InvalidSpriteWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.styles.flour.scroll.FlourScrollBoxStyleSet;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * 단순한 Scroll, 버튼 없음
 * @includeExample ScrollTest.as
 * @includeExample ScrollVerify.as
 * @author ssen (i@ssen.name)
 */
public class Scroll extends InvalidSpriteWidget {
	// value
	private var _maxValue : Number;
	private var _minValue : Number;
	private var _totalValue : Number;
	private var _value : Number;
	// converted
	private var _view : Number;
	private var _total : Number;
	private var _now : Number;
	// view
	private var _trackSize : Number;
	private var _thumbSize : Number;
	private var _thumbPos : Number;
	private var _thumbMaxPos : Number;
	private var _thumbEnable : Boolean;
	// init
	private var _direction : Boolean;
	// event
	private var _downStagePos : Number;
	private var _downThumbPos : Number;
	// setting
	private var _trackMode : Boolean;
	private var _trackHide : Boolean;
	private var _trackSkinFlag : String;
	private var _thumbSkinFlag : String;
	private var _thumbPosEnd : Number;
	private var _max : Number;
	private var _width : Number;
	private var _height : Number;
	private var _thumbMaterial : IDrawMaterialSet;
	private var _trackMaterial : IDrawMaterialSet;
	private var _tween : KTJob;
	private var _evtWating : Boolean;
	private var _evtScroll : Boolean;

	/* *********************************************************************
	 * default setting 
	 ********************************************************************* */	
	/** 기본 track material */
	protected function getTrackMaterial() : IDrawMaterialSet {
		return FlourScrollBoxStyleSet.track;
	}

	/** 기본 thumb material */
	protected function getThumbMaterial() : IDrawMaterialSet {
		return FlourScrollBoxStyleSet.thumb;
	}

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	/** @private */
	override protected function wconstruct() : void {
		super.wconstruct();
		sprite.mouseChildren = false;
	}

	/** setting */
	public function setting_Scroll(service : DisplayObjectContainer = null, index : int = -1, state : String = "run", 
									direction : Boolean = false, // 0
									width : int = 20, // 1
									height : int = 100, // 2
									min : Number = 0, // 3
									max : Number = 0, // 4
									total : Number = 0, // 5
									pos : Number = 0, // 6
									thumbMaterial : IDrawMaterialSet = null, // 7
									trackMaterial : IDrawMaterialSet = null, // 8
									trackMode : Boolean = false, // 9
									trackHide : Boolean = false // 10
									) : void {
		setting(service, index, state, direction, width, height, min, max, total, pos, thumbMaterial, trackMaterial, trackMode, trackHide);
	}

	/** @private */
	override protected function wsetting(config : Array) : void {
		_thumbMaterial = config[7] || getThumbMaterial();
		_trackMaterial = config[8] || getTrackMaterial();
		_width = config[1];
		_height = config[2];
		_direction = config[0];
		_trackMode = config[9];
		_trackHide = config[10];
		_minValue = config[3];
		_maxValue = config[4];
		_totalValue = config[5];
		_value = config[6];
	}

	/** @private */
	override protected function wregister() : void {
		addToService();
		setInvalid("size", true);
		setInvalid("scroll", true);
		state == WidgetState.RUN ? run() : disable();
		rendering();
	}

	/** @private */
	override protected function wderegister() : void {
		if (_evtScroll) scrollEventOff();
		if (_evtWating) watingEventOff();
		removeFromService();
	}

	/** @private */
	override protected function wunsetting() : void {
		super.wunsetting();
		_thumbMaterial = null;
		_trackMaterial = null;
		unsetInvalidate();
	}

	/* *********************************************************************
	 * implement
	 ********************************************************************* */
	/** @private */
	override public function set state(state : String) : void {
		super.state = state;
		if (registered) setInvalid("state", true);
	}

	/** @private */
	override protected function run() : void {
		if (_evtScroll) scrollEventOff();
		if (!_evtWating) watingEventOn();
		sprite.buttonMode = true;
		sprite.mouseEnabled = true;
	}

	/** @private */
	override protected function disable() : void {
		if (_evtScroll) scrollEventOff();
		if (_evtWating) watingEventOff();
		sprite.buttonMode = false;
		sprite.mouseEnabled = false;
	}

	/* *********************************************************************
	 * event 
	 ********************************************************************* */
	private function watingEventOn() : void {
		_evtWating = true;
		sprite.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		sprite.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
	}

	private function watingEventOff() : void {
		_evtWating = false;
		sprite.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		sprite.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
	}

	private function scrollEventOn() : void {
		_evtScroll = true;
		sprite.stage.addEventListener(MouseEvent.MOUSE_MOVE, scroll);
		sprite.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
	}

	private function scrollEventOff() : void {
		_evtScroll = false;
		sprite.stage.removeEventListener(MouseEvent.MOUSE_MOVE, scroll);
		sprite.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
	}

	private function mouseOut(event : MouseEvent) : void {
		thumbSkinChange("default");
		trackSkinChange("default");
	}

	private function mouseDown(event : MouseEvent) : void {
		var downPos : Number;
		var stagePos : Number;
		if (_direction) {
			downPos = event.localX;
			stagePos = event.stageX;
		} else {
			downPos = event.localY;
			stagePos = event.stageY;
		}
		if (calculate()) {
			watingEventOff();
			if (downPos > _thumbPos && downPos < _thumbPosEnd) {
				_downStagePos = stagePos;
				_downThumbPos = _thumbPos;
				scrollEventOn();
			} else {
				var ratio : Number;
				var max : Number = (_trackSize - _thumbSize);
				if (downPos < _thumbPos) {
					ratio = _trackMode ? (downPos - 10) / max : (_thumbPos - (_thumbSize >> 1)) / max;
				} else {
					ratio = _trackMode ? (downPos - 10) / max : (_thumbPos + (_thumbSize >> 1)) / max;
				}
				if (ratio < 0) ratio = 0;
				if (ratio > 1) ratio = 1;
				_tween = KTween.to(this, 0.3, {scrollPositionRatio:ratio}, Quad.easeOut);
				_tween.addEventListener(Event.CHANGE, tweenUpdate);
				_tween.addEventListener(Event.COMPLETE, tweenComplete);
			}
				
			thumbSkinChange("action");
			trackSkinChange("action");
		}
	}

	private function scroll(event : MouseEvent) : void {
		var stagePos : Number = _direction ? event.stageX : event.stageY;
		var t : Number = stagePos - _downStagePos;
		var pos : Number = _downThumbPos + t;
		if (pos < 0) pos = 0;
		if (pos > _thumbMaxPos) pos = _thumbMaxPos;
		scrollPositionRatio = pos / _thumbMaxPos;
		dispatchEvent(new Event(Event.SCROLL));
		event.updateAfterEvent();
	}

	private function tweenComplete(event : Event) : void {
		_tween.removeEventListener(Event.CHANGE, tweenUpdate);
		_tween.removeEventListener(Event.COMPLETE, tweenComplete);
			
		thumbSkinChange("default");
		trackSkinChange("default");
			
		watingEventOn();
	}

	private function tweenUpdate(event : Event) : void {
		dispatchEvent(new Event(Event.SCROLL));
	}

	private function mouseUp(event : MouseEvent) : void {
		scrollEventOff();
		watingEventOn();
			
		thumbSkinChange("default");
		trackSkinChange("default");
	}

	private function thumbSkinChange(flag : String) : void {
		if (flag != _thumbSkinFlag) {
			_thumbSkinFlag = flag;
			setInvalid("action", true);
		}
	}

	private function trackSkinChange(flag : String) : void {
		if (flag != _trackSkinFlag) {
			_trackSkinFlag = flag;
			setInvalid("action", true);
		}
	}

	/* *********************************************************************
	 * after setting
	 ********************************************************************* */
	/** 가로 사이즈 {setting} */
	override public function get width() : Number {
		return setted ? _width : 0;
	}

	public function set width(width : Number) : void {
		if (!setted) throw new WidgetFlowError(this, "width 는 setting 이후에 설정할 수 있음");
		_width = width;
		if (registered) setInvalid("size", true);
	}

	/** 세로 사이즈 {setting} */
	override public function get height() : Number {
		return setted ? _height : 0;
	}

	public function set height(height : Number) : void {
		if (!setted) throw new WidgetFlowError(this, "height 는 setting 이후에 설정할 수 있음");
		_height = height;
		if (registered) setInvalid("size", true);
	}

	/** scroll 의 방향 */
	public function get direction() : Boolean {
		return _direction;
	}

	/** scroll 될 수 있는 최대값 */
	public function get maxScrollPosition() : Number {
		return _maxValue;
	}

	/** scroll 될 수 있는 최소값 */ 
	public function get minScrollPosition() : Number {
		return _minValue;
	}

	/** 내용물의 최대값 */
	public function get pageSize() : Number {
		return _totalValue;
	}

	/** scroll 위치 */
	public function get scrollPosition() : Number {
		return _value;
	}

	public function set scrollPosition(scrollPosition : Number) : void {
		if (!setted) throw new WidgetFlowError(this, "scrollPosition 은 setting 이후에 설정할 수 있음");
		if (_evtScroll) return;
		if (scrollPosition < _minValue) scrollPosition = _minValue;
		if (scrollPosition > _maxValue) scrollPosition = _maxValue;
		_value = scrollPosition;
		if (registered) setInvalid("scroll", true);
	}

	/** 스크롤 사이즈를 변환 */
	public function resetScrollSize(width : Number, height : Number) : void {
		if (!setted) throw new WidgetFlowError(this, "resetScrollSize 는 setting 이후에 설정할 수 있음");
		_width = width;
		_height = height;
		if (registered) setInvalid("size", true);
	}

	/** 스크롤의 기본 정보를 변환 */
	public function resetScrollInfo(min : Number, max : Number, total : Number) : void {
		_minValue = min;
		_maxValue = max;
		_totalValue = total;
		if (!_value) _value = _minValue;
		if (registered) setInvalid("scroll", true);
	}

	/* *********************************************************************
	 * expansive properties 
	 ********************************************************************* */
	/** (ratio) scroll 위치 */
	public function get scrollPositionRatio() : Number {
		if (setted) {
			return calculate() ? _now / _max : 0;
		} else {
			return 0;
		}
	}

	public function set scrollPositionRatio(ratio : Number) : void {
		if (!setted) throw new WidgetFlowError(this, "scrollPositionRatio 는 setting 이후에 설정할 수 있음");
		if (ratio < 0) ratio = 0;
		if (ratio > 1) ratio = 1;
		_value = (ratio * _max) + _minValue;
		if (registered) setInvalid("scroll", true);
	}

	/** (ratio) 전체 대비 컨텐츠의 비율 - 스크롤썸의 크기 비율 */
	public function get scrollSightRatio() : Number {
		if (setted) {
			return calculate() ? _now / _total : 0;
		} else {
			return 0;
		}
	}

	/* *********************************************************************
	 * calculate 
	 ********************************************************************* */
	private function calculate() : Boolean {
		// converted value
		_total = _totalValue - _minValue;
		_view = _totalValue - _maxValue;
		_now = _value - _minValue;
		_max = _total - _view;
		// enable check
		_thumbEnable = _total > _view;
		if (!_thumbEnable) return false;
		// pixel
		_trackSize = _direction ? _width : _height;
		_thumbSize = (_view / _total) * _trackSize;
		_thumbMaxPos = _trackSize - _thumbSize;
		_thumbPos = (_now / _max) * _thumbMaxPos;
		_thumbPosEnd = _thumbPos + _thumbSize;
		return true;
	}

	/* *********************************************************************
	 * display invalidating
	 ********************************************************************* */
	/** @private */
	override protected function rendering() : void {
		calculate();
		graphics.clear();
			
		if (_thumbEnable || !_trackHide) drawTrack();
		if (_thumbEnable) drawThumb();
			
		clearInvalid();
	}

	/* *********************************************************************
	 * draw 
	 ********************************************************************* */
	private function drawTrack() : void {
		_trackMaterial.draw(state, _trackSkinFlag, graphics, 0, 0, width, height);
	}

	private function drawThumb() : void {
		var x : Number;
		var y : Number;
		var w : Number;
		var h : Number;
		if (_direction) {
			x = _thumbPos;
			y = 0;
			w = _thumbSize;
			h = height;
		} else {
			x = 0;
			y = _thumbPos;
			w = width;
			h = _thumbSize;
		}
		_thumbMaterial.draw(state, _thumbSkinFlag, graphics, x, y, w, h);
	}
}
}