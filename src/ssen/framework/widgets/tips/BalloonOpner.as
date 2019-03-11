package ssen.framework.widgets.tips {
import ssen.core.draw.material.IDrawMaterial;
import ssen.core.draw.material.IDrawMaterialSet;
import ssen.core.draw.material.ITextFormatSet;
import ssen.core.draw.material.LinerGradientMaterial;
import ssen.framework.service.SS;
import ssen.framework.ss_internal;
import ssen.framework.widgets.core.IDisplayWidget;
import ssen.framework.widgets.core.Widget;
import ssen.styles.flour.btn.FlourBtnStyleSet;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.JointStyle;

use namespace ss_internal;

/**
 * @author ssen (i@ssen.name)
 */
public class BalloonOpner extends Widget {
	private var g : Group;

	/* *********************************************************************
	 * default setting 
	 ********************************************************************* */
	protected function getBtnMaterial() : IDrawMaterialSet {
		return FlourBtnStyleSet.material;
	}

	protected function getLableFormat() : ITextFormatSet {
		return FlourBtnStyleSet.formats;
	}

	protected function getBalloonMaterial() : IDrawMaterial {
		var stroke : GraphicsStroke = new GraphicsStroke(1, true);
		stroke.joints = JointStyle.MITER;
		stroke.fill = new GraphicsSolidFill(0x7d7d7d);
		return new LinerGradientMaterial([0xffffff, 0xeeeeee], null, null, 90, stroke);
	}

	protected function getContent() : IDisplayWidget {
		return new TestContent();
	}

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	/** @private */
	override protected function wconstruct() : void {
		g = new Group();
		g.btn = new Button();
		g.btn.construct();
		g.btnInteraction = new ButtonInteraction(g);
		g.balloon = new Balloon(g);
		g.balloon.construct();
		g.content = getContent();
		g.content.construct();
	}

	/** setting */
	public function setting_BalloonOpner(service : DisplayObjectContainer = null, index : int = -1, state : String = "run", 
										width : int = 100, // 0
										height : int = 30, // 1
										lableText : String = "open", // 2
										btnAutoSize : Boolean = false, // 3
										balloonDirection : int = 2 // 4
										) : void {
		setting(service, index, state, width, height, lableText, btnAutoSize, balloonDirection);
	}

	/** @private */
	override protected function wsetting(config : Array) : void {
		g.btn.setting_LableBtn(service, index, state, config[2], getLableFormat(), null, config[3], config[0], config[1], getBtnMaterial(), g.btnInteraction);
		g.direction = config[4];
		g.balloon.setting(null, -1, state, getBalloonMaterial());
		g.content.setting.apply(null, [g.balloon.container(), -1, state].concat(config));
	}

	/** @private */
	override protected function wregister() : void {
		g.btn.register();
	}

	/** @private */
	override protected function wderegister() : void {
		g.btn.deregister();
	}

	/** @private */
	override protected function wunsetting() : void {
		g.btn.unsetting();
		g.balloon.unsetting();
		g.content.unsetting();
	}

	/** @private */
	override protected function wdeconstruct() : void {
		g.btn.deconstruct();
		g.balloon.deconstruct();
		g.content.deconstruct();
		g.btn = null;
		g.balloon = null;
		g.content = null;
		g = null;
	}

	/* *********************************************************************
	 * implement
	 ********************************************************************* */
	/** @private */
	override public function set state(state : String) : void {
		super.state = state;
		g.btn.state = state;
		g.balloon.state = state;
		g.content.state = state;
	}

	/** @private */
	override protected function disable() : void {
		close();
	}

	/** @private */
	override protected function run() : void {
		// TODO run 상태로 진입할때의 처리
	}

	/** @private */
	override ss_internal function get display() : DisplayObject {
		return g.btn.display;
	}

	/* *********************************************************************
	 * after setted 
	 ********************************************************************* */
	public function get x() : Number {
		return g.btn.x;
	}

	public function set x(x : Number) : void {
		g.btn.x = x;
	}

	public function get y() : Number {
		return g.btn.y;
	}

	public function set y(y : Number) : void {
		g.btn.y = y;
	}

	public function get width() : Number {
		return g.btn.width;
	}

	public function set width(width : Number) : void {
		g.btn.width = width;
	}

	public function get height() : Number {
		return g.btn.height;
	}

	public function set height(height : Number) : void {
		g.btn.height = height;
	}

	public function get text() : String {
		return g.btn.lableText;
	}

	public function set text(text : String) : void {
		g.btn.lableText = text;
	}

	protected function close() : void {
		if (g.balloon.registered) {
			SS.tip.close();
			g.btnInteraction.draw();
		}
	}
}
}

import net.kawa.tween.KTween;
import net.kawa.tween.easing.Quad;

