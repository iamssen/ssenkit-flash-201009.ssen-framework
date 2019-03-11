package ssen.core.net {
import flash.net.URLRequest;

/**
 * 로드 주문서
 * @author ssen(i@ssen.name)
 */
public class LoadOrder {
	/** 로드할 URLRequest */
	public var req : URLRequest;
	/** 로드가 완료된 데이터 */
	public var data : Object;
	/** httpStatus 상태 */
	public var httpStatus : int;
	/** errorMessage */
	public var errorMessage : String;
	/** 변환방식 */
	public var factory : IValueObjectFactory;
	/** 승인을 요청할때 호출해줄 Function */
	public var allow : Function;
	/** order 의 구분자 */
	public var id : String;

	/** order 를 생성한다 */
	public static function get(id : String, req : URLRequest, factory : IValueObjectFactory) : LoadOrder {
		var lo : LoadOrder = LoadOrder(new LoadOrder());
		lo.id = id;
		lo.req = req;
		lo.factory = factory;
		lo.data = null;
		lo.httpStatus = 0;
		lo.errorMessage = "";
		lo.allow = null;
		return lo;
	}

	/** 완료된 order 를 pool 에 반환한다 */
	public static function put(lo : LoadOrder) : void {
		lo.id = "";
		lo.req = null;
		lo.data = null;
		lo.allow = null;
		lo.factory = null;
		lo = null;
	}
}
}
