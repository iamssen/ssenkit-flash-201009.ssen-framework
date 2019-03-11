package ssen.framework.widgets.btns {
import ssen.core.draw.Rect;
import ssen.core.draw.material.IDrawMaterialSet;
import ssen.core.draw.material.ITextFormatSet;
import ssen.core.draw.material.SolidMaterial;
import ssen.core.geom.Padding;
import ssen.framework.errors.ImplementationError;
import ssen.framework.widgets.selection.SelectionGroup;

import flash.display.DisplayObjectContainer;
import flash.display.GraphicsSolidFill;

/**
 * @author ssen (i@ssen.name)
 */
public class SymbolBtn extends LableBtn {
	private var _symbol : Rect;
	private var _padding : Padding;

	protected function getSymbol() : Rect {
		var rect : Rect = new Rect(0, 0, 10, 10, new SolidMaterial(new GraphicsSolidFill(0x000000, 0.3)));
		return rect;
	}

	/** setting */
	public function setting_SymbolBtn(service : DisplayObjectContainer = null, index : int = -1, state : String = "run",
		symbol : Rect = null,
		symbolMarginRight : int = 3,
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
		setting(service, index, state, width, height, boxMaterial, interaction, doubleClickTime, longDownEnable, longDownTime, toggle, selectionGroup, selection, selectionValue, lableText, lableFormats, lablePadding, lableAutoSize, symbol, symbolMarginRight);
	}

	override public function setting_LableBtn(service : DisplayObjectContainer = null, index : int = -1, state : String = "run", lableText : String = "button", lableFormats : ITextFormatSet = null, lablePadding : Padding = null, lableAutoSize : Boolean = true, width : int = 100, height : int = 30, boxMaterial : IDrawMaterialSet = null, interaction : BtnInteraction = null, doubleClickTime : int = 200, longDownEnable : Boolean = false, longDownTime : int = 4000, toggle : Boolean = false, selectionGroup : SelectionGroup = null, selection : Boolean = false, selectionValue : Object = null) : void {
		throw new ImplementationError("setting_SymbolBtn 을 사용해야함");
	}

	override protected function wsetting(config : Array) : void {
		_symbol = config[15] || getSymbol();
		_padding = config[13] != null ? Padding(config[13]).clone() : getLablePadding();
		_symbol.x = _padding.left;
		_padding.left += _symbol.width + config[16];
		
		config[13] = _padding;
		super.wsetting(config);
	}

	override protected function wunsetting() : void {
		_padding = null;
		super.wunsetting();
	}

	override protected function wdeconstruct() : void {
		super.wdeconstruct();
		_symbol.deconstruct();
		_symbol = null;
	}

	override protected function rendering() : void {
		var draw : Boolean = getInvalid("size") || getInvalid("draw");
		super.rendering();
		if (draw) {
			_symbol.y = ((_height - _padding.topAndBottom) >> 1) - (_symbol.height >> 1) + _padding.top;
			_symbol.draw(graphics, drawState, drawAction);
		}
	}
}
}
