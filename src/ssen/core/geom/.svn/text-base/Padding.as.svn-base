package ssen.core.geom {
import ssen.debug.tostr;

/**
 * padding
 * @author ssen(i@ssen.name)
 */
public class Padding {
	public var top : Number;
	public var bottom : Number;
	public var left : Number;
	public var right : Number;

	public function Padding(top : Number = 0, bottom : Number = 0, left : Number = 0, right : Number = 0) {
		this.top = top;
		this.bottom = bottom;
		this.left = left;
		this.right = right;
	}

	/** top 과 bottom 의 합 */
	public function get topAndBottom() : Number {
		return top + bottom;
	}

	/** left 와 right 의 합 */
	public function get leftAndRight() : Number {
		return left + right;
	}

	public function clone() : Padding {
		return new Padding(top, bottom, left, right);
	}

	/** @private */
	public function toString() : String {
		return tostr("Padding", {top:top, bottom:bottom, left:left, right:right});
	}
}
}
