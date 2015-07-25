package tweenx909.core.color;
import tweenx909.core.tools.FloatTools;
import tweenx909.TweenX;
import tweenx909.core.tools.FloatTools.*;

/**
 * ...
 * @author shohei909
 */
class RgbColor {
	public var r:Float;
	public var g:Float;
	public var b:Float;

	public function new(red:Float, green:Float, blue:Float) {
		this.r = red;
		this.g = green;
		this.b = blue;
	}

	public static function rgbToInt(r:Float, g:Float, b:Float):Int {
		r = clamp(r);
		g = clamp(g);
		b = clamp(b);

		return (Std.int(r * 0xFF) << 16) | (Std.int(g * 0xFF) << 8) | Std.int(b * 0xFF);
	}

	public static function of(color:Int) {
		return new RgbColor(
			((color >> 16) & 0xFF) / 0xFF,
			((color >> 8) & 0xFF) / 0xFF,
			(color & 0xFF) / 0xFF
		);
	}

	public static function fromHsv(h:Float, s:Float, v:Float) {
		h = (h - Math.floor(h)) * 6;
		var hi = Math.floor(h);

		s = clamp(s);
		v = clamp(v);

		var m = v * (1 - s);
		var f = h - hi;

		var r = 0.0, g = 0.0, b = 0.0;
		switch(hi) {
			case 0: r = v; g = v * (1 - s * (1 - f)); b = m;
			case 1:	r = v * (1 - s * f); g = v; b = m;
			case 2:	r = m; g = v; b = v * (1 - s * (1 - f));
			case 3:	r = m; g = v * (1 - s * f); b = v;
			case 4:	r = v * (1 - s * (1 - f)); g = m; b = v;
			case 5:	r = v; g = m; b = v * (1 - s * f);
		}

		return new RgbColor(r, g, b);
	}

	public function toInt():Int {
		return rgbToInt(r, g, b);
	}

	public function toArgb(a:Float):ArgbColor {
		return new ArgbColor(a, r, g, b);
	}

	public function toHsv():HsvColor {
		return HsvColor.fromRgb(r, g, b);
	}
}