import ssen.core.DisplayX;
import ssen.core.draw.TailBox;
import ssen.core.geom.Direction;
import ssen.framework.service.SS;
import ssen.framework.ss_internal;
import ssen.framework.widgets.btns.BtnInteraction;
import ssen.framework.widgets.btns.LableBtn;
import ssen.framework.widgets.core.IDisplayWidget;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.tips.ITipObject;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Point;

class Group {
	internal var btn : Button;
	internal var btnInteraction : ButtonInteraction;
	internal var balloon : Balloon;
	internal var direction : int;
	internal var content : IDisplayWidget;
}

class Button extends LableBtn {
	public function get stagePos() : Point {
		var pos : Point = DisplayX.getStagePos(sprite);
		pos.x += width >> 1;
		pos.y += height >> 1;
		return pos;
	}
}

class TestContent extends SpriteWidget {
	private var _width : int;
	private var _height : int;

	override protected function wsetting(config : Array) : void {
		_width = 150;
		_height = 200;
	}

	override protected function wregister() : void {
		graphics.beginFill(0x000000, 0.4);
		graphics.drawRect(0, 0, _width, _height);
		graphics.endFill();
		
		addToService();
		
		startAnimation("appare");
	}

	override protected function wderegister() : void {
		graphics.clear();
		
		removeFromService();
	}

	override public function get width() : Number {
		return _width;
	}

	override public function get height() : Number {
		return _height;
	}

	override protected function startAnimation(scene : String) : void {
		super.startAnimation(scene);
		
		switch (scene) {
			case "appare" :
				sprite.alpha = 0;
				KTween.to(sprite, 0.3, {alpha:1}, Quad.easeOut);
				break;
		}
	}
}

class Balloon extends SpriteWidget implements ITipObject {
	private var _tail : TailBox;
	private var _sx : Number;
	private var _sy : Number;
	private var _ex : Number;
	private var _ey : Number;
	private var _sw : Number;
	private var _ew : Number;
	private var _sh : Number;
	private var _eh : Number;
	private var _tsx : Number;
	private var _tex : Number;
	private var _tsy : Number;
	private var _tey : Number;
	private var _draw : Number;
	private var g : Group;

	public function Balloon(g : Group) {
		this.g = g;
	}

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	/** @private */
	override protected function wconstruct() : void {
		super.wconstruct();
		_tail = new TailBox(new Point);
	}

	/** @private */
	override protected function wsetting(config : Array) : void {
		_tail.material = config[0];
	}

	/** @private */
	override protected function wregister() : void {
		addToService();
		sprite.filters = [new DropShadowFilter(3, 90, 0, 0.2, 6, 6)];
		startAnimation("appare");
	}

	private function stageClick(event : MouseEvent) : void {
		//trace(this, event.stageX < _ex || event.stageX > _ex + _ew || event.stageY < _ey || event.stageY > _ey + _eh);
		if (event.stageX < _ex || event.stageX > _ex + _ew || event.stageY < _ey || event.stageY > _ey + _eh) {
			SS.tip.close();
			g.btnInteraction.draw();
		}
	}

	/** @private */
	override protected function wderegister() : void {
		startAnimation("disappare");
		g.btnInteraction.draw();
		SS.stage.removeEventListener(MouseEvent.CLICK, stageClick);
	}

	/** @private */
	override protected function wunsetting() : void {
		super.wunsetting();
		_tail.material = null;
	}

	/** @private */
	override protected function wdeconstruct() : void {
		super.wdeconstruct();
		_tail = null;
	}

	/* *********************************************************************
	 * special implement 
	 ********************************************************************* */
	/** service */
	override ss_internal function get service() : DisplayObjectContainer {
		return SS.tip.service;
	}

	/** index */
	override ss_internal function get index() : int {
		return 0;
	}

