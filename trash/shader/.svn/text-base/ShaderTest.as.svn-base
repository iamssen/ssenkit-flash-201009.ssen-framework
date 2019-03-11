package ssen.core.draw.shader {
import flash.geom.Point;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.filters.ShaderFilter;
import flash.ui.Keyboard;

/**
 * @private
 * @author ssen (i@ssen.name)
 */
public class ShaderTest extends Sprite {

	[Embed(source="/asset/chess.png")]
	public static var testImage : Class;
	private var image : Bitmap;
	private var shaderFilter : ShaderFilter;
	private var shader : TransitionShader;
	private var image2 : Bitmap;
	private var original : BitmapData;

	public function ShaderTest() {
		shader = new TransitionShader();
		shaderFilter = new ShaderFilter(shader);
		
		image = new testImage();
		image2 = new testImage();
		image2.x = image.width + 10;
		original = image.bitmapData.clone();
		applyFilter();
		
		addChild(image);
		addChild(image2);
		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keydown);
		
		graphics.beginFill(0x000000);
		graphics.drawRect(0, 0, 550, 400);
		graphics.endFill();
	}

	private function keydown(event : KeyboardEvent) : void {
		switch (event.keyCode) {
			case Keyboard.UP :
				shader.state += 0.1;
				break;
			case Keyboard.DOWN : 
				shader.state -= 0.1;
				break;
		}
		applyFilter();
	}

	private function applyFilter() : void {
		trace(shader.state, shader.view);
		image.bitmapData.applyFilter(original, image.getRect(this), new Point(), shaderFilter);
		image2.alpha = shader.state;
	}
}
}

import flash.display.Shader;

class TransitionShader extends Shader {

	[Embed(source="alpha_transition.pbj", mimeType="application/octet-stream")]
	private static var shaderData : Class;

	public function TransitionShader() {
		byteCode = new shaderData();
	}

	public function get view() : Number {
		return data.view ? data.view.value[0] : 0;
	}

	public function set view(view : Number) : void {
		if (data.view) data.view.value = [view];
	}

	public function get state() : Number {
		return data.state ? data.state.value[0] : 0;
	}

	public function set state(state : Number) : void {
		if (data.state) data.state.value = [state];
	}
}