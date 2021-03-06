package ssen.stutter.elements {
import ssen.stutter.StutterDocument;
import ssen.stutter.elements.IStutterElement;

/**
 * @author ssen (i@ssen.name)
 */
public interface IStutterPlainTextElement extends IStutterElement {
	function construct(doc : StutterDocument, text : String) : void
}
}
