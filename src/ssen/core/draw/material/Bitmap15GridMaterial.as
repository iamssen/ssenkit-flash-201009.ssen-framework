package ssen.core.draw.material {
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.GraphicsPath;
import flash.geom.Matrix;
import flash.geom.Rectangle;

/**
 * @author ssen (i@ssen.name)
 */
public class Bitmap15GridMaterial implements IDrawMaterial {
	public var bitmap : BitmapData;
	public var x012 : Array;
	public var y01234 : Array;
	public var fixedY : int;
	public var fixedYHeight : int;
	public var smooth : Boolean;

	public function Bitmap15GridMaterial(bitmap : BitmapData, x012 : Array, y01234 : Array, fixedY : int = 4, fixedYHeight : int = 10, smooth : Boolean = false) {
		this.bitmap = bitmap;
		this.x012 = x012;
		this.y01234 = y01234;
		this.fixedY = fixedY;
		this.fixedYHeight = fixedYHeight;
		this.smooth = smooth;
	}

	public function draw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		var ow : Number = bitmap.width;
		var oh : Number = bitmap.height;
		
		var cols : Array = [0, x012[0], ow - x012[2], ow];
		var dCols : Array = [0, x012[0], width - x012[2], width];
		var rows : Array = [0, y01234[0], 0, 0, oh - y01234[4], oh];
		var dRows : Array = [0, y01234[0], 0, 0, height - y01234[4], height];
		if (fixedY == 2) {
			rows[2] = y01234[0] + y01234[1];
			dRows[2] = y01234[0] + fixedYHeight;
		} else {
			rows[2] = oh - y01234[2] - y01234[3] - y01234[4];
			dRows[2] = height - y01234[2] - fixedYHeight - y01234[4];
		}
		rows[3] = rows[2] + y01234[2];
		dRows[3] = dRows[2] + y01234[2];
		
		var mat : Matrix = new Matrix;
		var origin : Rectangle;
		var draw : Rectangle;
		var cy : int;
		var cx : int;				
		cx = -1;
		while(++cx < 3) {
			cy = -1;
			while(++cy < 5) {
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
	}

	private function scaleDraw(graphics : Graphics, x : Number, y : Number, draw : Rectangle, mat : Matrix) : void {
		graphics.beginBitmapFill(bitmap, mat, false, smooth);
		graphics.drawRect(draw.x + x, draw.y + y, draw.width, draw.height);
		graphics.endFill();
	}
}
}
