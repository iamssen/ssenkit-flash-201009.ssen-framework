package ssen.core.draw {
import flash.display.Graphics;

/**
 * graphics 에 무언가를 그리는 data 의 interface
 * @author ssen(i@ssen.name)
 */
public interface IDrawData {
	/**
	 * 그린다
	 * @param graphics 그릴 대상이 되는 graphics
	 */
	function draw(graphics : Graphics, state : String = "run", action : String = "default") : void

	/** 그리는데 사용된 리소스들을 제거한다 */
	function deconstruct() : void
}
}
