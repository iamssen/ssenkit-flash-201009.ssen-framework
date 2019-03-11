package ssen.core.net {

/**
 * 원격의 자료를 호출해서 소비하는 Consumer Interface
 * @author ssen(i@ssen.name)
 */
public interface ILoaderConsumer {
	/** 로드할 주문서 */
	function get order() : LoadOrder

	/** 다음 주문서가 있는지 확인 */
	function get hasNextOrder() : Boolean

	/** 주문한 결과물을 전달받음 */
	function recive(order : LoadOrder) : void

	/** 주문을 로드할 수 없을때 에러를 전달받음 */
	function reciveFail(order : LoadOrder) : void

	/** 주문을 처리하는 과정에서 승인이 필요할때 (보안에러 등으로 인해) */ 
	function allow(order : LoadOrder) : void

	/** 주문처리 상태를 안내 0 ~ 1 */
	function progress(progress : Number) : void

	/** 모든 주문을 완료했을때 알림 */
	function completeOrders() : void
}
}
