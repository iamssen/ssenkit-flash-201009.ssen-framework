package ssen.framework.widgets.input {
import ssen.core.draw.material.IDrawMaterialSet;
import ssen.core.geom.Padding;
import ssen.framework.ss_internal;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.styles.flour.scroll.FlourScrollBoxStyleSet;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.text.TextFormat;

use namespace ss_internal;

/**
 * TextInput
 * @author ssen (i@ssen.name)
 */
public class TextInput extends SpriteWidget {
	private var _field : SingleLineTextWidget;
	private var _material : IDrawMaterialSet;

	/** [DEFAULT] text widget*/
	protected function getTextWidget() : SingleLineTextWidget {
		return new SingleLineTextWidget();
	}

	/** [DEFAULT] box material */
	protected function getBoxMaterial() : IDrawMaterialSet {
		return FlourScrollBoxStyleSet.box;
	}

	/** [DEFAULT] box padding*/
	protected function getBoxPadding() : Padding {
		return new Padding(1, 1, 1, 1);
	}

	/** [DEFAULT] text format */
	protected function getTextFormat() : TextFormat {
		return FlourScrollBoxStyleSet.textFormat;
	}

	/** [DEFAULT] disalbe text color */
	protected function getDisableColor() : int {
		return 0xcccccc;
	}

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	/** @private */
	override protected function wconstruct() : void {
		super.wconstruct();
		_field = getTextWidget();
		_field.construct();
	}

	/** setting */
	public function setting_TextInput(service : DisplayObjectContainer = null, index : int = -1, state : String = "run", 
		width : int = 100, // 0
		height : int = 30, // 1
		text : String = "", // 2
		initText : String = "", // 3
		textFormat : TextFormat = null, //4
		textPadding : Padding = null, // 5
		disableColor : int = -1, // 6
		editingMode : String = "readWrite", // 7
		inputType : String = "all"
		) : void {
		setting(service, index, state, width, height, text, initText, textFormat, textPadding, disableColor, editingMode, inputType);
	}

	/**
	 * wsetting <br />
	 * config[0] width : int<br />
	 * config[1] height : int<br />
	 * config[2] text : String<br />
	 * config[3] initText : String<br />
	 * config[4] textFormat : TextFormat<br />
	 * config[5] textPadding : Padding<br />
	 * config[6] disableColor : int<br />
	 * config[7] editingMode : String<br />
	 * config[8] inputType : String
	 */
	override protected function wsetting(config : Array) : void {
		if (!config[4]) config[4] = getTextFormat();
		if (!config[5]) config[5] = getBoxPadding();
		if (config[6] < 0) config[6] = getDisableColor();
		_material = getBoxMaterial();
		_field.setting.apply(null, [sprite, index, state].concat(config));
	}

	/** @private */
	override protected function wregister() : void {
		_field.register();
		_field.addEventListener(Event.CHANGE, fieldChange);
		
		drawBox();
		addToService();
		
		state == WidgetState.RUN ? run() : disable();
	}

	private function fieldChange(event : Event) : void {
		dispatchEvent(event);
	}

	/** @private */
	override protected function wderegister() : void {
		_field.removeEventListener(Event.CHANGE, fieldChange);
		_field.deregister();
		removeFromService();
		graphics.clear();
	}

	/** @private */
	override protected function wunsetting() : void {
		super.wunsetting();
		_field.unsetting();
	}

	/** @private */
	override protected function wdeconstruct() : void {
		super.wdeconstruct();
		_field.deconstruct();
		_field = null;
	}

	/* *********************************************************************
	 * text 
	 ********************************************************************* */
	/** text */
	public function get text() : String {
		return _field.text;
	}

	public function set text(text : String) : void {
		_field.text = text;
		if (registered) drawBox();
	}

	/** 안내문 상태로 만든다 */
	public function setInitText(text : String) : void {
		_field.setInitText(text);
		if (registered) drawBox();
	}

	/* *********************************************************************
	 * implement
	 ********************************************************************* */
	/** @private */
	override public function set state(state : String) : void {
		super.state = state;
		_field.state = state;
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
	 * implement Field 
	 ********************************************************************* */
	/** 가로 사이즈 */
	override public function get width() : Number {
		return _field.width;
	}

	public function set width(width : Number) : void {
		_field.width = width;
		drawBox();
	}

	/** 세로 사이즈 */
	override public function get height() : Number {
		return _field.height;
	}

	public function set height(height : Number) : void {
		_field.height = height;
		drawBox();
	}

	private function drawBox() : void {
		if (_material) {
			graphics.clear();
			_material.draw(state, "default", graphics, 0, 0, _field.width, _field.height);
		}
	}
}
}
