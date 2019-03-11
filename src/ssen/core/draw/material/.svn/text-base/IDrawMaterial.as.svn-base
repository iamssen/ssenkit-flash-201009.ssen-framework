package ssen.core.draw.material {
import flash.display.Graphics;
import flash.display.GraphicsPath;

/**
 * Graphics 에 드로윙을 할 수 있는 material 의 인터페이스
 * @author ssen(i@ssen.name)
 */
public interface IDrawMaterial {
	/**
	 * 그린다
	 * @param graphics 그릴 대상이 될 graphics
	 * @param x 네모공간을 그릴때 사용되는 rect.x
	 * @param y 네모공간을 그릴때 사용되는 rect.y
	 * @param width 네모공간을 그릴때 사용되는 rect.width
	 * @param height 네모공간을 그릴때 사용되는 rect.height
	 * @param path 네모가 아닌 자유로운 path 를 그릴때 사용됨
	 */
	function draw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void
}
}
