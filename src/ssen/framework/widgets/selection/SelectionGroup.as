package ssen.framework.widgets.selection {
import ssen.framework.widgets.selection.events.SelectionEvent;

import flash.events.EventDispatcher;

/**
 * 여럿중 하나 또는 다중 선택하는 형태의 SelectionGroup
 * @author ssen (i@ssen.name)
 */
public class SelectionGroup extends EventDispatcher implements ISelection {
	private var _single : ISelectionItem;
	private var _multi : Boolean;
	private var _items : Vector.<ISelectionItem>;

	/**
	 * constructor
	 * @param multiSelection 다중 선택 가능하게 할 것인지 결정
	 */
	public function SelectionGroup(multiSelection : Boolean = false) {
		_items = new Vector.<ISelectionItem>();
		_multi = multiSelection;
	}

	/** 사용된 자원들을 모두 참조해제 시킨다 */
	public function deconstruct() : void {
		_items.length = 0;
		_items = null;
	}

	/** 아이템을 추가한다 */
	public function addItem(item : ISelectionItem) : void {
		_items.push(item);
		if (!_multi && item.selection) {
			if (_single) _single.selection = false;
			_single = item;
		}
	}

	public function clearItems() : void {
		_items.length = 0;
	}

	/** @inheritDoc */
	public function get multiSelection() : Boolean {
		return _multi;
	}

	public function set multiSelection(multi : Boolean) : void {
		_multi = multi;
		_single = null;
		var f : int = -1;
		while(++f < _items.length) {
			_items[f].selection = false;
		}
	}

	/** @inheritDoc */
	public function selectedItems() : Vector.<ISelectionItem> {
		var list : Vector.<ISelectionItem> = new Vector.<ISelectionItem>();
		var f : int = -1;
		while(++f < _items.length) {
			if (_items[f].selection) {
				list.push(_items[f]);
				if (!_multi) return list;
			}
		}
		return list;
	}

	/** @inheritDoc */
	public function selection(item : ISelectionItem, selection : Boolean) : void {
		if (!_multi && selection) {
			if (_single) _single.selection = false;
			item.selection = true;
			_single = item;
		} else if (item == _single && !selection) {
			item.selection = false;
			_single = null;
		} else {
			item.selection = selection;
		}
			
		dispatchEvent(new SelectionEvent(SelectionEvent.SELECTION, this));
	}
}
}
