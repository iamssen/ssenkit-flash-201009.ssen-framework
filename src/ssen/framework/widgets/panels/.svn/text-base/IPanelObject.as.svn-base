package ssen.framework.widgets.panels {
import ssen.framework.widgets.core.IWidget;

import de.polygonal.ds.DLLNode;

import flash.events.IEventDispatcher;

/**
 * 본문 공간 윗쪽에 떠서 상세 컨텐츠를 진행하는 패널 오브젝트의 인터페이스
 * @author ssen (i@ssen.name)
 */
public interface IPanelObject extends IWidget, IEventDispatcher {
	/** Linked List 가 사용하는 node 캐시 */
	function get node() : DLLNode

	function set node(node : DLLNode) : void

	/** 어떻게 포지션 될지를 구현함 */
	function rePositioning() : void 

	/** form panel 일 경우, form 의 결정값 */
	function value() : Object
}
}
