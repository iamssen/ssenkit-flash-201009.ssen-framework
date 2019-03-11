package ssen.debug.autocase {
import flashx.textLayout.compose.TextLineRecycler;
import flashx.textLayout.factory.StringTextLineFactory;
import flashx.textLayout.formats.TextAlign;
import flashx.textLayout.formats.TextLayoutFormat;
import flashx.textLayout.formats.VerticalAlign;

import ssen.core.draw.Rect;
import ssen.core.draw.material.BitmapMaterial;
import ssen.debug.tostr;
import ssen.framework.errors.ImplementationError;
import ssen.framework.service.SS;
import ssen.framework.widgets.core.IWidget;
import ssen.framework.widgets.core.InvalidSpriteWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.styles.flour.FlourTextFormatFactory;

import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.geom.Rectangle;
import flash.text.engine.TextLine;

/**
 * case test 자동화
 * @author ssen (i@ssen.name)
 */
public class AutoCase extends InvalidSpriteWidget {

	[Embed(source="asset/flow_back.png")]
	private static var backImage : Class;

	[Embed(source="asset/flow_state0.png")]
	private static var state0Image : Class;

	[Embed(source="asset/flow_state1.png")]
	public static var state1Image : Class;
	private var _back : Rect;
	private var _state0 : Rect;
	private var _state1 : Rect;
	private var _state : int = -1;
	private var _stateFac : StringTextLineFactory;
	private var _stateLines : Vector.<TextLine>;
	private var _state0Format : TextLayoutFormat;
	private var _state1Format : TextLayoutFormat;
	private var _stateString : Vector.<String>;
	private var _btns : Vector.<Vector.<CommandBtn>>;
	private var _widget : IWidget;

	/* *********************************************************************
	 * abstract 
	 ********************************************************************* */
	/** 테스트 대상이 되는 Widget 을 만든다 */
	protected function getWidget() : IWidget {
		throw new ImplementationError();
	}

	/** Widget setting */
	protected function setWidget(widget : IWidget) : void {
		widget.setting(sprite, 0, WidgetState.RUN);
	}

	/** setted time 과 registered time 에 활성화 될 command 들 */
	protected function getSettedTimeCommand() : Vector.<ICaseCommand> {
		return null;
	}

	/** registered time 에 활성화 될 command 들 */
	protected function getRegisteredTimeCommand() : Vector.<ICaseCommand> {
		return null;
	}

	/** widget 에 걸어줄 event list */
	protected function getInteractions() : Vector.<String> {
		return null;
	}

	/** trace 시킬 리스트들 */
	protected function traceState() : void {
		str("not implement", []);
	}

	/** widget 의 상태를 trace 시켜준다 */
	final protected function str(msg : String, states : Array) : void {
		var t : Object = {};
		var f : int = -1;
		while(++f < states.length) {
			t[states[f]] = _widget[states[f]];
		}
		t["state"] = _widget.state;
		t["constructed"] = _widget.constructed;
		t["setted"] = _widget.setted;
		t["registered"] = _widget.registered;
		tostr(msg, t, true);
	}

	private function traceInteraction(event : Event) : void {
		trace(event);
		trace("--------------------------------------------------------");
	}

	/* *********************************************************************
	 * implement widget flow 
	 ********************************************************************* */
	/** @private */
	final override protected function wconstruct() : void {
		super.wconstruct();
		_widget = getWidget();
		_back = new Rect(0, 0, 100, 16, new BitmapMaterial(new backImage().bitmapData));
		_state0 = new Rect(0, 0, 150, 15, new BitmapMaterial(new state0Image().bitmapData, false, new Rectangle(10, 0, 10, 15)));
		_state1 = new Rect(0, 0, 150, 15, new BitmapMaterial(new state1Image().bitmapData, false, new Rectangle(10, 0, 10, 15)));
		_state0Format = FlourTextFormatFactory.getEmbedSansSerif(10, TextAlign.CENTER, VerticalAlign.MIDDLE, 0x999999);
		_state1Format = FlourTextFormatFactory.getEmbedSansSerif(10, TextAlign.CENTER, VerticalAlign.MIDDLE, 0x000000);
		_stateFac = new StringTextLineFactory();
		_stateLines = new Vector.<TextLine>();
		_stateString = Vector.<String>(["null", "constructed", "setted", "registered"]);
		_btns = Vector.<Vector.<CommandBtn>>([new Vector.<CommandBtn>, new Vector.<CommandBtn>, new Vector.<CommandBtn>, new Vector.<CommandBtn>]);
		_btns[0].push(createBtn(new FlowCommand("construct")));
		_btns[1].push(createBtn(new FlowCommand("deconstruct")), createBtn(new FlowCommand("setting")));
		_btns[2].push(createBtn(new FlowCommand("unsetting")), createBtn(new FlowCommand("register")), createBtn(new FlowCommand("setting")));
		_btns[3].push(createBtn(new FlowCommand("deregister")));
		
		var f : int;
		var state : Vector.<ICaseCommand> = getSettedTimeCommand();
		if (!state) state = new Vector.<ICaseCommand>();
		state.push(new CaseState("state", new Random([WidgetState.RUN, WidgetState.DISABLE])));
		if (state && state.length > 0) {
			f = -1;
			while(++f < state.length) {
				_btns[2].push(createBtn(state[f]));
				_btns[3].push(createBtn(state[f]));
			}
		}
		var order : Vector.<ICaseCommand> = getRegisteredTimeCommand();
		if (order && order.length > 0) {
			f = -1;
			while(++f < order.length) {
				_btns[3].push(createBtn(order[f]));
			}
		}
		
		var ints : Vector.<String> = getInteractions();
		if (ints && ints.length > 0 && _widget is IEventDispatcher) {
			var evtd : IEventDispatcher = IEventDispatcher(_widget);
			f = -1;
			while(++f < ints.length) {
				evtd.addEventListener(ints[f], traceInteraction);
			}
		}
	}

	/** @private */
	final override protected function wsetting(config : Array) : void {
		setState(0);
	}

	/** @private */
	final override protected function wregister() : void {
		var f : int = -1;
		var s : int;
		var btn : CommandBtn;
		while(++f < _btns.length) {
			s = _btns[f].length;
			while (--s >= 0) {
				btn = _btns[f][s];
				btn.register();
			}
		}
		
		SS.stage.addEventListener(Event.RESIZE, resize);
		resize();
		
		addToService();
	}

	/** @private */
	final override protected function wderegister() : void {
		clearLines();
		graphics.clear();
		
		removeFromService();
	}

	/** @private */
	final override protected function wunsetting() : void {
		super.unsetting();
		unsetInvalidate();
		// TODO
	}

	/** @private */
	final override protected function wdeconstruct() : void {
		super.wdeconstruct();
		_back.deconstruct();
		_state0.deconstruct();
		_state1.deconstruct();
		_back = null;
		_state0 = null;
		_state1 = null;
		_state0Format = null;
		_state1Format = null;
		_stateFac = null;
		_stateString = null;
	}

	/* *********************************************************************
	 * utils 
	 ********************************************************************* */
	private function createBtn(cmd : ICaseCommand) : CommandBtn {
		var btn : CommandBtn = new CommandBtn();
		btn.construct();
		btn.setting(sprite, -1, WidgetState.RUN, cmd, this);
		return btn;
	}

	/** @private */
	final public function command(cmd : ICaseCommand) : void {
		trace(cmd.displayName);
		if (cmd is FlowCommand) {
			var flow : FlowCommand = FlowCommand(cmd);
			switch (flow.name) {
				case "deconstruct" :
					_widget.deconstruct();
					setState(0); 
					break;
				case "construct" : 
					_widget.construct();
					setState(1);
					break;
				case "unsetting" :
					_widget.unsetting();
					setState(1);
					break; 
				case "setting" :
					setWidget(_widget);
					//_widget.setting(getSetting(), sprite, 0);
					traceState();
					setState(2);
					break;
				case "deregister" :
					_widget.deregister();
					traceState();
					setState(2);
					break;
				case "register" : 
					_widget.register();
					traceState();
					setState(3);
					break;
			}
		} else if (cmd is CaseOrder) {
			var order : CaseOrder = CaseOrder(cmd);
			if (!order.values || order.values.length < 1) {
				_widget[order.name]();
			} else {
				var param : Array = [];
				var f : int = -1;
				while(++f < order.values.length) {
					param.push(IRandomValue(order.values[f]).getRandom());
				}
				_widget[order.name].apply(null, param);
			}
			traceState();
		} else if (cmd is CaseState) {
			var state : CaseState = CaseState(cmd);
			_widget[state.name] = state.value.getRandom();
			traceState();
		}
		trace("========================================================");
	}

	private function resize(event : Event = null) : void {
		setInvalid("resize", true);
	}

	private function setState(i : int) : void {
		if (_state == i) return;
		_state = i;
		
		var f : int;
		var s : int;
		var state : String;
		f = -1;
		var btn : CommandBtn;
		while(++f < _btns.length) {
			s = _btns[f].length;
			state = _state == f ? WidgetState.RUN : WidgetState.DISABLE;
			while (--s >= 0) {
				btn = _btns[f][s];
				btn.state = state;
			}
		}
		setInvalid("draw", true);
	}

	/* *********************************************************************
	 * invalidate
	 ********************************************************************* */
	/** @private */
	final override protected function rendering() : void {
		var f : int;
		var s : int;
		if (getInvalid("resize")) {
			f = -1;
			var btn : CommandBtn;
			var nx : int = 0;
			var ny : int;
			while(++f < _btns.length) {
				s = _btns[f].length;
				ny = SS.sh - 40;
				while (--s >= 0) {
					btn = _btns[f][s];
					btn.x = nx;
					btn.y = ny;
					
					ny -= btn.height + 2;
				}
				nx += 130;
			}
		}
		if (getInvalid("resize") || getInvalid("draw")) {
			clearLines();
			graphics.clear();
		
			_back.y = SS.sh - _back.height;
			_back.width = SS.sw;
			_back.draw(graphics);
			var state : Rect;
			f = 4;
			while (--f >= 0) {
				state = _state == f ? _state1 : _state0;
				state.y = SS.sh - state.height;
				state.x = (130 * (f + 1)) - state.width;
				state.draw(graphics); 
				
				_stateFac.compositionBounds = new Rectangle(130 * f, state.y, 110, 15);
				_stateFac.textFlowFormat = _state == f ? _state1Format : _state0Format;
				_stateFac.text = _stateString[f];
				_stateFac.createTextLines(textLineCreate);
			}
		}
		
		
		
		clearInvalid();
	}

	private function clearLines() : void {
		var f : int = _stateLines.length;
		var line : TextLine;
		while (--f >= 0) {
			line = _stateLines[f];
			sprite.removeChild(line);
			TextLineRecycler.addLineForReuse(line);
		}
		_stateLines.length = 0;
	}

	private function textLineCreate(line : TextLine) : void {
		sprite.addChild(line);
		_stateLines.push(line);
	}
}
}

