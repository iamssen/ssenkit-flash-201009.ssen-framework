package ssen.stutter.elements {
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
public class StutterListElement extends EventDispatcher implements IStutterListElement {
	private var _sprite : Sprite;
	private var _fac : StringTextLineFactory;
	private var _lines : Vector.<TextLine>;
	private var _height : Number;

	public function StutterListElement() {
		_sprite = new Sprite();
		_fac = new StringTextLineFactory();
		_fac.truncationOptions = new TruncationOptions(null, 1);
		_lines = new Vector.<TextLine>();
	}

	public function construct(doc : StutterDocument, lists : Vector.<StutterListItem>) : void {
		var format : ITextLayoutFormat;
		var bounds : Rectangle = new Rectangle(0, 0, doc.width, 1000);
		var f : int = -1;
		var list : StutterListItem;
		while(++f < lists.length) {
			list = lists[f];
			switch (list.depth) {
				case 1 : 
					format = doc.style.list1TextFormat;
					break;
				case 2 : 
					format = doc.style.list2TextFormat; 
					break;
				case 3 : 
					format = doc.style.list3TextFormat; 
					break;
				case 4 : 
					format = doc.style.list4TextFormat; 
					break;
				case 5 : 
					format = doc.style.list5TextFormat; 
					break;
			}
			
			_fac.compositionBounds = bounds;
			_fac.textFlowFormat = format;
			_fac.text = getMark(list.depth) + "  " + list.title;
			_fac.createTextLines(createdTextLine);
			
			bounds.top += format.paddingTop + format.paddingBottom + _lines[_lines.length - 1].height;
		}
		_height = bounds.top;
	}

	private function createdTextLine(line : TextLine) : void {
		_sprite.addChild(line);
		_lines.push(line);
	}

	public function deconstruct() : void {
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

	private function getMark(depth : int) : String {
		switch (depth) {
			case 1 : 
				return "●"; 
				break;
			case 2 : 
				return "■"; 
				break;
			case 3 : 
				return "○"; 
				break;
			case 4 : 
				return "□"; 
				break;
			default : 
				return "-"; 
				break; 
		}
	}
}
}
