package ssen.stutter.elements {
import flashx.textLayout.compose.TextLineRecycler;
import flashx.textLayout.factory.StringTextLineFactory;
import flashx.textLayout.factory.TruncationOptions;
import flashx.textLayout.formats.ITextLayoutFormat;

import ssen.stutter.StutterDocument;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.EventDispatcher;
import flash.geom.Rectangle;
import flash.text.engine.TextLine;

/**
 * @author ssen (i@ssen.name)
 */
public class StutterHeaderElement extends EventDispatcher implements IStutterHeaderElement {
	private var _fac : StringTextLineFactory;
	private var _line : TextLine;
	private var _sprite : Sprite;
	private var _height : Number;

	public function StutterHeaderElement() {
		_sprite = new Sprite();
		_fac = new StringTextLineFactory();
		_fac.truncationOptions = new TruncationOptions(null, 1);
	}

	public function construct(doc : StutterDocument, depth : int, title : String) : void {
		var format : ITextLayoutFormat;
		switch (depth) {
			case 1 : 
				format = doc.style.h1TextFormat; 
				break;
			case 2 : 
				format = doc.style.h2TextFormat; 
				break;
			default : 
				format = doc.style.h3TextFormat; 
				break;
		}
		
		_fac.text = title;
		_fac.textFlowFormat = format;
		_fac.compositionBounds = new Rectangle(0, 0, doc.width, 100);
		_fac.createTextLines(createdTextLine);
		
		_height = _sprite.height + format.paddingTop + format.paddingBottom;
		
		if (depth == 1) {
			_sprite.graphics.beginFill(format.color);
			_sprite.graphics.drawRect(0, _height - format.paddingBottom + 5, doc.width, 2);
			_sprite.graphics.endFill();
		}
	}

	private function createdTextLine(line : TextLine) : void {
		_line = line;
		_sprite.addChild(line);
	}

	public function deconstruct() : void {
		_sprite.removeChild(_line);
		TextLineRecycler.addLineForReuse(_line);
		_line = null;
	}

	public function get y() : int {
		return _sprite.y;
	}

	public function get height() : int {
		return _height;
	}

	public function get display() : DisplayObject {
		return _sprite;
	}

	public function set y(y : int) : void {
		_sprite.y = y;
	}
}
}
