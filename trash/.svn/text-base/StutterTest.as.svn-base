package ssen.stutter {
import ssen.core.net.LoadOrder;
import ssen.core.net.StringObjectFactory;
import ssen.framework.service.FlourSimpleLauncher;
import ssen.framework.widgets.core.IWidget;

import de.polygonal.ds.ArrayedQueue;

import flash.net.URLRequest;

/**
 * @author ssen (i@ssen.name)
 */
[SWF(backgroundColor="#eeeeee", frameRate="31", width="550", height="400")]

public class StutterTest extends FlourSimpleLauncher {
	private var _data : String;

	override protected function getResourceList() : ArrayedQueue {
		var queue : ArrayedQueue = super.getResourceList();
		queue.enqueue(LoadOrder.get("data", new URLRequest("stutter/stutter.txt"), new StringObjectFactory()));
		return queue;
	}

	override public function recive(order : LoadOrder) : void {
		if (order.id == "data") {
			_data = String(order.data);
		}
		LoadOrder.put(order);
	}

	override protected function getApplication() : IWidget {
		return new TestApp(_data);
	}
}
}

import flashx.textLayout.factory.StringTextLineFactory;

import ssen.framework.service.SS;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.scroll.Scroll;
import ssen.framework.widgets.scroll.ScrollConfig;
import ssen.framework.widgets.scroll.ScrollDirection;
import ssen.stutter.StutterFactory;
import ssen.styles.flour.FlourTextFormatFactory;
import ssen.styles.flour.scroll.FlourScrollStyleSet;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.text.engine.TextLine;

class TestApp extends SpriteWidget {
	private var _data : String;
	private var _container : Sprite;
	private var scroll : Scroll;

	public function TestApp(data : String) {
		_data = data;
		_container = new Sprite();
		_container.x = 10;
		_container.y = 10;
	}

	override protected function wregister(initializeState : String) : void {
		var config : ScrollConfig = new ScrollConfig();
		config.materialConfig(FlourScrollStyleSet.thumbV, FlourScrollStyleSet.trackV);
		config.viewConfig(ScrollDirection.VERTICAL, 17, SS.frame.stage.stageHeight);
		scroll = new Scroll();
		scroll.construct();
		scroll.setting(config);
		scroll.register(sprite);
		scroll.x = SS.frame.stage.stageWidth - scroll.width;
		scroll.addEventListener(Event.SCROLL, scrollHandler);
		trace(SS.frame.stage.stageWidth, scroll.x);
		
		var stutter : StutterFactory = new StutterFactory();
		stutter.hostFormat = FlourTextFormatFactory.getEmbedSansSerif(10);
		stutter.compositionBounds = new Rectangle(0, 0, 700, 100000);
		stutter.parse(_data, useStutter);
		
		var fac : StringTextLineFactory = new StringTextLineFactory();
		fac.compositionBounds = new Rectangle(10, 10, 400, 200);
		fac.text = "가나다라마바사...\n가나다라마바사...\n가나다라마바사...";
		fac.createTextLines(useTextLine);
		trace("factory end");
		
		addToService();
		sprite.addChild(_container);
	}

	private function scrollHandler(event : Event) : void {
		_container.y = 20 - scroll.scrollPosition;
	}

	private function useTextLine(line : TextLine) : void {
	}

	private function useStutter(display : DisplayObject) : void {
		trace("use stutter", display, display.x, display.y, display.width, display.height, sprite.parent);
		_container.addChild(display);
		var min : Number = 10;
		var max : Number = _container.height + 30 - SS.frame.stage.stageHeight;
		if (max < min) max = min;
		var total : Number = _container.height + 30;
		if (total < min) total = min;
		scroll.resetScrollInfo(min, max, total);
		//trace(min, max, total);
	}
}