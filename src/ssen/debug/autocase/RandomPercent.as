package ssen.debug.autocase {
import ssen.core.MathX;

/**
 * 0~1 사이의 랜덤한 값을 내보내준다
 * @author ssen (i@ssen.name)
 */
public class RandomPercent implements IRandomValue {
	public function getRandom() : * {
		return MathX.rand(1, 10000) / 10000;
	}
}
}
