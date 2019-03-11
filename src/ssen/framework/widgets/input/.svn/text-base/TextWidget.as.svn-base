package ssen.framework.widgets.input {
import flashx.textLayout.edit.EditingMode;

import ssen.core.geom.Padding;
import ssen.framework.errors.WidgetFlowError;
import ssen.framework.ss_internal;
import ssen.framework.widgets.core.Widget;
import ssen.framework.widgets.core.WidgetState;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.TextEvent;
import flash.geom.ColorTransform;
import flash.text.TextField;
import flash.text.TextFieldType;

use namespace ss_internal;

/**
 * [Abstract] TextWidget
 * @author ssen (i@ssen.name)
 */
public class TextWidget extends Widget {
	private var _field : TextField;
	private var _x : Number;
	private var _y : Number;
	private var _width : Number;
	private var _height : Number;
	private var _padding : Padding;
	private var _disableTransform : ColorTransform;
	private var _initText : Boolean;
	private var _editingMode : String;
	private var _runTransform : ColorTransform;

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	/** @private */
	override protected function wconstruct() : void {
		_field = new TextField();
		_disableTransform = new ColorTransform();
		_runTransform = new ColorTransform();
	}

	//	/** setting */
	//	public function setting_TextWidget(service : DisplayObjectContainer = null, index : int = -1, state : String = "run", 
	//		width : int = 100, // 0
	//		height : int = 30, // 1
	//		text : String = "", // 2
	//		initText : String = "", // 3
	//		textFormat : TextFormat = null, //4
	//		textPadding : Padding = null, // 5
	//		disableColor : int = 0xcccccc, // 6
	//		editingMode : String = "readWrite" // 7
	//		) : void {
	//		setting(service, index, state, width, height, text, initText, textFormat, textPadding, disableColor, editingMode);
	//	}

	/**
	 * wsetting<br />
	 * config[0] width : int <br />
	 * config[1] height : int<br />
	 * config[2] text : String<br />
	 * config[3] initText : String<br />
	 * config[4] textFormat : TextFormat<br />
	 * config[5] textPadding : Padding<br />
	 * config[6] disableColor : int<br />
	 * config[7] editingMode : String<br />
	 */
	override protected function wsetting(config : Array) : void {
		_x = 0;
		_y = 0;	
		_width = config[0];
		_height = config[1];
		
		_padding = config[5] || new Padding;
		_field.defaultTextFormat = config[4];
		_field.setTextFormat(config[4]);
		_disableTransform.color = config[6];
		align();
			
		if (config[2] != "") {
			_field.text = config[2];
			_initText = false;
		} else if (config[3] != "") {
			_field.text = config[3];
			_initText = true;
		} else {
			_field.text = "";
			_initText = false;
		}
		
		_editingMode = config[7];
	}

	/** @private */
	override protected function wregister() : void {
		addToService();
		state == WidgetState.RUN ? run() : disable();
			
		_field.addEventListener(Event.CHANGE, change);
		_field.addEventListener(TextEvent.TEXT_INPUT, textInput);
		_field.addEventListener(FocusEvent.FOCUS_IN, focusIn);
		_field.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
	}

	/** @private */
	override protected function wderegister() : void {
		_field.removeEventListener(Event.CHANGE, change);
		_field.removeEventListener(TextEvent.TEXT_INPUT, textInput);
		_field.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
		_field.removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
		
		removeFromService();
	}

	/** @private */
	override protected function wunsetting() : void {
		_initText = false;
		_field.text = "";
	}

	/** @private */
	override protected function wdeconstruct() : void {
		_disableTransform = null;
		_runTransform = null;
		_field = null;
	}

	/* *********************************************************************
	 * implement
	 ********************************************************************* */
	/** @private */
	override protected function disable() : void {
		changeTextMode(_editingMode, WidgetState.DISABLE);
	}

	/** @private */
	override protected function run() : void {
		changeTextMode(_editingMode, WidgetState.RUN);
	}

	/** @private */
	override ss_internal function get display() : DisplayObject {
		return _field;
	}

	protected function get field() : TextField {
		return _field;
	}

	/* *********************************************************************
	 * utils 
	 ********************************************************************* */
	private function changeTextMode(editingMode : String, state : String) : void {
		if (state == WidgetState.DISABLE) {
			editingMode = EditingMode.READ_ONLY;
			_field.transform.colorTransform = _disableTransform;
		} else if (_field.transform.colorTransform) {
			_field.transform.colorTransform = _runTransform;
		}
		switch (editingMode) {
			case EditingMode.READ_ONLY :
				_field.type = TextFieldType.DYNAMIC;
				_field.selectable = false; 
				_field.mouseEnabled = false;
				break;
			case EditingMode.READ_SELECT :
				_field.type = TextFieldType.DYNAMIC;
				_field.selectable = true; 
				_field.mouseEnabled = true;
				break;
			case EditingMode.READ_WRITE :
				_field.type = TextFieldType.INPUT;
				_field.selectable = true; 
				_field.mouseEnabled = true;
				break;
		}
	}

	private function align() : void {
		if (!_field || !_padding) return;
		_field.x = _x + _padding.left;
		_field.y = _y + _padding.top;
		_field.width = _width - _padding.leftAndRight;
		_field.height = _height - _padding.topAndBottom;
	}

	/* *********************************************************************
	 * evnet 
	 ********************************************************************* */
	protected function textInput(event : TextEvent) : void {
		dispatchEvent(event);
	}

	protected function change(event : Event) : void {
		dispatchEvent(event);
	}

	protected function focusOut(event : FocusEvent) : void {
		dispatchEvent(event);
	}

	protected function focusIn(event : FocusEvent) : void {
		if (_initText) {
			_field.text = "";
			_initText = false;
		}
		dispatchEvent(event);
	}

	/* *********************************************************************
	 * state 
	 ********************************************************************* */
	/** x 위치 */
	public function get x() : Number {
		return setted ? _x : 0;
	}

	public function set x(x : Number) : void {
		if (!setted) throw new WidgetFlowError(this, "setting 이후에 사용가능 합니다.");
		_x = x;
		align();
	}

	/** y 위치 */
	public function get y() : Number {
		return setted ? _y : 0;
	}

	public function set y(y : Number) : void {
		if (!setted) throw new WidgetFlowError(this, "setting 이후에 사용가능 합니다.");
		_y = y;
		align();
	}

	/** 가로 사이즈 */
	public function get width() : Number {
		return setted ? _width : 0;
	}

	public function set width(width : Number) : void {
		if (!setted) throw new WidgetFlowError(this, "setting 이후에 사용가능 합니다.");
		_width = width;
		align();
	}

	/** 세로 사이즈 */
	public function get height() : Number {
		return setted ? _height : 0;
	}

	public function set height(height : Number) : void {
		if (!setted) throw new WidgetFlowError(this, "setting 이후에 사용가능 합니다.");
		_height = height;
		align();
	}

	/** text */
	public function get text() : String {
		if (!setted || _initText) return "";
		return _field.text;
	}

	public function set text(text : String) : void {
		if (!setted) throw new WidgetFlowError(this, "setting 이후에 사용가능 합니다.");
		_field.text = text;
		_initText = false;
	}

	/* *********************************************************************
	 * operation 
	 ********************************************************************* */
	/** 안내문 상태로 만든다 */
	public function setInitText(text : String) : void {
		if (!setted) throw new WidgetFlowError(this, "setting 이후에 사용가능 합니다.");
		_initText = true;
		_field.text = text;
	}
}
}
