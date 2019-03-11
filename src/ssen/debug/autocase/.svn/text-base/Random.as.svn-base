package ssen.debug.autocase {
import ssen.core.MathX;

/**
 * 타입에 상관없는 랜덤한 값을 보내준다
 * @author ssen (i@ssen.name)
 */
public class Random implements IRandomValue {
	/** 랜덤의 요소들 */
	public var values : Array;

	public function Random(values : Array) {
		this.values = values;
	}

	public function getRandom() : * {
		var p : int = MathX.rand(0, values.length - 1);
		return values[p];
	}
}
}
