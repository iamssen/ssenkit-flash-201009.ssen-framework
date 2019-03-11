package ssen.stutter.elements {
import ssen.stutter.StutterDocument;

/**
 * @author ssen (i@ssen.name)
 */
public interface IStutterHeaderElement extends IStutterElement {
	function construct(doc : StutterDocument, depth : int, title : String) : void
}
}
