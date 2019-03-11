package ssen.debug {
import flash.external.ExternalInterface;
/**
 * 형식이 있는 trace 구문을 리턴해준다
 * @author ssen(i@ssen.name)
 */
public function tostr(msg : String, props : Object, traceNow : Boolean = false, jsConsole : Boolean = false) : String {
	var arr : Vector.<String> = new Vector.<String>();
	for (var key : String in props) {
		arr.push(key + ":" + props[key]);
	}
	var str : String = "#" + msg + " {" + arr.join(", ") + "}";
	if (traceNow) trace(str);
	if (jsConsole) ExternalInterface.call("console.log", str); 
	return str;
}
}