import ssen.debug.autocase.AutoCase;
import ssen.debug.autocase.ICaseCommand;
import ssen.framework.widgets.btns.LableBtn;
import ssen.framework.widgets.btns.events.ClickEvent;

import flash.display.DisplayObjectContainer;

class CommandBtn extends LableBtn {
	private var _command : ICaseCommand;
	private var _autocase : AutoCase;

	/** setting */
	public function setting_CommandBtn(service : DisplayObjectContainer = null, index : int = -1, state : String = "run", 
										command : ICaseCommand = null,
										autoCase : AutoCase = null
										) : void {
		setting(service, index, state, command, autoCase);
	}

	override protected function wsetting(config : Array) : void {
		_command = config[0];
		_autocase = config[1];
		super.wsetting([117, 20, null, null, 200, false, 4000, false, null, false, null, _command.displayName, null, null, false]);
	}

	override protected function wregister() : void {
		super.wregister();
		
		sprite.alpha = 0.4;
		addEventListener(ClickEvent.CLICK, click);
	}

	private function click(event : ClickEvent) : void {
		_autocase.command(_command);
	}

	public function get command() : ICaseCommand {
		return _command;
	}
}

class FlowCommand implements ICaseCommand {
	public var name : String;

	public function FlowCommand(cmd : String) {
		name = cmd;
	}

	public function get displayName() : String {
		return "< " + name + " >";
	}
}