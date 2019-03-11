package ssen.stutter.elements {
import ssen.core.net.LoadOrder;
import ssen.core.net.StringObjectFactory;
import ssen.framework.service.FlourSimpleLauncher;
import ssen.framework.widgets.core.IWidget;

import de.polygonal.ds.ArrayedQueue;

import flash.net.URLRequest;

/**
 * @author ssen (i@ssen.name)
 */
[SWF(backgroundColor="#aaaaaa", frameRate="31", width="1000", height="700")]

public class ElementTest extends FlourSimpleLauncher {
	override protected function getResourceList() : ArrayedQueue {
		var q : ArrayedQueue = super.getResourceList();
		var strFac : StringObjectFactory = new StringObjectFactory();
		q.enqueue(LoadOrder.get("text", new URLRequest("stutter/text.txt"), strFac));
		return q;
	}

	override public function recive(order : LoadOrder) : void {
		switch (order.id) {
			case "text" :
				TestApp.datas.set("text", String(order.data));
				break;
		}
		LoadOrder.put(order);
	}

	override protected function getApplication() : IWidget {
		return new TestApp();
	}
}
}

import ssen.core.DisplayX;
import ssen.framework.service.SS;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.stutter.StutterDocument;
import ssen.stutter.elements.StutterCodeElement;
import ssen.stutter.elements.StutterHeaderElement;
import ssen.stutter.elements.StutterLineElement;
import ssen.stutter.elements.StutterListElement;
import ssen.stutter.elements.StutterListItem;

import de.polygonal.ds.HashMap;

class TestApp extends SpriteWidget {
	public static var datas : HashMap = new HashMap();

	override protected function wregister(initializeState : String) : void {
		graphics.beginFill(0xa6a6a6);
		graphics.drawRect(0, 0, 800, SS.frame.stage.stageHeight);
		graphics.endFill();
		
		var doc : StutterDocument = new StutterDocument();
		var children : Array = [];
		
		var header1 : StutterHeaderElement = new StutterHeaderElement();
		header1.construct(doc, 1, "가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사");
		header1.y = 0;
		
		var header2 : StutterHeaderElement = new StutterHeaderElement();
		header2.construct(doc, 2, "가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사");
		header2.y = header1.y + header1.height;
		
		var header3 : StutterHeaderElement = new StutterHeaderElement();
		header3.construct(doc, 3, "가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사");
		header3.y = header2.y + header2.height;
		
		var line : StutterLineElement = new StutterLineElement();
		line.construct(doc);
		line.y = header3.y + header3.height;
		
		var list : StutterListElement = new StutterListElement();
		list.construct(doc, Vector.<StutterListItem>([new StutterListItem(1, "리스트"), new StutterListItem(2, "리스트"), new StutterListItem(2, "리스트"), new StutterListItem(2, "리스트"), new StutterListItem(3, "리스트"), new StutterListItem(4, "리스트"), new StutterListItem(5, "리스트")]));
		list.y = line.y + line.height;
		
		var code : StutterCodeElement = new StutterCodeElement();
		code.construct(doc, String(datas.get("text")));
		code.y = list.y + list.height;
		//trace(header1.y, header2.y, header3.y, code.y);
		children.push(header1.display, header2.display, header3.display, code.display, line.display, list.display);
		
		DisplayX.addChildren(sprite, children);
		
		addToService();
	}
}