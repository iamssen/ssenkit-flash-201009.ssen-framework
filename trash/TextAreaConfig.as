package ssen.framework.widgets.input {
import ssen.framework.widgets.scroll.ScrollPaneBaseConfig;

import flashx.textLayout.formats.ITextLayoutFormat;

/**
 * @author ssen (i@ssen.name)
 */
public class TextAreaConfig extends ScrollPaneBaseConfig {
	public function TextAreaConfig(width : int = 100, height : int = 100) {
		initConfig(width, height);
		
		this.initScrollV = 1;
		this.initScrollH = 0;
	}

	override public function scrollConfig(vScrollEnabled : Boolean = true, hScrollEnabled : Boolean = true, initScrollV : Number = 0, initScrollH : Number = 0) : void {
		super.scrollConfig(vScrollEnabled, hScrollEnabled, initScrollV, initScrollH);
		if (this.initScrollV < 1) this.initScrollV = 1;
		if (this.initScrollH < 0) this.initScrollH = 0;
	}

	public var text : String = "";
	public var initText : String = "";
	public var mouseWheelEnabled : Boolean = true;
	public var wordWrap : Boolean = true;

	public function textConfig(text : String = "", initText : String = "", wordWrap : Boolean = true, mouseWheelEnabled : Boolean = true) : void {
		this.text = text;
		this.initText = initText;
		this.wordWrap = wordWrap;
		this.mouseWheelEnabled = mouseWheelEnabled;
	}

	public var editingMode : String = "readWrite";
	public var type : String = "all";

	public function editConfig(editingMode : String, type : String = "all") : void {
		this.editingMode = editingMode;
		this.type = type;
	}

	public var textFormat : ITextLayoutFormat;
	public var disableColor : uint;

	public function formatConfig(textFormat : ITextLayoutFormat, disableColor : uint) : void {
		this.textFormat = textFormat;
		this.disableColor = disableColor;
	}
}
}
