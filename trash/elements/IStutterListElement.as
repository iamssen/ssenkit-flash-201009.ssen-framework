package ssen.stutter.elements {
import ssen.stutter.StutterDocument;

/**
 * @author ssen (i@ssen.name)
 */
public interface IStutterListElement extends IStutterElement {
	function construct(doc : StutterDocument, lists : Vector.<StutterListItem>) : void
}
}
