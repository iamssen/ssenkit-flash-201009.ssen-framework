package ssen.core.draw.material {
import flash.display.Graphics;
import flash.display.GraphicsPath;

/**
 * 여러개의 material 을 묶어서 상태별로 다르게 그릴 수 있게 하는 material set
 * @author ssen (i@ssen.name)
 */
public interface IDrawMaterialSet {
	/**
	 * 상태를 그린다
	 * @param state 상태 구분
	 * @param action 행동 구분
	 * @param graphics 그릴 대상이 될 graphics
	 * @param x 네모공간을 그릴때 사용되는 rect.x
	 * @param y 네모공간을 그릴때 사용되는 rect.y
	 * @param width 네모공간을 그릴때 사용되는 rect.width
	 * @param height 네모공간을 그릴때 사용되는 rect.height
	 * @param path 네모가 아닌 자유로운 path 를 그릴때 사용됨
	 */
	function draw(state : String, action : String, graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void
}
}
