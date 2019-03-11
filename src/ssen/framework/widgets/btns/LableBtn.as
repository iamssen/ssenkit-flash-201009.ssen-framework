package ssen.framework.widgets.btns {
import flashx.textLayout.compose.TextLineRecycler;
import flashx.textLayout.factory.StringTextLineFactory;
import flashx.textLayout.factory.TruncationOptions;

import ssen.core.draw.material.IDrawMaterialSet;
import ssen.core.draw.material.ITextFormatSet;
import ssen.core.geom.Padding;
import ssen.framework.errors.ImplementationError;
import ssen.framework.errors.WidgetFlowError;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.selection.SelectionGroup;
import ssen.styles.flour.btn.FlourBtnStyleSet;

import flash.display.DisplayObjectContainer;
import flash.geom.Rectangle;
import flash.text.engine.TextLine;

/**
 * lable 버튼
 * @includeExample BtnTest.as
 * @includeExample BtnVerify.as
 * @author ssen (i@ssen.name)
 */
public class LableBtn extends Btn {
	private var _lableText : String;
	private var _lableFormats : ITextFormatSet;
	private var _lablePadding : Padding;
	private var _fac : StringTextLineFactory;
	private var _lines : Vector.<TextLine>;
	private var _autoSize : Boolean;

	/* *********************************************************************
	 * default setting 
	 ********************************************************************* */
	/** 기본 text format */
	protected function getLableFormats() : ITextFormatSet {
		return FlourBtnStyleSet.formats;
	}

	/** 기본 padding */
	protected function getLablePadding() : Padding {
		return new Padding(0, 0, 10, 10);
	}

	protected function getTruncationOptions() : TruncationOptions {
		return new TruncationOptions("", 1);
	}

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	/** @private */
	override protected function wconstruct() : void {
		super.wconstruct();
		_fac = new StringTextLineFactory();
		_fac.truncationOptions = getTruncationOptions();
		_lines = new Vector.<TextLine>();
	}

	/** setting */
	public function setting_LableBtn(service : DisplayObjectContainer = null, index : int = -1, state : String = "run", 
		lableText : String = "button",
		lableFormats : ITextFormatSet = null, 
		lablePadding : Padding = null,
		lableAutoSize : Boolean = true,
		width : int = 100, // 0 
		height : int = 30, // 1
		boxMaterial : IDrawMaterialSet = null, // 2 
		interaction : BtnInteraction = null, // 3
		doubleClickTime : int = 200, // 4
		longDownEnable : Boolean = false, // 5 
		longDownTime : int = 4000, // 6
		toggle : Boolean = false, // 7
		selectionGroup : SelectionGroup = null, // 8 
		selection : Boolean = false, // 9
		selectionValue : Object = null // 10
		) : void {
		setting(service, index, state, width, height, boxMaterial, interaction, doubleClickTime, longDownEnable, longDownTime, toggle, selectionGroup, selection, selectionValue, lableText, lableFormats, lablePadding, lableAutoSize);
	}

	/** 작동하지 않음, setting_LableBtn 을 사용 */
	override public function setting_Btn(service : DisplayObjectContainer = null, index : int = -1, state : String = "run", width : int = 100, height : int = 30, boxMaterial : IDrawMaterialSet = null, interaction : BtnInteraction = null, doubleClickTime : int = 200, longDownEnable : Boolean = false, longDownTime : int = 4000, toggle : Boolean = false, selectionGroup : SelectionGroup = null, selection : Boolean = false, selectionValue : Object = null) : void {
		throw new ImplementationError("setting_LableBtn 을 사용해야함");
	}

	/**
	 * config[0] width : int<br />
	 * config[1] height : int<br />
	 * config[2] boxMaterial : IDrawMaterial<br />
	 * config[3] interaction : BtnInteraction<br />
	 * config[4] doubleClickTime : int<br />
	 * config[5] longDownEnable : Boolean<br />
	 * config[6] longDownTime : int<br />
	 * config[7] toggle : Boolean<br />
	 * config[8] selectionGroup : SelectionGroup<br />
	 * config[9] selection : Boolean<br />
	 * config[10] selectionValue : Object<br />
	 * config[11] lableText : String<br />
	 * config[12] lableFormats : ITextFormatSet<br />
	 * config[13] lablePadding : Padding<br />
	 * config[14] lableAutoSize : boolean
	 */
	override protected function wsetting(config : Array) : void {
		_lableText = config[11];
		_lableFormats = config[12] || getLableFormats();
		_lablePadding = config[13] || getLablePadding();
		_autoSize = config[14];
		
		super.wsetting(config);
	}

	/** @private */
	override protected function wderegister() : void {
		removeTextLine();
		super.wderegister();
	}

	/** @private */
	override protected function wunsetting() : void {
		_lableFormats = null;
		_lablePadding = null;
		super.wunsetting();
	}

	/** @private */
	override protected function wdeconstruct() : void {
		super.wdeconstruct();
		_fac = null;
	}

	/* *********************************************************************
	 * text 
	 ********************************************************************* */
	/** lable 의 text {setting} */
	public function get lableText() : String {
		return setted ? _lableText : WidgetState.NOT_SETTED;
	}

	public function set lableText(text : String) : void {
		if (!setted) throw new WidgetFlowError(this, "lableText 는 setting 이후에 설정 가능합니다.");
		_lableText = text;
		if (registered) {
			setInvalid("draw", true);
			rendering();
		}
	}

	/* *********************************************************************
	 * rendering 
	 ********************************************************************* */
	/** @private */
	override protected function rendering() : void {
		if (getInvalid("size") || getInvalid("draw")) {
			createTextLine(drawState, drawAction);
			if (_autoSize) {
				var w : int = 0;
				var f : int = _lines.length;
				var x : int = 0;
				while (--f >= 0) {
					if (_lines[f].width > w) {
						w = _lines[f].width;
						x = _lines[f].x - _lablePadding.left; 
					}
				}
				f = _lines.length;
				while(--f >= 0) {
					_lines[f].x -= x;
				}
				_width = w + _lablePadding.leftAndRight;
			}
		}
		super.rendering();
	}

	private function createTextLine(state : String, action : String) : void {
		removeTextLine();
		_fac.text = _lableText;
		_fac.textFlowFormat = _lableFormats.getFormat(state, action);
		var bounds : Rectangle = new Rectangle();
		if (_autoSize) {
			bounds.left = _lablePadding.left;
			bounds.top = _lablePadding.top;
			bounds.width = 1000;
			bounds.height = height - _lablePadding.topAndBottom;
		} else {
			bounds.left = _lablePadding.left;
			bounds.top = _lablePadding.top;
			bounds.width = width - _lablePadding.leftAndRight;
			bounds.height = height - _lablePadding.topAndBottom;
		}
		_fac.compositionBounds = bounds;
		_fac.createTextLines(createdTextLine);
	}

	private function createdTextLine(line : TextLine) : void {
		_lines.push(line);
		sprite.addChild(line);
	}

	private function removeTextLine() : void {
		var f : int = _lines.length;
		var line : TextLine;
		while (--f >= 0) {
			line = _lines[f];
			sprite.removeChild(line);
			TextLineRecycler.addLineForReuse(line);
		}
		_lines.length = 0;
	}
}
}
