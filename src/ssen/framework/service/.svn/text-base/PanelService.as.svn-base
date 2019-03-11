package ssen.framework.service {
import net.kawa.tween.KTJob;
import net.kawa.tween.KTween;
import net.kawa.tween.easing.Quad;

import ssen.framework.ss_internal;
import ssen.framework.widgets.core.IWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.panels.IPanelObject;
import ssen.framework.widgets.visual.IValueVisual;

import de.polygonal.ds.DLL;
import de.polygonal.ds.DLLNode;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;

use namespace ss_internal;

/**
 * 기본 panel service
 * @author ssen(i@ssen.name)
 */
public class PanelService extends Sprite implements IPanelService {
	private var _panels : DLL;
	private var _tw : KTJob;
	private var _screen : IValueVisual;

	public function PanelService() {
		_panels = new DLL();
		_screen = getDarkScreen();
		_screen.construct();
		_screen.setting(this, 0);
		SS.stage.addEventListener(Event.RESIZE, stageResize);
	}

	private function stageResize(event : Event) : void {
		if (_panels.size() > 0) {
			var node : DLLNode = _panels.head();
			var panel : IPanelObject;
			while(node != null) {
				panel = IPanelObject(node.val);
				panel.rePositioning();
				node = node.next;
			}
		}
	}

	/** @inheritDoc */
	public function open(panel : IPanelObject, state : String = "run") : void {
		if (_panels.size() <= 0) {
			bgShow(true);
			SS.app.state = WidgetState.DISABLE;
		}
			
		if (panel.node) {
			if (panel.node != _panels.tail()) {
				fall();
				_panels.remove(panel.node);
				panel.node = _panels.insertAfter(_panels.tail(), panel);
				toTop(panel);
			}
		} else {
			fall();
			panel.node = _panels.append(panel);
			panel.state = state;
			panel.register();
			panel.addEventListener(Event.CLOSE, panelClose);
		}
	}

	/** @inheritDoc */
	public function closeAll() : void {
		if (_panels.size() > 0) {
			var node : DLLNode = _panels.head();
			var panel : IPanelObject;
			while(node != null) {
				panel = IPanelObject(node.val);
				panel.deregister();
				node = node.next;
			}
		}
		bgShow(false);
		SS.app.state = WidgetState.RUN;
	}

	/** 가림막을 생성하는 factory */
	protected function getDarkScreen() : IValueVisual {
		return new DarkScreen;
	}

	private function panelClose(event : Event) : void {
		close(IPanelObject(event.target));
	}

	/** @private */
	public function get bg() : Number {
		return _screen.value;
	}

	public function set bg(bg : Number) : void {
		_screen.value = bg;
	}

	/** @inheritDoc */
	public function close(panel : IPanelObject) : void {
		if (panel.node) {
			_panels.remove(panel.node);
			panel.node = null;
			panel.deregister();
				
			if (_panels.size() > 0) {
				panel = IPanelObject(_panels.tail().val);
				panel.state = WidgetState.RUN;
				toTop(panel);
			} else {
				bgShow(false);
				SS.app.state = WidgetState.RUN;
			}
		}
	}

	private function bgShow(visible : Boolean) : void {
		if (visible && !_screen.registered) _screen.register();
		if (_tw && !_tw.finished) _tw.abort();
		if (visible) {
			_tw = KTween.to(this, 0.4, {bg:1}, Quad.easeOut);
		} else {
			_tw = KTween.to(this, 0.4, {bg:0}, Quad.easeOut, closeVisible);
		}
	}

	private function closeVisible() : void {
		if (_screen.registered) _screen.deregister();
	}		

	private function fall() : void {
		if (_panels.size() > 0) {
			var panel : IPanelObject = IPanelObject(_panels.tail().val);
			panel.state = WidgetState.DISABLE;
			toTop(_screen);
		}
	}

	private function toTop(widget : IWidget) : void {
		setChildIndex(widget["display"], numChildren - 1);
	}

	/** @inheritDoc */
	public function get service() : DisplayObjectContainer {
		return this;
	}
}
}

import ssen.core.draw.PathMaker;
import ssen.core.draw.material.SolidMaterial;
import ssen.framework.service.SS;
import ssen.framework.ss_internal;
import ssen.framework.widgets.core.Widget;
import ssen.framework.widgets.visual.IValueVisual;

import flash.display.DisplayObject;
import flash.display.GraphicsSolidFill;
import flash.display.Shape;
import flash.events.Event;

class DarkScreen extends Widget implements IValueVisual {
	private var _solid : SolidMaterial;
	private var _alpha : Number;
	private var _fill : GraphicsSolidFill;
	private var _display : Shape;

	public function get value() : Number {
		return _alpha;
	}

	public function set value(value : Number) : void {
		_alpha = value;
		draw();
	}

	override protected function wconstruct() : void {
		_alpha = 0;
		_fill = new GraphicsSolidFill(0x000000, 0);
		_solid = new SolidMaterial(_fill);
		_display = new Shape();
	}

	override protected function wregister() : void {
		SS.stage.addEventListener(Event.RESIZE, resize);
		addToService();
	}

	override protected function wderegister() : void {
		SS.stage.removeEventListener(Event.RESIZE, resize);
		removeFromService();
	}

	override protected function wdeconstruct() : void {
		_fill = null;
		_solid = null;
		_display = null;
	}

	private function resize(event : Event) : void {
		draw();
	}

	private function draw() : void {
		_fill.alpha = _alpha * 0.4;
		_display.graphics.clear();
		_solid.draw(_display.graphics, 0, 0, SS.sw, SS.sh, PathMaker.rect(0, 0, SS.sw, SS.sh));
	}

	override ss_internal function get display() : DisplayObject {
		return _display;
	}
}
