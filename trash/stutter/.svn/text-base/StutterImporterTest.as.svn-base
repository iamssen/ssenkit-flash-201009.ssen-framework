package ssen.stutter {
import ssen.core.net.LoadOrder;
import ssen.core.net.StringObjectFactory;
import ssen.framework.service.SimpleLauncher;
import ssen.framework.widgets.core.IWidget;

import de.polygonal.ds.ArrayedQueue;

import flash.net.URLRequest;
import flash.utils.getTimer;

/**
 * @author ssen (i@ssen.name)
 */
public class StutterImporterTest extends SimpleLauncher {
	override protected function getResourceList() : ArrayedQueue {
		var queue : ArrayedQueue = super.getResourceList();
		queue.enqueue(LoadOrder.get("stutter", new URLRequest("stutter/stutter.txt?id=" + getTimer()), new StringObjectFactory()));
		return queue;
	}

	override public function recive(order : LoadOrder) : void {
		switch (order.id) {
			case "stutter" :
				TestApp.stutterDoc = String(order.data);
				break;
		}
	}

	override protected function getApplication() : IWidget {
		return new TestApp();
	}
}
}

import flashx.textLayout.container.TextContainerManager;
import flashx.textLayout.conversion.ConversionType;
import flashx.textLayout.conversion.TextConverter;
import flashx.textLayout.edit.EditingMode;
import flashx.textLayout.elements.InlineGraphicElement;
import flashx.textLayout.elements.LinkElement;
import flashx.textLayout.elements.TextFlow;
import flashx.textLayout.events.CompositionCompleteEvent;
import flashx.textLayout.events.FlowElementMouseEvent;
import flashx.textLayout.events.StatusChangeEvent;
import flashx.textLayout.events.TextLayoutEvent;

import ssen.core.draw.Rect;
import ssen.core.draw.material.SolidMaterial;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.scroll.Scroll;
import ssen.framework.widgets.scroll.ScrollConfig;
import ssen.framework.widgets.scroll.ScrollDirection;
import ssen.stutter.StutterCode;
import ssen.stutter.StutterImporter;
import ssen.styles.flour.scroll.FlourScrollStyleSet;

import flash.display.DisplayObject;
import flash.display.GraphicsSolidFill;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;

class TestApp extends SpriteWidget {
	public static var stutterDoc : String;
	private var manager : TextContainerManager;
	private var scroll : Scroll;

	override protected function wregister(initializeState : String) : void {
		var importer : StutterImporter = new StutterImporter();
		importer.compositionWidth = 700;
		var flow : TextFlow = importer.importToFlow(stutterDoc);
		
		if (!flow) {
			trace(importer.errors);
			return;
		}
		
		trace(TextConverter.getExporter(TextConverter.TEXT_LAYOUT_FORMAT).export(flow, ConversionType.XML_TYPE));
		manager = new TextContainerManager(new Sprite());
		manager.compositionWidth = 700;
		manager.compositionHeight = 800;
		manager.editingMode = EditingMode.READ_SELECT;
		manager.setTextFlow(flow);
		manager.updateContainer();
		manager.addEventListener(StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE, inlineGraphicStatusChange);
		manager.addEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE, compositionComplete);
		manager.addEventListener(FlowElementMouseEvent.CLICK, click);
		manager.container.x = 10;
		manager.container.y = 10;
		manager.addEventListener(TextLayoutEvent.SCROLL, tscroll);
		
		sprite.addChild(manager.container);
		var material : SolidMaterial = new SolidMaterial(new GraphicsSolidFill(0xeeeeee));
		var rect : Rect = new Rect(10, 10, manager.compositionWidth, manager.compositionHeight, material);
		rect.draw(graphics);
		
		var bounds : Rectangle = manager.getContentBounds();
		var config : ScrollConfig = new ScrollConfig();
		config.materialConfig(FlourScrollStyleSet.thumbV, FlourScrollStyleSet.trackV);
		config.viewConfig(ScrollDirection.VERTICAL, 17, manager.compositionHeight);
		config.valueConfig(0, bounds.height - manager.compositionHeight, bounds.height, manager.verticalScrollPosition);
		scroll = new Scroll();
		scroll.construct();
		scroll.setting(config);
		scroll.register(sprite);
		scroll.x = manager.container.x + manager.compositionWidth;
		scroll.y = manager.container.y;
		scroll.addEventListener(Event.SCROLL, scrollHandler);
		
		addToService();
	}

	private function tscroll(event : TextLayoutEvent) : void {
		scroll.scrollPosition = manager.verticalScrollPosition;
	}

	private function scrollHandler(event : Event) : void {
		manager.verticalScrollPosition = scroll.scrollPosition;
	}

	private function click(event : FlowElementMouseEvent) : void {
		if (event.flowElement is LinkElement) {
			var link : LinkElement = LinkElement(event.flowElement);
			trace(link.href, link.target);
			switch (link.href) {
				case "@code" :
					trace(StutterCode(InlineGraphicElement(link.getChildAt(0)).graphic).viewSource());
					break;
			}
		}
	}

	private function compositionComplete(event : CompositionCompleteEvent) : void {
		trace(event);
		manager.getTextFlow().flowComposer.composeToPosition();
		var bounds : Rectangle = manager.getContentBounds();
		scroll.resetScrollInfo(0, bounds.height - manager.compositionHeight, bounds.height);
	}

	private function inlineGraphicStatusChange(event : StatusChangeEvent) : void {
		trace(event);
		
		var graphic : DisplayObject;
		if (event.element is InlineGraphicElement) {
			graphic = InlineGraphicElement(event.element).graphic;
			//trace(graphic, graphic.width, graphic.height, graphic.x, graphic.y);
		}
		
		manager.getTextFlow().flowComposer.composeToPosition();
		manager.updateContainer();
	}
}
