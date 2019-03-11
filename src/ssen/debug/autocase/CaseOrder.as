package ssen.debug.autocase {

/**
 * 테스트 될 메서드를 정의
 * @author ssen (i@ssen.name)
 */
public class CaseOrder implements ICaseCommand {
	/** 메서드의 이름 */
	public var name : String;
	/** Array<IRandomValue> 로 이루어지는 메서드의 속성들 */
	public var values : Array;

	public function CaseOrder(name : String, values : Array) {
		this.name = name;
		this.values = values;
	}

	public function get displayName() : String {
		return name + "()";
	}
}
}
