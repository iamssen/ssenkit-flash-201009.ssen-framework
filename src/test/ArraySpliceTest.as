package test {
import flash.display.Sprite;

/**
 * @author ssen (i@ssen.name)
 */
public class ArraySpliceTest extends Sprite {
	public function ArraySpliceTest() {
		var arr : Array = [0,1,2,3,4,5,6,7,8,9,10];
		var arr2 : Array = arr.splice(3, 3);
		trace(arr2, arr);
		trace(arr.concat(arr2));
		trace(arr);
		trace(arr[11]);
		arr.splice(0, 10);
		trace(arr);
	}
}
}
