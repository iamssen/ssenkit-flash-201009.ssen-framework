package ssen.framework.service {
import ssen.framework.widgets.panels.IPanelObject;

import flash.display.DisplayObjectContainer;

/**
 * panel service
 * @author ssen (i@ssen.name)
 */
public interface IPanelService {
	/**
	 * panel 을 연다
	 * @param panel panel
	 * @param state 초기상태
	 */
	function open(panel : IPanelObject, state : String = "run") : void

	/** panel 을 닫는다 */
	function close(panel : IPanelObject) : void

	/** 모든 panel 을 닫는다 */
	function closeAll() : void

	/** panel service 의 container */
	function get service() : DisplayObjectContainer
}
}