	override protected function startAnimation(scene : String) : void {
		super.startAnimation(scene);
		
		switch (scene) {
			case "appare" :
				var center : Point = g.btn.stagePos;
				var cx : int = center.x;
				var cy : int = center.y;
				var bhw : int = g.btn.width >> 1;
				var bhh : int = g.btn.height >> 1;
				
				var createPos : Function = function(d : int) : void {
					g.direction = d;
					switch (d) {
						case Direction.TOP :
							_ex = -(_ew >> 1) + cx;
							_ey = -(_eh + bhh + 15) + cy;
							_tex = cx;
							_tey = -(bhh + 5) + cy;
							break;
						case Direction.RIGHT :
							_ex = bhw + 15 + cx;
							_ey = -(_eh >> 1) + cy;
							_tex = bhw + 5 + cx;
							_tey = cy;
							break;
						case Direction.BOTTOM :
							_ex = -(_ew >> 1) + cx;
							_ey = bhh + 15 + cy;
							_tex = cx;
							_tey = bhh + 5 + cy;
							break;
						case Direction.LEFT :
							_ex = -(_ew + bhw + 15) + cx;
							_ey = -(_eh >> 1) + cy;
							_tex = -(bhw + 5) + cx;
							_tey = cy;
							break;
					}
				};
				
				_ew = g.content.width + 20;
				_eh = g.content.height + 20;
				_sx = cx - bhw;
				_sy = cy - bhh;
				_sw = g.btn.width;
				_sh = g.btn.height;
				_tsx = cx;
				_tsy = cy;
				
				createPos(g.direction);
				
				if (g.direction == Direction.TOP && _ey < 0) createPos(Direction.BOTTOM);
				if (g.direction == Direction.BOTTOM && _ey + _eh > SS.sh) createPos(Direction.TOP);
				if (g.direction == Direction.LEFT && _ex < 0) createPos(Direction.RIGHT);
				if (g.direction == Direction.RIGHT && _ex + _ew > SS.sw) createPos(Direction.LEFT);
				
				switch (g.direction) {
					case Direction.TOP : 
					case Direction.BOTTOM :
						if (_ex < 0) _ex = 10;
						if (_ex + _ew > SS.sw) _ex = SS.sw - _ew - 10;
						break;
					case Direction.LEFT : 
					case Direction.RIGHT :
						if (_ey < 0) _ey = 10;
						if (_ey + _eh > SS.sh) _ey = SS.sh - _eh - 10;
						break;
				}
				
				draw = 0;
				sprite.alpha = 0;
				
				KTween.to(this, 0.2, {draw:1}, Quad.easeOut, endAnimation);
				break;
			case "disappare" :
				KTween.to(sprite, 0.2, {alpha:0}, Quad.easeOut, endAnimation);
				break;
		}
	}

	override protected function endAnimation() : void {
		switch (animationScene) {
			case "appare" :
				g.content.x = _ex + 10;
				g.content.y = _ey + 10;
				g.content.register();
				
				SS.stage.addEventListener(MouseEvent.CLICK, stageClick);
				
				break;
			case "disappare" :
				g.content.deregister(); 
				removeFromService();
				sprite.filters = [];
				break;
		}
		
		super.endAnimation();
	}

	public function get draw() : Number {
		return _draw;
	}

	public function set draw(draw : Number) : void {
		graphics.clear();
		
		_draw = draw;
		_tail.width = ((_ew - _sw) * draw) + _sw;
		_tail.height = ((_eh - _sh) * draw) + _sh;
		_tail.x = ((_ex - _sx) * draw) + _sx;
		_tail.y = ((_ey - _sy) * draw) + _sy;
		_tail.tailPoint.x = ((_tex - _tsx) * draw) + _tsx;
		_tail.tailPoint.y = ((_tey - _tsy) * draw) + _tsy;
		_tail.draw(graphics);
		sprite.alpha = draw;
	}

	public function container() : Sprite {
		return sprite;
	}
}

class ButtonInteraction extends BtnInteraction {
	private var g : Group;

	public function ButtonInteraction(g : Group) {
		this.g = g;
	}

	override protected function wdeconstruct() : void {
		super.wdeconstruct();
		g = null;
	}

	/* *********************************************************************
	 * implement btn interaction
	 ********************************************************************* */
	/** @private */
	override ss_internal function get drawState() : String {
		if (state == WidgetState.RUN && g.balloon.registered) {
			return "selected";
		} else {
			return state;
		}
	}

	/** @private */
	override protected function eventOn() : void {
		_sprite.buttonMode = true;
		_sprite.mouseEnabled = true;
		_sprite.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		_sprite.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		_sprite.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		_sprite.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		_sprite.addEventListener(MouseEvent.CLICK, click);
	}

	/** @private */
	override protected function eventOff() : void {
		_sprite.buttonMode = false;
		_sprite.mouseEnabled = false;
		_sprite.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		_sprite.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		_sprite.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		_sprite.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		_sprite.removeEventListener(MouseEvent.CLICK, click);
	}

	/* *********************************************************************
	 * interaction
	 ********************************************************************* */
	private function click(event : MouseEvent) : void {
		if (g.balloon.state == WidgetState.ANIMATED) return;
		if (!g.balloon.registered) {
			SS.tip.open(g.balloon);
		} else {
			SS.tip.close();
		}
		setDrawState();
	}

	private function mouseUp(event : MouseEvent) : void {
		if ((_sprite.mouseX > 0 && _sprite.mouseX < _button.width) && (_sprite.mouseY > 0 && _sprite.mouseY < _button.height)) {
			setDrawAction("over");
		} else {
			setDrawAction("default");
		}
	}

	private function mouseDown(event : MouseEvent) : void {
		setDrawAction("down");
	}

	private function mouseOut(event : MouseEvent) : void {
		setDrawAction("default");
	}

	private function mouseOver(event : MouseEvent) : void {
		if (event.buttonDown) {
			setDrawAction("down");
		} else {
			setDrawAction("over");
		}
	}

	public function draw() : void {
		setDrawState();
		setDrawAction();
	}
}
