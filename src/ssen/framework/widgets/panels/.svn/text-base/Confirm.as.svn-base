package ssen.framework.widgets.panels {
import ssen.framework.widgets.core.WidgetState;

/**
 * ok, cancel 형태로 사용자 반응을 물어보는 Panel object 
 * @author ssen (i@ssen.name)
 */
public class Confirm extends AlertBase {
	/** setting */
	public function setting_Confirm(message : * = "alert open", title : String = "alert", ok : String = "OK", cancel : String = "CANCEL", callback : Function = null) : void {
		setting(null, -1, WidgetState.RUN, title, callback, message, ok, cancel);
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
	private var _cancel : LableBtn;

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	override protected function wconstruct() : void {
		super.wconstruct();
		_ok = new LableBtn();
		_ok.construct();
		_cancel = new LableBtn();
		_cancel.construct();
	}

	override protected function wsetting(config : Array) : void {
		_messageSource = config[2];
		FlourWindowStyleSet.settingBtnConfig(_ok, config[3], sprite, -1, state);
		FlourWindowStyleSet.settingBtnConfig(_cancel, config[4], sprite, -1, state);
		super.wsetting(config);
	}

	override protected function wregister() : void {
		_ok.register();
		_ok.addEventListener(ClickEvent.CLICK, okClick);
		_cancel.register();
		_cancel.addEventListener(ClickEvent.CLICK, cancelClick);
		
		var btnSpace : int = 0;
		var btnsWidth : int = _ok.width + _cancel.width + btnSpace;
		
		if (_messageSource is String) {
			var minX : int = 1000;
			var maxX : int = 0;
			var lines : Vector.<TextLine> = new Vector.<TextLine>();
			
			function createdTextLine(line : TextLine) : void {
				sprite.addChild(line);
				if (line.x < minX) minX = line.x;
				if (line.width > maxX) maxX = line.width;
				_ok.y = _cancel.y = line.y + 14;
				lines.push(line);
			}
		
			var fac : StringTextLineFactory = new StringTextLineFactory();
			fac.compositionBounds = new Rectangle(0, 0, 1000, 1000);
			fac.text = String(_messageSource);
			fac.textFlowFormat = FlourWindowStyleSet.contentFormat;
			fac.createTextLines(createdTextLine);
			
			if (btnsWidth > maxX) {
				minX += (btnsWidth - maxX) >> 1;
				_width = btnsWidth;
			} else {
				_ok.x = (maxX >> 1) - (btnsWidth >> 1);
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
			
			if (msg.width > btnsWidth) {
				_ok.x = (msg.width >> 1) - (btnsWidth >> 1);
				_width = msg.width;
			} else {
				msg.x = (btnsWidth >> 1) - (msg.width >> 1);
				_width = btnsWidth;
			}
			
			_ok.y = _cancel.y = msg.y + msg.height + 14;
			_height = _ok.y + _ok.height;
		} else {
			throw new TypeUnMatchError("display objcect 이거나 string 이어야 합니다.");
		}
		
		_cancel.x = _ok.x + _ok.width + btnSpace;
		
		addToService();
		
		state == WidgetState.RUN ? run() : disable();
	}

	override protected function wderegister() : void {
		_ok.deregister();
		_ok.removeEventListener(ClickEvent.CLICK, okClick);
		_cancel.deregister();
		_cancel.removeEventListener(ClickEvent.CLICK, cancelClick);
		
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
		_cancel.unsetting();
	}

	override protected function wdeconstruct() : void {
		super.wdeconstruct();
		_ok.deconstruct();
		_ok = null;
		_cancel.deconstruct();
		_cancel = null;
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
		_cancel.state = state;
	}

	private function okClick(event : ClickEvent) : void {
		submit();
	}

	private function cancelClick(event : ClickEvent) : void {
		cancel();
	}

	override public function get width() : Number {
		return setted ? _width : 0;
	}

	override public function get height() : Number {
		return setted ? _height : 0;
	}
}
