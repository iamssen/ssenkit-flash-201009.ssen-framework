package ssen.core.net {
import flash.display.Loader;

/**
 * unload 될 loader들을 수집하고, 한꺼번에 unload 시킨다
 * @author ssen(i@ssen.name)
 */
public class UnloadCollection {
	private var _col : Vector.<Loader>;

	public function UnloadCollection() {
		_col = new Vector.<Loader>;
	}

	/** loader 를 추가한다 */
	public function add(loader : Loader) : void {
		_col.push(loader);
	}

	/** loader 들을 한꺼번에 unload 시킨다 */
	public function unloadAndStop() : void {
		var f : int = _col.length;
		while (--f >= 0) {
			_col[f].unloadAndStop();
		}
		_col.length = 0;
	}
}
}
