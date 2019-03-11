package ssen.core {

/**
 * @author ssen (i@ssen.name)
 */
public class StringX {
	public static function parseFileName(fileName : String) : Array {
		var arr : Array = fileName.split(".");
		var extension : String = arr.pop();
		return [arr.join("."), extension];
	}

	public static function randString(length : int = 8) : String {
		var str : String = "";
		length++;
		while (--length >= 0) {
			str += MathX.rand(0, 14).toString(16);
		}
		return str;
	}

	public static function clearBlank(text : String) : String {
		return text.replace(/^\s*|\s*$/g, "");
	}
}
}
