package ssen.stutter {
import flashx.textLayout.formats.TextAlign;
import flashx.textLayout.formats.TextLayoutFormat;
import flashx.textLayout.formats.VerticalAlign;

import ssen.core.draw.material.RoundRectMaterial;
import ssen.core.draw.material.StripeLine;
import ssen.core.draw.material.StripeMaterial;
import ssen.core.geom.Padding;
import ssen.styles.flour.FlourTextFormatFactory;

import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;

/**
 * @author ssen (i@ssen.name)
 */
public class StutterStyle {
	private var _h1TextFormat : TextLayoutFormat;
	private var _h2TextFormat : TextLayoutFormat;
	private var _h3TextFormat : TextLayoutFormat;
	private var _codeMargin : Padding;
	private var _codePadding : Padding;
	private var _codeTextFormat : TextLayoutFormat;
	private var _codeBoxMaterial : RoundRectMaterial;
	private var _lineMaterial : StripeMaterial;
	private var _linePadding : Padding;
	private var _list1TextFormat : TextLayoutFormat;
	private var _list2TextFormat : TextLayoutFormat;
	private var _list3TextFormat : TextLayoutFormat;
	private var _list4TextFormat : TextLayoutFormat;
	private var _list5TextFormat : TextLayoutFormat;

	public function StutterStyle() {
		var stroke : GraphicsStroke;
		var fill : GraphicsSolidFill;
		
		/* *********************************************************************
		 * code
		 ********************************************************************* */
		_codeMargin = new Padding(10, 10, 30, 30);
		_codePadding = new Padding(20, 20, 20, 20);
		_codeTextFormat = FlourTextFormatFactory.getEmbedSansSerif(11, TextAlign.LEFT, VerticalAlign.TOP, 0xffffff);
		stroke = new GraphicsStroke(3, true);
		stroke.fill = new GraphicsSolidFill(0xffffff);
		_codeBoxMaterial = new RoundRectMaterial(20, 20, new GraphicsSolidFill(0x000000, 0.1), stroke);
		
		/* *********************************************************************
		 * header 
		 ********************************************************************* */
		_h1TextFormat = FlourTextFormatFactory.getEmbedSansSerif(24, TextAlign.LEFT, VerticalAlign.TOP, 0xffffff, true);
		_h1TextFormat.paddingLeft = 0;
		_h1TextFormat.paddingTop = 15;
		_h1TextFormat.paddingRight = 10;
		_h1TextFormat.paddingBottom = 15;
		_h2TextFormat = FlourTextFormatFactory.getEmbedSansSerif(20, TextAlign.LEFT, VerticalAlign.TOP, 0xffffff, true);
		_h2TextFormat.paddingLeft = 15;
		_h2TextFormat.paddingTop = 10;
		_h2TextFormat.paddingRight = 10;
		_h2TextFormat.paddingBottom = 10;
		_h3TextFormat = FlourTextFormatFactory.getEmbedSansSerif(16, TextAlign.LEFT, VerticalAlign.TOP, 0xffffff, true);
		_h3TextFormat.paddingLeft = 30;
		_h3TextFormat.paddingTop = 10;
		_h3TextFormat.paddingRight = 10;
		_h3TextFormat.paddingBottom = 10;
		
		/* *********************************************************************
		 * line 
		 ********************************************************************* */
		_lineMaterial = new StripeMaterial(Vector.<StripeLine>([new StripeLine(2, 0xffffff), new StripeLine(3, 0x000000, 0)]));
		_linePadding = new Padding(15, 15, 20, 20);
		/* *********************************************************************
		 * list 
		 ********************************************************************* */
		_list1TextFormat = FlourTextFormatFactory.getEmbedSansSerif(13, TextAlign.LEFT, VerticalAlign.TOP, 0xffffff);
		_list1TextFormat.paddingLeft = 10;
		_list1TextFormat.paddingTop = 5;
		_list1TextFormat.paddingRight = 10;
		_list1TextFormat.paddingBottom = 5;
		_list2TextFormat = FlourTextFormatFactory.getEmbedSansSerif(12, TextAlign.LEFT, VerticalAlign.TOP, 0xffffff);
		_list2TextFormat.paddingLeft = 20;
		_list2TextFormat.paddingTop = 5;
		_list2TextFormat.paddingRight = 10;
		_list2TextFormat.paddingBottom = 5;
		_list3TextFormat = FlourTextFormatFactory.getEmbedSansSerif(11, TextAlign.LEFT, VerticalAlign.TOP, 0xffffff);
		_list3TextFormat.paddingLeft = 30;
		_list3TextFormat.paddingTop = 5;
		_list3TextFormat.paddingRight = 10;
		_list3TextFormat.paddingBottom = 5;
		_list4TextFormat = FlourTextFormatFactory.getEmbedSansSerif(10, TextAlign.LEFT, VerticalAlign.TOP, 0xffffff);
		_list4TextFormat.paddingLeft = 40;
		_list4TextFormat.paddingTop = 5;
		_list4TextFormat.paddingRight = 10;
		_list4TextFormat.paddingBottom = 5;
		_list5TextFormat = FlourTextFormatFactory.getEmbedSansSerif(10, TextAlign.LEFT, VerticalAlign.TOP, 0xffffff);
		_list5TextFormat.paddingLeft = 50;
		_list5TextFormat.paddingTop = 5;
		_list5TextFormat.paddingRight = 10;
		_list5TextFormat.paddingBottom = 5;
	}

	public function get codeMargin() : Padding {
		return _codeMargin;
	}

	public function get codePadding() : Padding {
		return _codePadding;
	}

	public function get codeTextFormat() : TextLayoutFormat {
		return _codeTextFormat;
	}

	public function get codeBoxMaterial() : RoundRectMaterial {
		return _codeBoxMaterial;
	}

	public function get h1TextFormat() : TextLayoutFormat {
		return _h1TextFormat;
	}

	public function get h2TextFormat() : TextLayoutFormat {
		return _h2TextFormat;
	}

	public function get h3TextFormat() : TextLayoutFormat {
		return _h3TextFormat;
	}

	public function get lineMaterial() : StripeMaterial {
		return _lineMaterial;
	}

	public function get linePadding() : Padding {
		return _linePadding;
	}

	public function get list1TextFormat() : TextLayoutFormat {
		return _list1TextFormat;
	}

	public function get list2TextFormat() : TextLayoutFormat {
		return _list2TextFormat;
	}

	public function get list3TextFormat() : TextLayoutFormat {
		return _list3TextFormat;
	}

	public function get list4TextFormat() : TextLayoutFormat {
		return _list4TextFormat;
	}

	public function get list5TextFormat() : TextLayoutFormat {
		return _list5TextFormat;
	}
}
}
