package ssen.core.net {
import flash.net.URLStream;

/**
 * String 형태로 변환해준다
 * @author ssen(i@ssen.name)
 */
public class StringObjectFactory implements IValueObjectFactory {
	private var _charSet : String;

	/** 
	 * construct
	 * @param charSet 인코딩 설정
	 */
	public function StringObjectFactory(charSet : String = "utf-8") {
		_charSet = charSet;
	}

	/** @inheritDoc */
	public function convert(stream : URLStream, respond : Function) : void {
		respond(stream.readMultiByte(stream.bytesAvailable, _charSet));
	}
}
}
