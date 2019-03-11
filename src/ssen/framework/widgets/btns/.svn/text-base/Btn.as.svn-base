package ssen.framework.widgets.btns {
import ssen.core.draw.PathMaker;
import ssen.core.draw.material.IDrawMaterialSet;
import ssen.framework.errors.WidgetFlowError;
import ssen.framework.ss_internal;
import ssen.framework.widgets.core.InvalidSpriteWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.selection.ISelectionItem;
import ssen.framework.widgets.selection.SelectionGroup;
import ssen.framework.widgets.togglers.IToggler;
import ssen.styles.flour.btn.FlourBtnStyleSet;

import flash.display.DisplayObjectContainer;

use namespace ss_internal;

/**
 * 버튼
 * @includeExample BtnTest.as
 * @includeExample BtnVerify.as
 * @includeExample BtnCaseTest.as
 * @author ssen (i@ssen.name)
 */
public class Btn extends InvalidSpriteWidget implements IToggler, ISelectionItem {
	protected var _width : Number;
	protected var _height : Number;
	private var _boxMaterial : IDrawMaterialSet;
	private var _interaction : BtnInteraction;
	private var _drawState : String;
	private var _drawAction : String;

	/* *********************************************************************
	 * default setting 
	 ********************************************************************* */
	/** [DEFAULT] box material */
	protected function getBoxMaterial() : IDrawMaterialSet {
		return FlourBtnStyleSet.material;
	}

	/** 
	 * [DEFAULT] interaction
	 * @default ClickBtnInteraction
	 */
	protected function getInteraction() : BtnInteraction {
		return new ClickBtnInteraction();
	}

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	/** setting */
	public function setting_Btn(service : DisplayObjectContainer = null, index : int = -1, state : String = "run", 
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
		setting(service, index, state, width, height, boxMaterial, interaction, doubleClickTime, longDownEnable, longDownTime, toggle, selectionGroup, selection, selectionValue);
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
	 * config[10] selectionValue : Object
	 */
	override protected function wsetting(config : Array) : void {
		_boxMaterial = config[2] || getBoxMaterial();
		_interaction = config[3] || getInteraction();
		if (!_interaction.constructed) _interaction.construct();
		_interaction.setting(null, -1, super.state, this, config);
			
		_width = config[0];
		_height = config[1];
		_drawState = _interaction.drawState;
		_drawAction = _interaction.drawAction;
	}

	/** @private */
	override protected function wregister() : void {
		_interaction.register();
		setInvalid("size", true);
		setInvalid("draw", true);
		addToService();
		rendering();
	}

	/** @private */
	override protected function wderegister() : void {
		_interaction.deregister();
		removeFromService();
		clearInvalid();
		graphics.clear();
	}

	/** @private */
	override protected function wunsetting() : void {
		super.wunsetting();
		_boxMaterial = null;
		unsetInvalidate();
		_interaction.unsetting();
		_interaction.deconstruct();
		_interaction = null;
	}

	/* *********************************************************************
	 * state
	 ********************************************************************* */
	/** @private */
	final override public function get state() : String {
		return setted ? _interaction.state : WidgetState.NOT_SETTED;
	}

	/** @private */
	final override public function set state(state : String) : void {
		_interaction.state = state;
	}

	/* *********************************************************************
	 * api 
	 ********************************************************************* */
	/** 가로 사이즈 */
	override public function get width() : Number {
		return setted ? _width : 0;
	}

	public function set width(width : Number) : void {
		if (!setted) throw new WidgetFlowError(this, "width 는 setting 이후에 설정 가능합니다.");
		_width = width;
		if (registered) setInvalid("size", true);
	}

	/** 세로 사이즈 */
	override public function get height() : Number {
		return setted ? _height : 0;
	}

	public function set height(height : Number) : void {
		if (!setted) throw new WidgetFlowError(this, "height 는 setting 이후에 설정 가능합니다.");
		_height = height;
		if (registered) setInvalid("size", true);
	}

	/* *********************************************************************
	 * implements IToggler 
	 ********************************************************************* */
	/** @inheritDoc */
	final public function get toggle() : Boolean {
		if (_interaction is ToggleBtnInteraction) return ToggleBtnInteraction(_interaction).toggle;
		return false;
	}

	final public function set toggle(toggle : Boolean) : void {
		if (!setted) throw new WidgetFlowError(this, "toggle is runtime setter");
		if (_interaction is ToggleBtnInteraction) ToggleBtnInteraction(_interaction).toggle = toggle;
	}

	/* *********************************************************************
	 * implements ISelectionItem 
	 ********************************************************************* */
	/** @inheritDoc */
	final public function get selection() : Boolean {
		if (_interaction is SelectionBtnInteraction) return SelectionBtnInteraction(_interaction).selection;
		return false;
	}

	final public function set selection(selection : Boolean) : void {
		if (!setted) throw new WidgetFlowError(this, "selection is runtime setter");
		if (_interaction is SelectionBtnInteraction) SelectionBtnInteraction(_interaction).selection = selection;
	}

	/** @inheritDoc */
	final public function get selectionValue() : Object {
		if (_interaction is SelectionBtnInteraction) return SelectionBtnInteraction(_interaction).value;
		return null;
	}

	/* *********************************************************************
	 * rendering
	 ********************************************************************* */
	/** @private */
	ss_internal function setDrawState() : void {
		if (_interaction.drawState != _drawState) {
			_drawState = _interaction.drawState;
			setInvalid("draw", true);
		}
	}

	/** @private */
	ss_internal function setDrawAction() : void {
		if (_interaction.drawAction != _drawAction) {
			_drawAction = _interaction.drawAction;
			setInvalid("draw", true);
		}
	}

	protected function get drawState() : String {
		return _drawState;
	}

	protected function get drawAction() : String {
		return _drawAction;
	}

	/** @private */
	override protected function rendering() : void {
		if (getInvalid("size") || getInvalid("draw")) {
			graphics.clear();
			_boxMaterial.draw(drawState, drawAction, graphics, 0, 0, width, height, PathMaker.rect(0, 0, width, height));
		}
		clearInvalid();
	}
}
}