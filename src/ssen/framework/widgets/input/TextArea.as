package ssen.framework.widgets.input {
import ssen.core.geom.Padding;
import ssen.framework.ss_internal;
import ssen.framework.widgets.scroll.IScrollContainer;
import ssen.framework.widgets.scroll.ScrollPaneBase;
import ssen.styles.flour.scroll.FlourScrollBoxStyleSet;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.text.TextFormat;

use namespace ss_internal;

/**
 * TextArea
 * @includeExample TextAreaVerify.as
 * @includeExample TextWidgetTest.as
 * @author ssen (i@ssen.name)
 */
public class TextArea extends ScrollPaneBase {
	private var _field : MultiLineTextWidget;

	/** [DEFAULT] text format */
	protected function getTextFormat() : TextFormat {
		return FlourScrollBoxStyleSet.textFormat;
	}

	/** [DEFAULT] text disable color */
	protected function getDisableColor() : int {
		return 0xcccccc;
	}

	/** @private */
	override protected function getContainer() : IScrollContainer {
		_field = new MultiLineTextWidget;
		return _field;
	}

	/** [DEFAULT] text padding */
	protected function getTextPadding() : Padding {
		return null;
	}

	/** setting */
	public function setting_TextArea(service : DisplayObjectContainer = null, index : int = -1, state : String = "run", 
		width : int = 100, // 0
		height : int = 30, // 1
		text : String = "", // 2, 6
		initText : String = "", // 3, 7
		textFormat : TextFormat = null, //4, 8
		textPadding : Padding = null, // 5, 9
		disableColor : int = -1, // 6, 10
		editingMode : String = "readWrite", // 7, 11
		wordWrap : Boolean = true,
		mouseWheelEnabled : Boolean = true,
		vScrollEnabled : Boolean = true, // 2
		hScrollEnabled : Boolean = true, // 3
		initScrollV : Number = 0, // 4
		initScrollH : Number = 0 // 5
		) : void {
		setting(service, index, state, width, height, vScrollEnabled, hScrollEnabled, initScrollV, initScrollH, text, initText, textFormat, textPadding, disableColor, editingMode, wordWrap, mouseWheelEnabled);
	}

	/** 
	 * wsetting<br />
	 * config[0] width : int<br />
	 * config[1] height : int<br />
	 * config[2] vScrollEnabled : Boolean<br />
	 * config[3] hScrollEnabled : Boolean<br />
	 * config[4] initScrollV : Number<br />
	 * config[5] initScrollH : Number<br />
	 * config[6] text : String<br />
	 * config[7] initText : String<br />
	 * config[8] textFormat : TextFormat<br />
	 * config[9] textPadding : Padding<br />
	 * config[10] disableColor : int<br />
	 * config[11] editingMode : String<br />
	 * config[12] wordWrap : Boolean<br />
	 * config[13] mouseWheelEnabled : Boolean
	 */
	override protected function wsetting(config : Array) : void {
		if (config[12]) config[3] = false;
		if (!config[8]) config[8] = getTextFormat();
		if (config[10] < 0) config[10] = getDisableColor();
		if (!config[9]) config[9] = getTextPadding();
		super.wsetting(config);
	}

	/** @private */
	override protected function wregister() : void {
		super.wregister();
		
		_field.addEventListener(Event.SCROLL, textScroll);
		_field.addEventListener(Event.CHANGE, textChange);
	}

	/** @private */
	override protected function wderegister() : void {
		super.wderegister();
		
		_field.removeEventListener(Event.SCROLL, textScroll);
		_field.removeEventListener(Event.CHANGE, textChange);
	}

	/** @private */
	override protected function wdeconstruct() : void {
		super.wdeconstruct();
		_field = null;
	}

	/* *********************************************************************
	 * api 
	 ********************************************************************* */
	/** text */
	public function get text() : String {
		return _field.text;
	}

	public function set text(text : String) : void {
		_field.text = text;
		
		resetScroll();
		scrollV = minScrollV;
		scrollH = minScrollH;
		
		if (registered) drawBox();
	}

	/** 안내문 상태로 만든다 */
	public function setInitText(text : String) : void {
		_field.setInitText(text);
		
		resetScroll();
		scrollV = minScrollV;
		scrollH = minScrollH;
		
		if (registered) drawBox();
	}

	/* *********************************************************************
	 * event 
	 ********************************************************************* */
	private function textChange(event : Event = null) : void {
		resetScroll();
		scrollV = _field.scrollV;
		scrollH = _field.scrollH;
	}

	private function textScroll(event : Event = null) : void {
		scrollV = _field.scrollV;
		scrollH = _field.scrollH;
	}
}
}
