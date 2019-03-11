package ssen.framework.widgets.panels {
import ssen.framework.widgets.core.WidgetState;

/**
 * 사용자에게 알림을 주는 기능
 * @includeExample PanelTest.as
 * @author ssen (i@ssen.name)
 */
public class Alert extends AlertBase {
	/** setting */
	public function setting_Alert(message : * = "alert open", title : String = "alert", ok : String = "OK", callback : Function = null) : void {
		setting(null, -1, WidgetState.RUN, title, callback, message, ok);
	}

	/** @private */
	override protected function getContent() : AlertContentBase {
		return new Content;
	}
}
}

import flashx.textLayout.compose.TextLineRecycler;
import flashx.textLayout.factory.StringTextLineFactory;

import ssen.framework.errors.TypeUnMatchError;
import ssen.framework.widgets.btns.LableBtn;
import ssen.framework.widgets.btns.events.ClickEvent;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.panels.AlertContentBase;
import ssen.styles.flour.panels.FlourWindowStyleSet;

import flash.display.DisplayObject;
import flash.geom.Rectangle;
import flash.text.engine.TextLine;

class Content extends AlertContentBase {
	private var _messageSource : *;
	private var _ok : LableBtn;
	private var _height : Number;
	private var _width : Number;

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	override protected function wconstruct() : void {
		super.wconstruct();
		_ok = new LableBtn();
		_ok.construct();
	}

	override protected function wsetting(config : Array) : void {
		_messageSource = config[2];
		FlourWindowStyleSet.settingBtnConfig(_ok, config[3], sprite, -1, state);
		super.wsetting(config);
	}

	override protected function wregister() : void {
		_ok.register();
		_ok.addEventListener(ClickEvent.CLICK, click);
		
		if (_messageSource is String) {
			var minX : int = 1000;
			var maxX : int = 0;
			var lines : Vector.<TextLine> = new Vector.<TextLine>();
			
			function createdTextLine(line : TextLine) : void {
				sprite.addChild(line);
				if (line.x < minX) minX = line.x;
				if (line.width > maxX) maxX = line.width;
				_ok.y = line.y + 14;
				lines.push(line);
			}
		
			var fac : StringTextLineFactory = new StringTextLineFactory();
			fac.compositionBounds = new Rectangle(0, 0, 1000, 1000);
			fac.text = String(_messageSource);
			fac.textFlowFormat = FlourWindowStyleSet.contentFormat;
			fac.createTextLines(createdTextLine);
			
			if (_ok.width > maxX) {
				minX += (_ok.width - maxX) >> 1;
				_width = _ok.width;
			} else {
				_ok.x = (maxX >> 1) - (_ok.width >> 1);
				_width = maxX;
			}
			
			var f : int = -1;
			var line : TextLine;
			while(++f < lines.length) {
				line = lines[f];
				line.x -= minX;
			}
			
			_height = _ok.y + _ok.height;
		} else if (_messageSource is DisplayObject) {
			var msg : DisplayObject = DisplayObject(_messageSource);
			sprite.addChild(msg);
			
			if (msg.width > _ok.width) {
				_ok.x = (msg.width >> 1) - (_ok.width >> 1);
				_width = msg.width;
			} else {
				msg.x = (_ok.width >> 1) - (msg.width >> 1);
				_width = _ok.width;
			}
			
			_ok.y = msg.y + msg.height + 14;
			
			_height = _ok.y + _ok.height;
		} else {
			throw new TypeUnMatchError("display objcect 이거나 string 이어야 합니다.");
		}
		
		addToService();
		state == WidgetState.RUN ? run() : disable();
	}

	override protected function wderegister() : void {
		_ok.deregister();
		_ok.removeEventListener(ClickEvent.CLICK, click);
		
		var f : int = sprite.numChildren;
		var d : DisplayObject;
		while (--f >= 0) {
			d = sprite.removeChildAt(f);
			if (d is TextLine) {
				TextLineRecycler.addLineForReuse(TextLine(d));
			}
		}
		removeFromService();
	}

	override protected function wunsetting() : void {
		super.wunsetting();
		_messageSource = null;
		_ok.unsetting();
	}

	override protected function wdeconstruct() : void {
		super.wdeconstruct();
		_ok.deconstruct();
		_ok = null;
	}

	/* *********************************************************************
	 * implement
	 ********************************************************************* */
	override protected function run() : void {
		sprite.mouseChildren = true;
		sprite.mouseEnabled = true;
	}

	override protected function disable() : void {
		sprite.mouseChildren = false;
		sprite.mouseEnabled = false; 
	}

	override public function set state(state : String) : void {
		super.state = state;
		_ok.state = state;
	}

	private function click(event : ClickEvent) : void {
		cancel();
	}

	override public function get width() : Number {
		return setted ? _width : 0;
	}

	override public function get height() : Number {
		return setted ? _height : 0;
	}
}