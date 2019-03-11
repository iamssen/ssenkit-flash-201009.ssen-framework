package ssen.stutter.elements {
import ssen.stutter.StutterDocument;
import ssen.stutter.elements.IStutterElement;

/**
 * @author ssen (i@ssen.name)
 */
public interface IStutterMediaElement extends IStutterElement {
	function construct(doc : StutterDocument, url : String, width : int = 0, height : int = 0, comment : String = "") : void
}
}
