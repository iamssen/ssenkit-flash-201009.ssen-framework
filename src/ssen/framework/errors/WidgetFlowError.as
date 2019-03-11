package ssen.framework.errors {
import ssen.debug.tostr;
import ssen.framework.widgets.core.IWidget;

/**
 * Widget 을 잘못된 순서로 사용해서 발생하는 에러
 * @author ssen (i@ssen.name)
 */
public class WidgetFlowError extends Error {
	public function WidgetFlowError(widget : IWidget, message : String = "") {
		super(tostr("#WidgetFlowError :: " + message, {constructed:widget.constructed, setted:widget.setted, registered:widget.registered, state:widget.state}));
	}
}
}
