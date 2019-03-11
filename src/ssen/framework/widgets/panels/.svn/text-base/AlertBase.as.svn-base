package ssen.framework.widgets.panels {
import flashx.textLayout.compose.TextLineRecycler;
import flashx.textLayout.factory.StringTextLineFactory;
import flashx.textLayout.factory.TruncationOptions;

import net.kawa.tween.KTween;
import net.kawa.tween.easing.Quad;

import ssen.core.draw.PathMaker;
import ssen.core.geom.Padding;
import ssen.framework.errors.ImplementationError;
import ssen.framework.service.SS;
import ssen.framework.ss_internal;
import ssen.framework.widgets.btns.Btn;
import ssen.framework.widgets.btns.events.ClickEvent;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.styles.flour.boxes.FlourWindowBoxMaterial;
import ssen.styles.flour.panels.FlourWindowStyleSet;

import de.polygonal.ds.DLLNode;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.display.PixelSnapping;
import flash.events.Event;
import flash.filters.BlurFilter;
import flash.geom.Rectangle;
import flash.text.engine.TextLine;

use namespace ss_internal;

/**
 * alert, confirm 등의 창 형태의 모듈의 기본 베이스 {구현 필요}
 * @author ssen (i@ssen.name)
 */
public class AlertBase extends SpriteWidget implements IPanelObject {
	public var pid : int;
	private var _callback : Function;
	private var _node : DLLNode;
	private var _content : AlertContentBase;
	private var _title : String;
	private var _close : Btn;
	private var _titleLine : TextLine;
	private var _dummy : Bitmap;
	private var _width : int;
	private var _height : int;

	/* *********************************************************************
	 * default setting 
	 ********************************************************************* */
	/** 기본 content {구현 필요} */
	protected function getContent() : AlertContentBase {
		throw new ImplementationError("getContent 는 구현해야 합니다.");
	}

	/** 기본 content 영역을 조절하는 padding */
	protected function getContentPadding() : Padding {
		return new Padding(20, 20, 20, 20);
	}

	/* *********************************************************************
	 * response bridge 
	 ********************************************************************* */
	/** content 의 event 를 중재하는 response bridge */
	protected function contentResponse(isSubmit : Boolean) : void {
		if (isSubmit) {
			submit();
		} else {
			cancel();
		}
	}

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	/** @private */
	override protected function wconstruct() : void {
		super.wconstruct();
		_content = getContent();
		_content.construct();
		_close = new Btn();
		_close.construct();
	}

	/** @private */
	override protected function wsetting(config : Array) : void {
		_title = config[0];
		_callback = config[1];
		config[1] = contentResponse;
		_content.setting.apply(null, [sprite, -1, state].concat(config));
		FlourWindowStyleSet.settingCloseBtn(_close, sprite, -1, state);
	}

	/** @private */
	override protected function wregister() : void {
		_content.register();
		_close.register();
		
		_close.addEventListener(ClickEvent.CLICK, cancel);
		
		var ww : int;
		var wh : int;
		
		var cp : Padding = getContentPadding();
		var tp : Padding = new Padding(10, 5, 10, 10);
		
		_content.x = cp.left;
		ww = cp.leftAndRight + _content.width;
		
		function createdTextLine(line : TextLine) : void {
			_titleLine = line;
			sprite.addChild(line);
		}
		
		var fac : StringTextLineFactory = new StringTextLineFactory();
		fac.truncationOptions = new TruncationOptions("", 1);
		fac.compositionBounds = new Rectangle(tp.top, tp.left, ww - tp.leftAndRight - _close.width, 100);
		fac.text = _title;
		fac.textFlowFormat = FlourWindowStyleSet.titleFormat;
		fac.createTextLines(createdTextLine);
		
		_close.x = ww - _close.width - 7;
		_close.y = _titleLine.y - _titleLine.height + 2;
		
		_content.y = tp.topAndBottom + _titleLine.height + cp.top;
		wh = tp.topAndBottom + _titleLine.height + cp.topAndBottom + _content.height;
		
		_width = ww;
		_height = wh;
		drawPanel(ww, wh, tp.topAndBottom + _titleLine.height);
		
		addToService();
		rePositioning();
		
		startAnimation("appare");
	}

	/** @private */
	override protected function wderegister() : void {
		startAnimation("disappare");
		
		_content.deregister();
		_close.deregister();
		
		sprite.removeChild(_titleLine);
		TextLineRecycler.addLineForReuse(_titleLine);
		_titleLine = null;
		
		removeFromService();
	}

	/** @private */
	override protected function wunsetting() : void {
		_callback = null;
		_content.unsetting();
		_close.unsetting();
	}

	/** @private */
	override protected function wdeconstruct() : void {
		_content.deconstruct();
		_content = null;
		_close.deconstruct();
		_close = null;
		super.wdeconstruct();
	}

	/* *********************************************************************
	 * service 
	 ********************************************************************* */
	/** @private */
	override ss_internal function get service() : DisplayObjectContainer {
		return SS.panel.service;
	}

	/** @private */
	override ss_internal function get index() : int {
		return -1;
	}

	/* *********************************************************************
	 * animation 
	 ********************************************************************* */
	/** @private */
	override protected function startAnimation(scene : String) : void {
		super.startAnimation(scene);
		
		switch (scene) {
			case "appare" :
				removeFromService();
			
				_dummy = new Bitmap(createCapture(), PixelSnapping.AUTO, true);
				_dummy.x = SS.sw * 0.5;
				_dummy.y = SS.sh * 0.5;
				_dummy.width = 10;
				_dummy.height = 10;
				_dummy.alpha = 0;
				addToServiceOther(_dummy);
				KTween.to(_dummy, 0.3, {alpha:1, x:x, y:y, width:width, height:height}, Quad.easeOut, endAnimation); 
				break;
			case "disappare" : 
				_dummy = new Bitmap(createCapture());
				_dummy.x = x;
				_dummy.y = y;
				_dummy.alpha = 1;
				addToServiceOther(_dummy);
				KTween.to(_dummy, 0.3, {alpha:0}, Quad.easeOut, endAnimation);
				break;
		}
	}

	/** @private */
	override protected function endAnimation() : void {
		switch (animationScene) {
			case "appare" :
				removeFromServiceOther(_dummy);
				_dummy.bitmapData.dispose();
				_dummy = null;
				addToService(); 
				break;
			case "disappare" :
				removeFromServiceOther(_dummy);
				_dummy.bitmapData.dispose();
				_dummy = null;
				break;
		}
		
		super.endAnimation();
	}

	/** capture 를 만들어낸다 */
	protected function createCapture() : BitmapData {
		var bmd : BitmapData = new BitmapData(width, height, true, 0x00000000);
		bmd.draw(sprite);
		return bmd;
	}

	override public function get width() : Number {
		return _width;
	}

	override public function get height() : Number {
		return _height;
	}

	/* *********************************************************************
	 * draw 
	 ********************************************************************* */
	protected function drawPanel(width : Number, height : Number, headerHeight : Number) : void {
		graphics.clear();
		
		var material : FlourWindowBoxMaterial = FlourWindowStyleSet.windowBox;
		material.headerHeight = headerHeight;
		material.draw(graphics, 0, 0, width, height, PathMaker.rect(0, 0, width, height));
	}

	/* *********************************************************************
	 * state 
	 ********************************************************************* */
	/** @private */
	override protected function run() : void {
		sprite.filters = [];
		sprite.alpha = 1;
	}

	/** @private */
	override protected function disable() : void {
		sprite.filters = [new BlurFilter()]; 
		sprite.alpha = 0.7;
	}

	/** @private */
	override public function set state(state : String) : void {
		super.state = state;
		_close.state = state;
		_content.state = state;
	}

	/* *********************************************************************
	 * callback 
	 ********************************************************************* */
	private function cancel(event : Event = null) : void {
		dispatchEvent(new Event(Event.CLOSE));
		if (_callback != null) _callback(false);
	}

	private function submit() : void {
		dispatchEvent(new Event(Event.CLOSE));
		if (_callback != null) _callback(true, value());
	}

	/* *********************************************************************
	 * implement IPanelObject 
	 ********************************************************************* */
	/** @inheritDoc */
	public function rePositioning() : void {
		x = (SS.sw >> 1) - (width >> 1);
		y = (SS.sh >> 1) - (height >> 1);
	}

	/** @inheritDoc */
	public function value() : Object {
		return _content.value();
	}

	/** @inheritDoc */
	public function get node() : DLLNode {
		return _node;
	}

	public function set node(node : DLLNode) : void {
		_node = node;
	}
}
}