package ssen.core.net {
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLStream;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.text.Font;
import flash.utils.ByteArray;

/**
 * 폰트들을 읽어내서 register 시켜준다
 * @author ssen (i@ssen.name)
 */
public class FontObjectFactory implements IValueObjectFactory {
	private var _loader : Loader;
	private var _context : LoaderContext;
	private var _respond : Function;
	private var _fonts : Array;

	/**
	 * construct
	 * @param fonts register 시킬 폰트리스트 ex : ssen.fonts.NanumGothic
	 * @param context LoaderContext
	 * @param uc 포함시켜줄 UnloadCollection
	 */
	public function FontObjectFactory(fonts : Array, context : LoaderContext = null, uc : UnloadCollection = null) {
		_fonts = fonts;
		_loader = new Loader();
		_context = context;
		if (uc) uc.add(_loader);
	}

	/** @inheritDoc */
	public function convert(stream : URLStream, respond : Function) : void {
		var bytes : ByteArray = new ByteArray();
		stream.readBytes(bytes);
		_respond = respond;
		_loader.loadBytes(bytes, _context);
		_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
	}

	private function complete(event : Event) : void {
		var domain : ApplicationDomain = _loader.contentLoaderInfo.applicationDomain;
		var f : int = -1;
		var clname : String;
		while(++f < _fonts.length) {
			clname = _fonts[f];
			Font.registerFont(Class(domain.getDefinition(clname)));
		}
			
		_respond(_fonts);
		_respond = null;
		_context = null;
		_fonts = null;
		_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, complete);
	}
}
}
