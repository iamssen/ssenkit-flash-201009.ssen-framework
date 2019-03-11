package ssen.framework.widgets.input {
import ssen.framework.widgets.scroll.IScrollContainer;

import flash.events.Event;

/**
 * 여러줄 입력 텍스트
 * @author ssen (i@ssen.name)
 */
public class MultiLineTextWidget extends TextWidget implements IScrollContainer {
	//	/** setting */
	//	public function setting_MultiLineTextWidget(service : DisplayObjectContainer = null, index : int = -1, state : String = "run", 
	//		width : int = 100, // 0
	//		height : int = 30, // 1
	//		text : String = "", // 2, 6
	//		initText : String = "", // 3, 7
	//		textFormat : TextFormat = null, //4, 8
	//		textPadding : Padding = null, // 5, 9
	//		disableColor : int = 0xcccccc, // 6, 10
	//		editingMode : String = "readWrite", // 7, 11
	//		wordWrap : Boolean = true,
	//		mouseWheelEnabled : Boolean = true,
	//		vScrollEnabled : Boolean = true, // 2
	//		hScrollEnabled : Boolean = true, // 3
	//		initScrollV : Number = 0, // 4
	//		initScrollH : Number = 0 // 5
	//		) : void {
	//		setting(service, index, state, width, height, text, initText, textFormat, textPadding, disableColor, editingMode, wordWrap, mouseWheelEnabled);
	//	}
	/** @copy ssen.framework.widgets.input.TextArea#wsetting() */
	override protected function wsetting(config : Array) : void {
		field.wordWrap = config[12];
		field.mouseEnabled = config[13];
		field.multiline = true;
		super.wsetting([config[0], config[1], config[6], config[7], config[8], config[9], config[10], config[11]]);
	}

	override protected function wregister() : void {
		super.wregister();
		field.addEventListener(Event.SCROLL, scroll);
	}

	override protected function wderegister() : void {
		super.wderegister();
		field.removeEventListener(Event.SCROLL, scroll);
	}

	private function scroll(event : Event) : void {
		dispatchEvent(event);
	}

	/* *********************************************************************
	 * implement IScrollContainer 
	 ********************************************************************* */
	public function get scrollV() : Number {
		return field.scrollV;
	}

	public function get scrollH() : Number {
		return field.scrollH;
	}

	public function get minScrollV() : Number {
		return 1;
	}

	public function get maxScrollV() : Number {
		return field.maxScrollV;
	}

	public function get minScrollH() : Number {
		return 0;
	}

	public function get maxScrollH() : Number {
		return field.maxScrollH;
	}

	public function get totalScrollV() : Number {
		return field.numLines;
	}

	public function get totalScrollH() : Number {
		return field.width + field.maxScrollH;
	}

	public function set scrollV(value : Number) : void {
		field.scrollV = value;
	}

	public function set scrollH(value : Number) : void {
		field.scrollH = value;
	}
}
}
