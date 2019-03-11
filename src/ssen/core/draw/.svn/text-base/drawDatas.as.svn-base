package ssen.core.draw {
import flash.display.Graphics;
/**
 * 여러개의 IDrawData 를 한꺼번에 그린다
 * @author ssen(i@ssen.name)
 */
public function drawDatas(graphics : Graphics, datas : Array, state : String = "run", action : String = "default") : void {
	var f : int = -1;
	var data : IDrawData;
	while(++f < datas.length) {
		data = datas[f];
		data.draw(graphics, state, action);
	}
}
}
