package ssen.stutter {
import ssen.framework.service.FlourSimpleLauncher;
import ssen.framework.widgets.core.IWidget;

/**
 * @author ssen (i@ssen.name)
 */
public class StutterGraphicsTest extends FlourSimpleLauncher {
	override protected function getApplication() : IWidget {
		return new TestApp();
	}
}
}

import flashx.textLayout.container.TextContainerManager;
import flashx.textLayout.conversion.ConversionType;
import flashx.textLayout.conversion.ITextExporter;
import flashx.textLayout.conversion.TextConverter;
import flashx.textLayout.edit.EditingMode;
import flashx.textLayout.elements.InlineGraphicElement;
import flashx.textLayout.elements.LinkElement;
import flashx.textLayout.elements.ParagraphElement;
import flashx.textLayout.elements.SpanElement;
import flashx.textLayout.elements.TextFlow;
import flashx.textLayout.events.CompositionCompleteEvent;
import flashx.textLayout.events.FlowElementMouseEvent;
import flashx.textLayout.events.StatusChangeEvent;

import ssen.core.draw.Rect;
import ssen.core.draw.material.SolidMaterial;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.stutter.StutterLine;
import ssen.styles.flour.FlourTextFormatFactory;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.GraphicsSolidFill;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;

class TestApp extends SpriteWidget {
	private var manager : TextContainerManager;
	private var save : InlineGraphicElement;

	override protected function wregister(initializeState : String) : void {
		
		manager = new TextContainerManager(new Sprite);
		manager.compositionWidth = 200;
		manager.compositionHeight = 300;
		
		var flow : TextFlow = new TextFlow();
		flow.format = FlourTextFormatFactory.getEmbedSansSerif(11);
		
		var p : ParagraphElement;
		var span : SpanElement;
		var img : InlineGraphicElement;
		var link : LinkElement;
		
		p = new ParagraphElement();
		img = new InlineGraphicElement();
		img.id = "image1";
		img.styleName = "aaa,bbb";
		img.source = StutterLine.get(0.3);
		p.addChild(img);
		flow.addChild(p);
		
		p = new ParagraphElement();
		img = new InlineGraphicElement();
		img.source = "asset/profile.png";
		img.width = "20%";
		img.height = "20%";
		save = img;
		link = new LinkElement();
		link.href = "@ssen";
		link.addChild(img);
		p.addChild(link);
		flow.addChild(p);
		
		p = new ParagraphElement();
		span = new SpanElement();
		span.text = "가나다라마바사";
		p.addChild(span);
		flow.addChild(p);
		
		p = new ParagraphElement();
		img = new InlineGraphicElement();
		img.source = TestGraphics;
		p.addChild(img);
		flow.addChild(p);
		
		p = new ParagraphElement();
		span = new SpanElement();
		span.text = "나나나나나";
		p.addChild(span);
		flow.addChild(p);
		
		trace("elements by style name", flow.getElementsByStyleName("aaa"));
		
		var exporter : ITextExporter = TextConverter.getExporter(TextConverter.TEXT_LAYOUT_FORMAT);
		trace(exporter.export(flow, ConversionType.XML_TYPE));
		
		manager.editingMode = EditingMode.READ_SELECT;
		manager.setTextFlow(flow);
		manager.updateContainer();
		manager.addEventListener(StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE, inlineGraphicStatusChange);
		manager.addEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE, compositionComplete);
		manager.addEventListener(FlowElementMouseEvent.CLICK, click);
		
		sprite.addChild(manager.container);
		manager.container.x = 10;
		manager.container.y = 10;
		
		var material : SolidMaterial = new SolidMaterial(new GraphicsSolidFill(0xeeeeee));
		var rect : Rect = new Rect(10, 10, 200, 300, material);
		rect.draw(graphics);
		
		addToService();
	}

	private function click(event : FlowElementMouseEvent) : void {
		if (event.flowElement is LinkElement) {
			var link : LinkElement = LinkElement(event.flowElement);
			trace(link.href, link.target);
		}
	}

	private function compositionComplete(event : CompositionCompleteEvent) : void {
		trace(event);
		manager.updateContainer();
	}

	private function inlineGraphicStatusChange(event : StatusChangeEvent) : void {
		trace(event, save.graphic, save.graphic.parent.parent.parent);
		manager.updateContainer();
	}
}

class TestBitmap extends Bitmap {
	public function TestBitmap() {
		super(new BitmapData(10, 10, true, 0x44000000));
		
		addEventListener(Event.ADDED_TO_STAGE, event);
	}

	private function event(event : Event) : void {
		trace(this, event, parent, parent.parent, parent.parent.parent);
	}

	override public function set width(value : Number) : void {
		super.width = value;
		trace(this, "set width", value);
	}

	override public function set height(value : Number) : void {
		super.height = value;
		trace(this, "set height", value);
	}
}

class TestGraphics extends Shape {
	public function TestGraphics() {
		graphics.beginFill(0x000000);
		graphics.drawRect(0, 0, 10, 10);
		graphics.endFill();
		
		addEventListener(Event.ADDED_TO_STAGE, event);
	}

	private function event(event : Event) : void {
		trace(this, event, parent, parent.parent, parent.parent.parent);
		
		if (parent.parent.parent is StutterContainer) {
			var container : StutterContainer = StutterContainer(parent.parent.parent);
			graphics.clear();
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, container.compositionWidth, 10);
			graphics.endFill();
		}
	}

	override public function set width(value : Number) : void {
		super.width = value;
		trace(this, "set width", value);
	}

	override public function set height(value : Number) : void {
		super.height = value;
		trace(this, "set height", value);
	}
}