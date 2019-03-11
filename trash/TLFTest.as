package ssen.stutter {
import ssen.framework.service.FlourSimpleLauncher;
import ssen.framework.widgets.core.IWidget;

/**
 * @author ssen (i@ssen.name)
 */
public class TLFTest extends FlourSimpleLauncher {
	override protected function getApplication() : IWidget {
		return new TestApp();
	}
}
}

import flashx.textLayout.container.TextContainerManager;
import flashx.textLayout.conversion.ConversionType;
import flashx.textLayout.conversion.TextConverter;
import flashx.textLayout.elements.InlineGraphicElement;
import flashx.textLayout.elements.ParagraphElement;
import flashx.textLayout.elements.SpanElement;
import flashx.textLayout.elements.TextFlow;
import flashx.textLayout.events.StatusChangeEvent;
import flashx.textLayout.formats.VerticalAlign;

import ssen.framework.widgets.core.SpriteWidget;

import flash.display.Sprite;

class TestApp extends SpriteWidget {
	private var cont : TextContainerManager;

	override protected function wregister(initializeState : String) : void {
		var txfl : TextFlow = new TextFlow();
		
		var p : ParagraphElement;
		p = new ParagraphElement();
		var img : InlineGraphicElement = new InlineGraphicElement();
		//img.source = new Bitmap(new BitmapData(100, 100, true, 0x55000000));
		img.paddingLeft = 100;
		img.paddingRight = 50;
		img.source = "asset/profile.png";
		//img.source = "asset/example.mp4";
		img.width = "50%";
		img.height = "50%";
		img.verticalAlign = VerticalAlign.MIDDLE;
		//p.textAlign = TextAlign.LEFT;
		p.verticalAlign = VerticalAlign.MIDDLE;
		p.addChild(img);
		txfl.addChild(p);
		
		trace(p.computedFormat);
		 
		p = new ParagraphElement();
		p.paragraphSpaceBefore = 50;
		//p.paragraphStartIndent = 20;
		var span : SpanElement;
		span = new SpanElement();
		span.id = "tspan1";
		span.text = "test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test";
		p.addChild(span);
		span = new SpanElement();
		span.id = "tspan2";
		span.text = "test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test";
		p.addChild(span);
		txfl.addChild(p);
		
		SpanElement(txfl.getElementByID("tspan1")).text = "aaaaa";
		
		trace(TextConverter.getExporter(TextConverter.TEXT_LAYOUT_FORMAT).export(txfl, ConversionType.XML_TYPE));
		
		cont = new TextContainerManager(new Sprite());
		cont.compositionWidth = 400;
		cont.compositionHeight = 300;
		cont.container.x = 10;
		cont.container.y = 10;
		cont.setTextFlow(txfl);
		cont.updateContainer();
		cont.addEventListener(StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE, inlineGraphicsStatusChange);
		
		sprite.addChild(cont.container);
		addToService();
	}

	private function inlineGraphicsStatusChange(event : StatusChangeEvent) : void {
		cont.updateContainer();
		trace(cont.getContentBounds());
	}
}