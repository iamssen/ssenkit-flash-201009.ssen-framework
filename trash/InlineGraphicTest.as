package ssen.stutter {
import flashx.textLayout.container.ContainerController;
import flashx.textLayout.edit.SelectionManager;
import flashx.textLayout.elements.InlineGraphicElement;
import flashx.textLayout.elements.ParagraphElement;
import flashx.textLayout.elements.SpanElement;
import flashx.textLayout.elements.TextFlow;

import flash.display.Sprite;

/**
 * @author ssen (i@ssen.name)
 */
public class InlineGraphicTest extends Sprite {    
	public function InlineGraphicTest() {
		// create a container and a controller for it
		var container : Sprite = new Sprite();
		this.stage.addChild(container);
		// create the TextFlow, ParagraphElement, SpanElement, and InlineGraphicElement objects    
		var textFlow : TextFlow = new TextFlow();
		var p : ParagraphElement = new ParagraphElement();
		var inlineGraphicElement : InlineGraphicElement = new InlineGraphicElement();
		var span : SpanElement = new SpanElement();
		// add the graphic
		inlineGraphicElement.source = drawRect();
		// add text to the spans, spans and graphic to paragraph        
		span.text = "Too much depends upon a ";
		span.fontSize = 48;
		p.addChild(span); 
		p.addChild(inlineGraphicElement);
		// add paragraph to text flow and update controller to display
		textFlow.addChild(p);
		textFlow.interactionManager = new SelectionManager();
		var controller : ContainerController = new ContainerController(container, 400, 300);
		textFlow.flowComposer.addController(controller);
		textFlow.flowComposer.updateAllControllers(); 
	}

	private function drawRect() : Sprite {
		var redRect : Sprite = new Sprite();
		redRect.graphics.beginFill(0xff0000);    // red
		redRect.graphics.drawRect(0, 0, 30, 30);
		redRect.graphics.endFill();
		return redRect;
	}
}
}
