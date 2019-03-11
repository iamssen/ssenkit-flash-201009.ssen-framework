package ssen.framework.widgets.core {
import flash.display.DisplayObjectContainer;

/**
 * @author ssen(i@ssen.name)
 */
public interface IWidget {
	/**  생성 : 자원들이 생성됨 */
	function construct() : void

	/** 파괴 */
	function deconstruct() : void

	/**
	 * 설정 : 상태에 대한 값들을 설정가능해짐
	 * @param config 설정
	 * @param service display 를 등록시킬 container
	 * @param index display 를 등록시킬 container index
	 * @param initializeState 초기 state 설정
	 */
	function setting(service : DisplayObjectContainer = null, index : int = -1, initializeState : String = "run", ...config : Array) : void

	/** 설정 해제 */
	function unsetting() : void

	/** 등록 : 실 서비스에 동작되도록 등록시킴 */
	function register() : void

	/** 등록 해제 */
	function deregister() : void

	/** 등록 되었는지 여부 */
	function get registered() : Boolean

	/** 설정 되었는지 여부 */
	function get setted() : Boolean

	/** 생성 되었는지 여부 */
	function get constructed() : Boolean

	/** 현재 widget 의 상태 {setting} */
	function get state() : String

	function set state(state : String) : void
}
}
