package ssen.framework.widgets.selection {

/**
 * @author ssen (i@ssen.name)
 */
public interface ISelection {
	/** 다중 선택 설정 */
	function get multiSelection() : Boolean

	/** 선택된 아이템들 */
	function selectedItems() : Vector.<ISelectionItem>

	/** 특정 아이템을 선택 또는 해지 시킨다 */
	function selection(item : ISelectionItem, selection : Boolean) : void
}
}
