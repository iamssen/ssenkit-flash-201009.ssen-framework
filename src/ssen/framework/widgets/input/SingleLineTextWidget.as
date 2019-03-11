package ssen.framework.widgets.input {

/**
 * 한줄 입력 텍스트
 * @author ssen (i@ssen.name)
 */
public class SingleLineTextWidget extends TextWidget {
	//	/** setting */
	//	public function setting_SingleLineTextWidget(service : DisplayObjectContainer = null, index : int = -1, state : String = "run", 
	//		width : int = 100, // 0
	//		height : int = 30, // 1
	//		text : String = "", // 2
	//		initText : String = "", // 3
	//		textFormat : TextFormat = null, //4
	//		textPadding : Padding = null, // 5
	//		disableColor : int = 0xcccccc, // 6
	//		editingMode : String = "readWrite", // 7
	//		inputType : String = "all"
	//		) : void {
	//		setting(service, index, state, width, height, text, initText, textFormat, textPadding, disableColor, editingMode, inputType);
	//	}
	/** @copy ssen.framework.widgets.input.TextInput#wsetting() */
	override protected function wsetting(config : Array) : void {
		switch (config[8]) {
			case InputType.NUMBER :
				field.restrict = "0-9 - .";
				field.displayAsPassword = false;
				break;
			case InputType.PASSWORD : 
				field.restrict = " -~";
				field.displayAsPassword = true;
				break;
			case InputType.ALPHABET : 
				field.restrict = " -~";
				field.displayAsPassword = false;
				break;
			case InputType.EMAIL :
				field.restrict = "@-Z a-z 0-9 . _ -";
				field.displayAsPassword = false; 
				break;
			default : 
				field.restrict = null;
				field.displayAsPassword = false;
				break;
		}
		field.multiline = false;
		super.wsetting(config);
	}
}
}
