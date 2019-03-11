package ssen.stutter {
import flashx.textLayout.conversion.ITextImporter;
import flashx.textLayout.conversion.TextConverter;
import flashx.textLayout.elements.FlowElement;
import flashx.textLayout.elements.InlineGraphicElement;
import flashx.textLayout.elements.LinkElement;
import flashx.textLayout.elements.ParagraphElement;
import flashx.textLayout.elements.TextFlow;
import flashx.textLayout.formats.ITextLayoutFormat;
import flashx.textLayout.formats.TextAlign;
import flashx.textLayout.formats.TextDecoration;
import flashx.textLayout.formats.TextLayoutFormat;
import flashx.textLayout.formats.VerticalAlign;

import ssen.styles.flour.FlourTextFormatFactory;

import de.polygonal.ds.HashMap;
import de.polygonal.ds.Itr;

import flash.text.FontStyle;
import flash.text.engine.FontWeight;

/**
 * @author ssen (i@ssen.name)
 */
public class StutterImporter implements ITextImporter {
	private var _formats : HashMap;

	/* *********************************************************************
	 * stylize 
	 ********************************************************************* */
	private function stylize(flow : TextFlow) : TextFlow {
		if (!flow) return flow;
		flow.format = ITextLayoutFormat(_formats.get("flow"));
		flow.linkNormalFormat = ITextLayoutFormat(_formats.get("link"));
		
		var itr : Itr = Itr(_formats.iterator());
		var els : Array;
		var el : FlowElement;
		var fmt : ITextLayoutFormat;
		var key : String;
		var f : int;
		var mediaLink : ITextLayoutFormat = ITextLayoutFormat(_formats.get("mediaLink"));
		while(itr.hasNext()) {
			key = String(itr.next());
			if (key != "flow" || key != "link" || key != "mediaLink") {
				els = flow.getElementsByStyleName(key);
				fmt = ITextLayoutFormat(_formats.get(key));
				f = -1;
				while(++f < els.length) {
					el = els[f];
					el.format = fmt;
					
					switch(key) {
						case "media" :
							el.linkNormalFormat = mediaLink;
							break;
					}
				}
			}
		}
		
		var p : ParagraphElement;
		var img : InlineGraphicElement;
		
		els = flow.getElementsByStyleName("line");
		f = -1;
		while(++f < els.length) {
			p = els[f];
			img = new InlineGraphicElement();
			img.source = StutterLine.get(compositionWidth);
			p.addChild(img);
		}
		
		var link : LinkElement;
		
		if (_code.length > 0) {
			f = -1;
			while(++f < _code.length) {
				img = new InlineGraphicElement();
				img.source = StutterCode.get(compositionWidth, _code[f], mediaLink);
				link = new LinkElement();
				link.href = "@code";
				link.addChild(img);
				p = ParagraphElement(flow.getElementByID("code" + f));
				p.linkNormalFormat = mediaLink;
				p.addChild(link);
			}
			_code.length = 0;
		}
		
		return flow;
	}

	public var compositionWidth : int = 500;
	private var _importer : ITextImporter;
	private var _padding : int;
	private var _result : String;
	private var _vars : HashMap;
	private var _paragraph : Boolean;
	private var _list : Boolean;

	public function StutterImporter() {
		_importer = TextConverter.getImporter(TextConverter.TEXT_LAYOUT_FORMAT);
		_vars = new HashMap();
		
		_formats = new HashMap();
		
		var format : TextLayoutFormat;
		
		format = FlourTextFormatFactory.getEmbedSansSerif(12, TextAlign.LEFT, VerticalAlign.TOP, 0x000000);
		_formats.set("flow", format);
		
		format = new TextLayoutFormat();
		format.fontSize = 24;
		format.fontWeight = FontWeight.BOLD;
		format.paragraphSpaceBefore = 15;
		format.paragraphSpaceAfter = 5;
		_formats.set("header1", format);
		
		format = new TextLayoutFormat();
		format.fontSize = 18;
		format.fontWeight = FontWeight.BOLD;
		format.paragraphStartIndent = 15;
		_formats.set("header2", format);
		
		format = new TextLayoutFormat();
		format.fontSize = 15;
		format.fontWeight = FontWeight.BOLD;
		format.paragraphStartIndent = 30;
		_formats.set("header3", format);
		
		format = new TextLayoutFormat();
		format.paragraphSpaceAfter = 5;
		format.paragraphStartIndent = 2;
		format.lineHeight = "140%";
		_formats.set("document1", format);
		
		format = new TextLayoutFormat();
		format.paragraphSpaceAfter = 5;
		format.paragraphStartIndent = 17;
		format.lineHeight = "140%";
		_formats.set("document2", format);
		
		format = new TextLayoutFormat();
		format.paragraphSpaceAfter = 5;
		format.paragraphStartIndent = 32;
		format.lineHeight = "140%";
		_formats.set("document3", format);
		
		format = new TextLayoutFormat();
		format.fontWeight = FontWeight.BOLD;
		_formats.set("strong", format);
		
		format = new TextLayoutFormat();
		format.lineThrough = true;
		format.color = 0x999999;
		_formats.set("s", format);
		
		format = new TextLayoutFormat();
		format.textDecoration = TextDecoration.UNDERLINE;
		_formats.set("em", format);
		
		format = new TextLayoutFormat();
		format.fontStyle = FontStyle.ITALIC;
		_formats.set("dfn", format);
		
		format = new TextLayoutFormat();
		format.fontWeight = FontWeight.BOLD;
		format.fontSize = "13";
		format.color = 0xda5013;
		_formats.set("highlight", format);
		
		format = new TextLayoutFormat();
		format.textAlign = TextAlign.CENTER;
		format.fontSize = 10;
		_formats.set("media", format);
		
		format = new TextLayoutFormat();
		format.textDecoration = TextDecoration.UNDERLINE;
		format.color = 0x5f7ad0;
		_formats.set("link", format);
		
		format = new TextLayoutFormat();
		format.color = 0x5f7ad0;
		_formats.set("mediaLink", format);
		
		format = new TextLayoutFormat();
		format.color = 0x555555;
		format.paragraphSpaceBefore = 10;
		format.paragraphSpaceAfter = 10;
		_formats.set("text", format);
		
		format = new TextLayoutFormat();
		format.fontSize = 1;
		format.textAlign = TextAlign.CENTER;
		format.paragraphSpaceBefore = 10;
		format.paragraphSpaceAfter = 10;
		_formats.set("code", format);
	}

	/* *********************************************************************
	 * plug in 
	 ********************************************************************* */
	protected function text(data : Array) : void {
		var f : int = data.length;
		var l : String;
		while (--f >= 0) {
			l = data[f];
			l = l.replace(/&/g, "&amp;");
			l = l.replace(/</g, "&lt;");
			l = l.replace(/\>/g, "&gt;");
			l = l.replace(/"/g, "&quot;");
			data[f] = l;
		}
		_result += '<p styleName="text" whiteSpaceCollapse="preserve"><span>' + data.join("\n") + '</span></p>';
	}

	private var _code : Vector.<String> = new Vector.<String>();

	protected function code(data : Array) : void {
		_code.push(data.join("\n"));
		_result += '<p styleName="code" id="code' + (_code.length - 1) + '"></p>';
	}

	/* *********************************************************************
	 * parse 
	 ********************************************************************* */
	private function parse(source : String) : TextFlow {
		var lines : Array = source.split("\n");
		var line : String;
		
		_padding = 1;
		_result = "";
		
		var exp : RegExp;
		var expResult : *;
		var module : Boolean = false;
		var moduleName : String = "";
		var moduleData : Array;
		
		var lineLength : int = lines.length;
		var f : int = -1;
		
		while (++f < lineLength) {
			line = lines[f];
			
			// 모듈 처리
			if (module) {
				exp = /\={3,}\s*$/;
				if (exp.test(line)) {
					this[moduleName](moduleData);
					module = false;
					moduleName = "";
					moduleData = null;
				} else {
					moduleData.push(line);
				}
				continue;
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
		
		endTags();
		
		_result = '<TextFlow xmlns="http://ns.adobe.com/textLayout/2008" whiteSpaceCollapse="collapse">' + _result + '</TextFlow>';
		return stylize(_importer.importToFlow(_result));
	}	

	private function paragraph(line : String) : void {
		_result += '<p styleName="document' + _padding + '"><span>' + lineParser(line);
		_paragraph = true;
	}

	private function br(line : String) : void {
		_result += "<br />" + lineParser(line);
	}

	private function lineParser(line : String) : String {
		var r : RegExp;
		var m : *;
		var v : *;
		var command : String;
		var f : int;
		var mLength : int;
		var title : String;
		
		
		r = /\$\{(.*?)\}/g;
		m = line.match(r);
		mLength = m ? m["length"] : 0;
		if (mLength > 0) {
			f = -1;
			while (++f < mLength) {
				command = m[f];
				title = command.substring(2, command.length - 1);
				if (_vars.has(title)) line = line.replace(command, _vars.get(title));
			}
		}
		
		line = this.linkParser(line);
		
		r = /\-(.*?)\-/g;
		m = line.match(r);
		mLength = m ? m["length"] : 0;
		if (mLength > 0) {
			f = -1;
			while (++f < mLength) {
				command = m[f];
				line = line.replace(command, '</span><span styleName="s">' + command.substring(1, command.length - 1) + '</span><span>');
			}
		}
		
		r = /\_(.*?)\_/g;
		m = line.match(r);
		mLength = m ? m["length"] : 0;
		if (mLength > 0) {
			f = -1;
			while (++f < mLength) {
				command = m[f];
				line = line.replace(command, '</span><span styleName="em">' + command.substring(1, command.length - 1) + '</span><span>');
			}
		}
		
		r = /\*(.*?)\*/g;
		m = line.match(r);
		mLength = m ? m["length"] : 0;
		if (mLength > 0) {
			f = -1;
			while (++f < mLength) {
				command = m[f];
				line = line.replace(command, '</span><span styleName="strong">' + command.substring(1, command.length - 1) + '</span><span>');
			}
		}
		
		r = /!(.*?)!/g;
		m = line.match(r);
		mLength = m ? m["length"] : 0;
		if (mLength > 0) {
			f = -1;
			while (++f < mLength) {
				command = m[f];
				line = line.replace(command, '</span><span styleName="dfn">' + command.substring(1, command.length - 1) + '</span><span>');
			}
		}
		
		r = /\[(\w+)\:(.*?)\]/g;
		m = line.match(r);
		mLength = m ? m["length"] : 0;
		if (mLength > 0) {
			f = -1;
			while (++f < mLength) {
				command = m[f];
				v = /\[(\w+)\:(.*?)\]/.exec(command);
				if (v) {
					line = line.replace(command, '</span><span styleName="' + v[1] + '">' + v[2] + '<\/span><span>');
				}
			}
		}
		
		return line;
	}

	private function list(line : String) : void {
		var r : RegExp = /^(\*+|\++)\s(.+)$/;
		var v : * = r.exec(line);
		var symbol : String = v[1];
		var depth : int = symbol.length;
		
		if (!_list) {
			//_result += "<ol>\n";
			_list = true;
		}
		
		//_result += listParser(symbol.charAt(0), depth, v[2]);
	}

	private function listParser(symbol : String, depth : int, str : String) : String {
		if (depth > 5) depth = 5;
		return '<li class="' + ((symbol == "*" ? "unordered" : "ordered") + depth) + '">' + linkParser(str) + '</li>';
	}

	private function linkParser(line : String) : String {
		var r : RegExp = /<(.*?)>/g;
		var m : * = line.match(r);
		var mLength : int = m ? m["length"] : 0;
		if (mLength > 0) {
			var f : int = -1;
			var url : String;
			var title : String;
			while (++f < mLength) {
				var command : String = m[f];
				var prop : Array = properties(command.substring(1, command.length - 1), ",");
				
				if (prop.length > 1) {
					url = prop[0];
					title = prop[1];
				} else {
					url = title = prop[0];
				}
				
				if (/^\w+@[a-zA-Z_]+?\.[a-zA-Z\._]+$/.test(url)) {
					url = "mailto:" + url;
				}
				
				var propString : String = ' href="' + url + '"';
				if (prop.length > 2) propString += ' target="' + prop[2] + '"';
				
				line = line.replace(command, '</span><a' + propString + '><span>' + title + '</span></a><span>');
			}
		}
		return line;
	}

	private function properties(cmd : String, d : String = ",") : Array {
		var items : Array;
		var exp : RegExp = new RegExp(d, "");
		if (exp.test(cmd)) {
			items = cmd.split(d);
			var itemsLength : int = items.length;
			var f : int = -1;
			exp = /^\s*|\s*$/;
			while (++f < itemsLength) {
				items[f] = String(items[f]).replace(exp, "");
			}
		} else {
			items = [cmd];
		}
		return items;
	}

	private function mediaParser(line : String) : void {
		var url : String;
		var width : int;
		var height : int;
		var comment : String;
		var link : String;
		var target : String;
		var prop : Array = this.properties(line.replace(/^:{2,}\s*(.+)$/, "$1"), ",");
		var propString : String;
		var linkString : String = "";
		url = prop[0];
		width = (prop.length > 1 && prop[1] != "") ? Number(prop[1]) : 0;
		height = (prop.length > 2 && prop[2] != "") ? Number(prop[2]) : 0;
		comment = (prop.length > 3 && prop[3] != "") ? prop[3] : "";
		link = (prop.length > 4 && prop[4] != "") ? prop[4] : "";
		target = (prop.length > 5 && prop[5] != "") ? prop[5] : "";
		
		if (link != "") {
			linkString = '<a href="' + link + '"';
			if (target != "") {
				linkString += ' target="' + target + '">';
			}
		}
		
		//var exp : RegExp = /\.(png|jpg|gif|swf|ogg|mp4|ogv|wma|wmv|flv|f4v|mp3)/i;
		var result : String = '<p styleName="media">';
		var capture : Boolean = false;
		if (/\.(png|jpg|gif)$/i.test(url)) {
			propString = ' styleName="image" source="' + url + '"';
			if (width > 0) propString += ' width="' + width + '"';
			if (height > 0) propString += ' height="' + height + '"';
			//if (comment != "") propString += ' title="' + comment + '"';
			capture = true;
			if (linkString != "") {
				result += linkString + "<img" + propString + " />" + "</a>";
			} else {
				result += '<img' + propString + ' />';
			}
		} else if (/\.(swf)/i.test(url)) {
			//trace("????", url);
		} else if (/\.mp4$/i.test(url)) {
			//result += '<video id="video" width="' + width + '" height="' + height + '" controls="controls"><source src="' + url + '" type="video/mp4" /><object width="' + width + "" height="" + height + ""><param name="movie" value="FLVPlay.swf" /><param name="flashvars" value="url=" + url + "" /><param name="allowfullscreen" value="true" /><embed src="FLVPlay.swf" width="" + width + "" height="" + height + "" flashvars="url=" + url + "" allowfullscreen="true"></embed></object></video>";
			capture = true;
		} else if (/\.(flv|f4v|mp4)$/i.test(url)) {
			//result += "<object width="" + width + "" height="" + height + ""><param name="movie" value="FLVPlay.swf" /><param name="flashvars" value="url=" + url + "" /><param name="allowfullscreen" value="true" /><embed src="FLVPlay.swf" width="" + width + "" height="" + height + "" flashvars="url=" + url + "" allowfullscreen="true"></embed></object>";
			capture = true;
		} else if (/\.(ogg|mp3)/i.test(url)) {
		} else if (/\.ogv/i.test(url)) {
		} else {
			//trace("XXX");
		}
		
		if (comment != "" && linkString != "") comment = linkString + comment + "</a>";
		
		if (capture) {
			_result += result + (comment != "" ? "<br />" + comment : "") + "</p>";
		}
	}

	private function horizontalLine() : void {
		_result += '<p styleName="line" />';
	}

	private function header(depth : int, title : String) : void {
		if (depth > 3) depth = 3;
		_padding = depth;
		//this._headers.push("<li class="header" + depth + ""><a href="#" + depth + "_" + title + "">" + title + "</a></li>");
		_result += '<p styleName="header' + depth + '"><span>' + title + '</span></p>';
		//_result += "<a name="" + depth + "_" + title + "" href="#documentTop"><h" + depth + " class="" + this.getPadding() + "">" + title + "</h" + depth + "></a>";
	}

	private function lineBreak() : void {
		listBreak();
		if (_paragraph) {
			_result += '</span></p>';
			_paragraph = false;
		}
	}

	private function listBreak() : void {
		if (_list) {
			//_result += "</ol>";
			_list = false;
		}
	}

	private function endTags() : void {
		lineBreak();
	}

	/* *********************************************************************
	 * implements ITextImporter 
	 ********************************************************************* */
	public function get errors() : Vector.<String> {
		return _importer.errors;
	}

	public function get throwOnError() : Boolean {
		return _importer.throwOnError;
	}

	public function set throwOnError(value : Boolean) : void {
		_importer.throwOnError = value;
	}

	public function importToFlow(source : Object) : TextFlow {
		return parse(String(source));
	}
}
}
