package ssen.framework.widgets.selection {

/**
 * Selection Item 의 인터페이스
 * @author ssen (i@ssen.name)
 */
public interface ISelectionItem {
	/** selection 상태 */
	function get selection() : Boolean

	function set selection(selection : Boolean) : void

	/** selection item 에 지정된 값 */
	function get selectionValue() : Object
}
}
