package ssen.framework.service {
import ssen.framework.widgets.tips.ITipObject;

import flash.display.DisplayObjectContainer;

/**
 * tip service
 * @author ssen (i@ssen.name)
 */
public interface ITipService {
	/** tip 을 연다 */
	function open(tip : ITipObject) : void

	/** tip 을 닫는다 */
	function close() : void

	/** tip service 의 container */
	function get service() : DisplayObjectContainer
}
}
