package ssen.core.draw.material {
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.GraphicsPath;
import flash.geom.Matrix;
import flash.geom.Rectangle;

/**
 * Bitmap 을 매개로 하는 material [path 옵션을 받지 않는다]
 * @author ssen(i@ssen.name)
 */
public class BitmapMaterial implements IDrawMaterial {
	/** 매개가 될 bitmapData */
	public var bitmap : BitmapData;
	/** bitmapData 의 smooth 옵션 */
	public var smooth : Boolean;
	/** scale9Grid 를 지정할 경우 scale bitmap 으로 그림 */
	public var scale9Grid : Rectangle;

	/**
	 * construct
	 * @param bitmap 매개가 될 bitmapData
	 * @param smooth bitmapData 의 smooth 옵션
	 * @param scale9Grid scale9Grid 를 지정할 경우 scale bitmap 으로 그림
	 */
	public function BitmapMaterial(bitmap : BitmapData, smooth : Boolean = false, scale9Grid : Rectangle = null) {
		this.bitmap = bitmap;
		this.smooth = smooth;
		this.scale9Grid = scale9Grid;
	}

	/** @inheritDoc */
	public function draw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		if (!scale9Grid) {
			defaultDraw(graphics, x, y, width, height);
		} else {
			var mat : Matrix;
			var topFix : Number = scale9Grid.top;
			var bottomFix : Number = bitmap.height - scale9Grid.top - scale9Grid.height;
			var leftFix : Number = scale9Grid.left;
			var rightFix : Number = bitmap.width - scale9Grid.left - scale9Grid.width;
			
			var min : Number;
			var ow : Number = bitmap.width;
			var oh : Number = bitmap.height;
			var cols : Array;
			var dCols : Array;
			var rows : Array;
			var dRows : Array;
				
			var origin : Rectangle;
			var draw : Rectangle;
			
			var cy : int;
			var cx : int;
			if (scale9Grid.x == 0 && (scale9Grid.width == width || scale9Grid.width == 0)) {
				min = topFix + bottomFix;
					
				if (height > min) {
					mat = new Matrix();
					rows = [0, topFix, oh - bottomFix, oh];
					dRows = [0, topFix, height - bottomFix, height];
				
					cy = -1;
					while(++cy < 3) {
						origin = new Rectangle(0, rows[cy], width, rows[cy + 1] - rows[cy]);
						draw = new Rectangle(0, dRows[cy], width, dRows[cy + 1] - dRows[cy]);
						mat.identity();
						mat.a = width / bitmap.width;
						mat.d = draw.height / origin.height;
						mat.tx = (draw.x - origin.x * mat.a) + x;
						mat.ty = (draw.y - origin.y * mat.d) + y;
						scaleDraw(graphics, x, y, draw, mat);
					}
				} else {
					defaultDraw(graphics, x, y, width, height);
				}
			} else if (scale9Grid.y == 0 && (scale9Grid.height == height || scale9Grid.height == 0)) {
				min = leftFix + rightFix;
				if (width > min) {
					mat = new Matrix();
					cols = [0, leftFix, ow - rightFix, ow];
					dCols = [0, leftFix, width - rightFix, width];
						
					cx = -1;
					while(++cx < 3) {
						origin = new Rectangle(cols[cx], 0, cols[cx + 1] - cols[cx], height);
						draw = new Rectangle(dCols[cx], 0, dCols[cx + 1] - dCols[cx], height);
						mat.identity();
						mat.a = draw.width / origin.width;
						mat.d = height / bitmap.height;
						mat.tx = (draw.x - origin.x * mat.a) + x;
						mat.ty = (draw.y - origin.y * mat.d) + y;
						scaleDraw(graphics, x, y, draw, mat);
					}
				} else {
					defaultDraw(graphics, x, y, width, height);
				}
			} else {
				min = topFix + bottomFix;
				ow = bitmap.width;
				oh = bitmap.height;
				if (height > min) {
					mat = new Matrix();
					cols = [0, leftFix, ow - rightFix, ow];
					dCols = [0, leftFix, width - rightFix, width];
					rows = [0, topFix, oh - bottomFix, oh];
					dRows = [0, topFix, height - bottomFix, height];
						
					cx = -1;
					while(++cx < 3) {
						cy = -1;
						while(++cy < 3) {
							origin = new Rectangle(cols[cx], rows[cy], cols[cx + 1] - cols[cx], rows[cy + 1] - rows[cy]);
							draw = new Rectangle(dCols[cx], dRows[cy], dCols[cx + 1] - dCols[cx], dRows[cy + 1] - dRows[cy]);
							mat.identity();
							mat.a = draw.width / origin.width;
							mat.d = draw.height / origin.height;
							mat.tx = (draw.x - origin.x * mat.a) + x;
							mat.ty = (draw.y - origin.y * mat.d) + y;
							scaleDraw(graphics, x, y, draw, mat);
						}
					}
				} else {
					defaultDraw(graphics, x, y, width, height);
				}
			}
		}
	}

	private function scaleDraw(graphics : Graphics, x : Number, y : Number, draw : Rectangle, mat : Matrix) : void {
		graphics.beginBitmapFill(bitmap, mat, false, smooth);
		graphics.drawRect(draw.x + x, draw.y + y, draw.width, draw.height);
		graphics.endFill();
	}

	private function defaultDraw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number) : void {
		var mat : Matrix = new Matrix();
		mat.a = width / bitmap.width;
		mat.d = height / bitmap.height;
		mat.tx = x;
		mat.ty = y;
				
		graphics.beginBitmapFill(bitmap, mat, false, smooth);
		graphics.drawRect(x, y, width, height);
		graphics.endFill();
	}
}
}
