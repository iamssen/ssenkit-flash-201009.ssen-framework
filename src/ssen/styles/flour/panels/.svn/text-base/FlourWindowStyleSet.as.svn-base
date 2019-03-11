package ssen.styles.flour.panels {
import flashx.textLayout.formats.ITextLayoutFormat;
import flashx.textLayout.formats.TextAlign;
import flashx.textLayout.formats.TextLayoutFormat;

import ssen.core.geom.Padding;
import ssen.framework.widgets.btns.Btn;
import ssen.framework.widgets.btns.LableBtn;
import ssen.styles.flour.FlourTextFormatFactory;
import ssen.styles.flour.boxes.FlourToolWindowBoxMaterial;
import ssen.styles.flour.boxes.FlourWindowBoxMaterial;
import ssen.styles.flour.btn.FlourCloseBtnMaterial;

import flash.display.DisplayObjectContainer;

/**
 * alert, confirm 등에 쓰이는 material 들의 집합
 * @author ssen (i@ssen.name)
 */
public class FlourWindowStyleSet {
	private static var _windowBox : FlourWindowBoxMaterial;
	private static var _contentFormat : TextLayoutFormat;
	private static var _titleFormat : TextLayoutFormat;
	private static var _toolBox : FlourToolWindowBoxMaterial;

	/** window box material */
	public static function get windowBox() : FlourWindowBoxMaterial {
		if (!_windowBox) _windowBox = new FlourWindowBoxMaterial();
		return _windowBox;
	}

	public static function get toolWindowBox() : FlourToolWindowBoxMaterial {
		if (!_toolBox) _toolBox = new FlourToolWindowBoxMaterial();
		return _toolBox;
	}

	/** close button setting */
	public static function settingCloseBtn(btn : Btn, service : DisplayObjectContainer = null, index : int = -1, state : String = "run") : void {
		btn.setting_Btn(service, index, state, 13, 13, FlourCloseBtnMaterial.material);
	}

	/** window title text format */
	public static function get titleFormat() : ITextLayoutFormat {
		if (!_titleFormat) _titleFormat = FlourTextFormatFactory.getEmbedSansSerif(11);
		return _titleFormat;
	}

	/** content text format */
	public static function get contentFormat() : ITextLayoutFormat {
		if (!_contentFormat) _contentFormat = FlourTextFormatFactory.getEmbedSansSerif(11, TextAlign.CENTER);
		return _contentFormat;
	}

	/** default button config */
	public static function settingBtnConfig(btn : LableBtn, text : String = "button", service : DisplayObjectContainer = null, index : int = -1, state : String = "run") : void {
		btn.setting_LableBtn(service, index, state, text, new TextFormatSet(), new Padding(0, 0, 10, 10), true, 100, 20);
	}
}
}

import flashx.textLayout.formats.ITextLayoutFormat;
import flashx.textLayout.formats.TextAlign;
import flashx.textLayout.formats.TextLayoutFormat;
import flashx.textLayout.formats.VerticalAlign;

import ssen.core.draw.material.ITextFormatSet;
import ssen.styles.flour.FlourTextFormatFactory;

class TextFormatSet implements ITextFormatSet {
	private var _default : TextLayoutFormat;
	private var _over : TextLayoutFormat;
	private var _down : TextLayoutFormat;
	private var _selected : TextLayoutFormat;
	private var _disable : TextLayoutFormat;

	public function TextFormatSet() {
		_default = FlourTextFormatFactory.getEmbedSansSerif(9, TextAlign.CENTER, VerticalAlign.MIDDLE, 0x3f3f3f);
		_over = FlourTextFormatFactory.getEmbedSansSerif(9, TextAlign.CENTER, VerticalAlign.MIDDLE, 0x372404);
		_down = FlourTextFormatFactory.getEmbedSansSerif(9, TextAlign.CENTER, VerticalAlign.MIDDLE, 0x372404);
		_selected = FlourTextFormatFactory.getEmbedSansSerif(9, TextAlign.CENTER, VerticalAlign.MIDDLE, 0x22222f);
		_disable = FlourTextFormatFactory.getEmbedSansSerif(9, TextAlign.CENTER, VerticalAlign.MIDDLE, 0x9d9d9d);
	}

	public function getFormat(state : String, action : String) : ITextLayoutFormat {
		switch (state) {
			case "selected" : 
				return _selected; 
				break;
			case "disable" : 
				return _disable; 
				break;
			default :
				switch (action) {
					case "over" : 
						return _over; 
						break;
					case "down" : 
						return _down; 
						break;
					default : 
						return _default; 
						break; 
				}
				break;
		}
	}
}
