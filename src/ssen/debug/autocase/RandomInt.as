package ssen.debug.autocase {
import ssen.core.MathX;

/**
 * min, max 사이에서 정수형의 랜덤값을 내보내준다
 * @author ssen (i@ssen.name)
 */
public class RandomInt implements IRandomValue {
	public var min : int;
	public var max : int;

	public function RandomInt(min : int, max : int) {
		this.min = min;
		this.max = max;
	}

	public function getRandom() : * {
		return MathX.rand(min, max);
	}
}
}
