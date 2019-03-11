package ssen.stutter.elements {
import ssen.stutter.StutterDocument;

import flash.display.DisplayObject;
import flash.display.Shape;
import flash.events.EventDispatcher;

/**
 * @author ssen (i@ssen.name)
 */
public class StutterLineElement extends EventDispatcher implements IStutterLineElement {
	private var _shape : Shape;
	private var _height : Number;

	public function StutterLineElement() {
		_shape = new Shape();
	}

	public function construct(doc : StutterDocument) : void {
		doc.style.lineMaterial.draw(_shape.graphics, doc.style.linePadding.left, doc.style.linePadding.top, doc.width - doc.style.linePadding.leftAndRight, 1);
		_height = doc.style.linePadding.topAndBottom + 1;
	}

	public function deconstruct() : void {
		_shape.graphics.clear();
	}

	public function get y() : int {
		return _shape.y;
	}

	public function get height() : int {
		return _height;
	}

	public function get display() : DisplayObject {
		return _shape;
	}

	public function set y(y : int) : void {
		_shape.y = y;
	}
}
}
