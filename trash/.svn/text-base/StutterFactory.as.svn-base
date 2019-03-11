package ssen.stutter {
import flashx.textLayout.conversion.TextConverter;
import flashx.textLayout.factory.StringTextLineFactory;
import flashx.textLayout.factory.TextFlowTextLineFactory;
import flashx.textLayout.formats.ITextLayoutFormat;
import flashx.textLayout.formats.TextAlign;
import flashx.textLayout.formats.VerticalAlign;

import ssen.styles.flour.FlourTextFormatFactory;

import de.polygonal.ds.HashMap;

import flash.events.TimerEvent;
import flash.geom.Rectangle;
import flash.text.engine.TextLine;
import flash.utils.Timer;

/**
 * @author ssen (i@ssen.name)
 */
public class StutterFactory {
	private var _hostFormat : ITextLayoutFormat;
	private var _compositionBounds : Rectangle;
	private var _flowFac : TextFlowTextLineFactory;
	private var _lines : Array;
	private var _timer : Timer;
	private var _f : int;
	private var _vars : HashMap;
	private var _bounds : Rectangle;
	private var _callback : Function;
	private var _minX : Number;
	private var _maxX : Number;
	private var _strFac : StringTextLineFactory;
	private var _lineType : String;
	private var _paragraph : Boolean;
	private var _list : Boolean;
	private var _flow : String;

	public function StutterFactory() {
		_flowFac = new TextFlowTextLineFactory();
		_strFac = new StringTextLineFactory();
	}

	public function get hostFormat() : ITextLayoutFormat {
		return _hostFormat;
	}

	public function set hostFormat(format : ITextLayoutFormat) : void {
		_hostFormat = format;
	}

	public function get compositionBounds() : Rectangle {
		return _compositionBounds;
	}

	public function set compositionBounds(compositionBounds : Rectangle) : void {
		_compositionBounds = compositionBounds;
	}

	public function parse(stutterDoc : String, callback : Function) : void {
		_lines = stutterDoc.split("\n");
		_f = -1;
		_callback = callback;
		_vars = new HashMap();
		_minX = _compositionBounds.left;
		_maxX = _compositionBounds.left + _compositionBounds.width;
		_bounds = _compositionBounds.clone();
		_strFac.compositionBounds = _bounds;
		_flowFac.compositionBounds = _bounds;
		_timer = new Timer(50);
		_timer.addEventListener(TimerEvent.TIMER, parseLine);
		_timer.start();
	}

	private function parseLine(event : TimerEvent) : void {
		var line : String;
		var exp : RegExp;
		var expResult : *;
		var module : Boolean;
		var moduleName : String;
		var moduleData : Array;
		
		while(++_f < _lines.length) {
			line = _lines[_f];
			 
			// 모듈 처리
			if (module) {
				exp = /\={3,}\s*$/;
				if (exp.test(line)) {
					trace(moduleName);
					trace(moduleData);
					//this[moduleName](moduleData);
					module = false;
					moduleName = "";
					moduleData = null;
					break;
				} else {
					moduleData.push(line);
					continue;
				}
			}
			
			// 모듈 시작
			exp = /\={3,}(\w[^\=]+)\=+$/;
			expResult = exp.exec(line);
			if (expResult) {
				endTags();
				module = true;
				moduleName = expResult[1];
				moduleData = new Array();
				continue;
			}
			
			// 주석 처리
			exp = /^\/\//;
			if (exp.test(line)) {
				continue;
			}
			
			// 변수 저장
			exp = /^\$(\w+)\s*=\s*(.+)$/;
			expResult = exp.exec(line);
			if (expResult) {
				if (_vars.has(expResult[1])) {
					_vars.remap(expResult[1], expResult[2]);
				} else {
					_vars.set(expResult[1], expResult[2]);
				}
				continue;
			}
			
			// 공백 라인 처리
			exp = /^\s*$/;
			if (exp.test(line) || line == "") {
				lineBreak();
				continue;
			}
			
			// 헤더
			exp = /^\s*(#+)\s*(.+)$/;
			expResult = exp.exec(line);
			if (expResult) {
				endTags();
				header(String(expResult[1]).length, expResult[2]);
				continue;
			}
			
			// 라인 
			exp = /^\-{4,}$/;
			if (exp.test(line)) {
				endTags();
				horizontalLine();
				continue;
			}
			
			// 미디어
			exp = /^:{2,}\s*(.+)$/;
			if (exp.test(line)) {
				mediaParser(line);
				continue;
			}
			
			// 리스트 
			exp = /^\s*[\*|\+]+\s+.+$/;
			if (exp.test(line)) {
				line = line.replace(/^\s*/, "");
				list(line);
				continue;
			}
			
			if (_paragraph) {
				br(line);
			} else {
				paragraph(line);
			}
		}
		
		trace("end timer");
		
		if (_f > _lines.length) {
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, parseLine);
			
			endTags();
		
			//			var headers = "";
			//			if (documentTop) headers += "<a name=\"documentTop\"></a>";
			//			if (headerList && this._headers.length > 0) headers += "<ol class=\"header\">" + this._headers.join("") + "</ol>";
			trace(_vars);
		}
	}

	private function listBreak() : void {
	}

	private function lineBreak() : void {
		listBreak();
		if (_paragraph) {
			_flow += "</span></p></TextFlow>";
			trace(_flow);
			try {
				_flowFac.createTextLines(createdLine, TextConverter.importToFlow(_flow, TextConverter.TEXT_LAYOUT_FORMAT));
			} catch (e : Error) {
				trace("!!!!error", _flow, TextConverter.importToFlow(_flow, TextConverter.TEXT_LAYOUT_FORMAT));
			}
			_paragraph = false;
		}
	}

	private function endTags() : void {
	}

	private function paragraph(line : String) : void {
		_paragraph = true;
		_flow = '<TextFlow fontSize="11" color="#000000" xmlns="http://ns.adobe.com/textLayout/2008"><p><span>';
		_flow += lineParser(line);
	}

	private function br(line : String) : void {
		_flow += "<br />" + lineParser(line);
	}

	private function lineParser(line : String) : String {
		return line;
		//createStringLine(line, "line", FlourTextFormatFactory.getEmbedSansSerif(11), 20);
	}

	private function list(line : String) : void {
		var r : RegExp = /^(\*+|\++)\s(.+)$/;
		var v : Array = r.exec(line);
		var symbol : String = v[1];
		var depth : int = symbol.length;
		
		if (!_list) {
			//translateY(10);
			_list = true;
		}
		
		listParser(symbol.charAt(0), depth, v[2]);
	}

	private function listParser(symbol : String, depth : int, str : String) : void {
		if (depth > 5) depth = 5;
		trace(symbol, depth, str);
		createStringLine(symbol + " : " + str, "list", FlourTextFormatFactory.getEmbedSansSerif(11, TextAlign.LEFT, VerticalAlign.TOP, 0xaaaaaa), 10 * depth); 
	}

	private function mediaParser(line : String) : void {
	}

	private function horizontalLine() : void {
	}

	private function header(depth : int, title : String) : void {
		if (depth > 3) depth = 3;
		createStringLine(title, "header" + depth, FlourTextFormatFactory.getEmbedSansSerif(15, TextAlign.LEFT, VerticalAlign.TOP, 0x000000, true), (depth - 1) * 10);
//		_headers.push("<li class=\"header" + depth + "\"><a href=\"#" + depth + "_" + title + "\">" + title + "</a></li>");
	}

	private function createStringLine(text : String, type : String, format : ITextLayoutFormat, x : Number) : void {
		transformX(x);
		_lineType = type;
		_strFac.text = text;
		_strFac.textFlowFormat = format;
		_strFac.createTextLines(createdLine);
	}

	private function createdLine(line : TextLine) : void {
		_callback(line);
		translateY(line.height + 10);
		return;
		
		switch (_lineType) {
			case "line" :
				_callback(line);
				translateY(line.height + 10);
				break;
			case "list" :
				_callback(line); 
				translateY(line.height + 10);
				break;
			case "header1" : 
			case "header2" :
			case "header3" :
				translateY(line.height + 20);
				break;
		}
	}

	private function translateY(y : int) : void {
		_bounds.top += y;
	}

	private function transformX(x : int) : void {
		_bounds.x = _minX + x;
		_bounds.width = _maxX - _minX - x;
	}
}
}