package ssen.stutter.elements {
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;

/**
 * @author ssen (i@ssen.name)
 */
public interface IStutterElement extends IEventDispatcher {
	function deconstruct() : void

	function get y() : int

	function set y(y : int) : void

	function get height() : int

	function get display() : DisplayObject
}
}
