/*
*  Copyright (c) 2014-2026 Object Builder
*
*  Permission is hereby granted, free of charge, to any person obtaining a copy
*  of this software and associated documentation files (the "Software"), to deal
*  in the Software without restriction, including without limitation the rights
*  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
*  copies of the Software, and to permit persons to whom the Software is
*  furnished to do so, subject to the following conditions:
*
*  The above copyright notice and this permission notice shall be included in
*  all copies or substantial portions of the Software.
*
*  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
*  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
*  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
*  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
*  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
*  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
*  THE SOFTWARE.
*/

package otlib.utils
{
    import flash.display.BitmapData;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;

    import nail.errors.AbstractClassError;
    import otlib.animation.FrameGroup;
    import otlib.sprites.SpriteData;
    import otlib.things.FrameGroupType;
    import otlib.things.ThingData;
    import otlib.things.ThingType;

    public final class RecolorUtils
    {
        // --------------------------------------------------------------------------
        // CONSTRUCTOR
        // --------------------------------------------------------------------------

        public function RecolorUtils()
        {
            throw new AbstractClassError(RecolorUtils);
        }

        // --------------------------------------------------------------------------
        // STATIC
        // --------------------------------------------------------------------------

        /**
         * Converts RGB (0..255) to HSL [hue (0..360), sat (0..1), light (0..1)]
         */
        public static function rgbToHsl(r:uint, g:uint, b:uint):Array
        {
            var rf:Number = r / 255.0;
            var gf:Number = g / 255.0;
            var bf:Number = b / 255.0;

            var max:Number = Math.max(rf, Math.max(gf, bf));
            var min:Number = Math.min(rf, Math.min(gf, bf));
            var delta:Number = max - min;

            var l:Number = (max + min) / 2.0;
            var h:Number = 0;
            var s:Number = 0;

            if (delta > 0.00001)
            {
                s = (l < 0.5) ? (delta / (max + min)) : (delta / (2.0 - max - min));

                if (max == rf)
                    h = (gf - bf) / delta + (gf < bf ? 6.0 : 0.0);
                else if (max == gf)
                    h = (bf - rf) / delta + 2.0;
                else
                    h = (rf - gf) / delta + 4.0;

                h *= 60.0;
            }

            return [h, s, l];
        }

        /**
         * Converts HSL [h (0..360), s (0..1), l (0..1)] to RGB Array [r, g, b] (0..255)
         */
        public static function hslToRgb(h:Number, s:Number, l:Number):Array
        {
            var r:Number, g:Number, b:Number;

            if (s < 0.00001)
            {
                r = g = b = l; // achromatic (gray)
            }
            else
            {
                var q:Number = (l < 0.5) ? (l * (1.0 + s)) : (l + s - l * s);
                var p:Number = 2.0 * l - q;
                var hk:Number = (h % 360.0) / 360.0;
                if (hk < 0) hk += 1.0;

                r = hueToRgb(p, q, hk + 1.0 / 3.0);
                g = hueToRgb(p, q, hk);
                b = hueToRgb(p, q, hk - 1.0 / 3.0);
            }

            return [
                Math.round(Math.max(0, Math.min(255, r * 255.0))),
                Math.round(Math.max(0, Math.min(255, g * 255.0))),
                Math.round(Math.max(0, Math.min(255, b * 255.0)))
            ];
        }

        private static function hueToRgb(p:Number, q:Number, t:Number):Number
        {
            if (t < 0) t += 1.0;
            if (t > 1) t -= 1.0;
            if (t < 1.0 / 6.0) return p + (q - p) * 6.0 * t;
            if (t < 1.0 / 2.0) return q;
            if (t < 2.0 / 3.0) return p + (q - p) * (2.0 / 3.0 - t) * 6.0;
            return p;
        }

        /**
         * Adjusts a single 32-bit ARGB pixel using Hue, Saturation, Lightness.
         * @param color 32-bit ARGB color
         * @param hueShift -180 to +180 (or absolute hue 0..360 if colorize=true)
         * @param satShift -100 to +100 (or absolute sat 0..100 if colorize=true)
         * @param lightShift -100 to +100
         * @param colorize if true, sets uniform hue and saturation
         */
        public static function adjustPixelHsl(color:uint, hueShift:Number, satShift:Number, lightShift:Number, colorize:Boolean = false):uint
        {
            var a:uint = (color >> 24) & 0xFF;
            if (a == 0) return color; // transparent

            var r:uint = (color >> 16) & 0xFF;
            var g:uint = (color >> 8) & 0xFF;
            var b:uint = color & 0xFF;

            // Transparent magenta check
            if (r == 0xFF && g == 0x00 && b == 0xFF) return color;

            var hsl:Array = rgbToHsl(r, g, b);
            var h:Number = hsl[0];
            var s:Number = hsl[1];
            var l:Number = hsl[2];

            if (colorize)
            {
                h = ((hueShift % 360.0) + 360.0) % 360.0;
                s = Math.max(0.0, Math.min(1.0, satShift / 100.0));
            }
            else
            {
                h = ((h + hueShift) % 360.0 + 360.0) % 360.0;
                if (satShift >= 0)
                {
                    s = Math.max(0.0, Math.min(1.0, s + (1.0 - s) * (satShift / 100.0)));
                }
                else
                {
                    s = Math.max(0.0, Math.min(1.0, s * (1.0 + satShift / 100.0)));
                }
            }

            if (lightShift > 0)
            {
                l = Math.max(0.0, Math.min(1.0, l + (1.0 - l) * (lightShift / 100.0)));
            }
            else if (lightShift < 0)
            {
                l = Math.max(0.0, Math.min(1.0, l * (1.0 + lightShift / 100.0)));
            }

            var rgb:Array = hslToRgb(h, s, l);
            return (a << 24) | (rgb[0] << 16) | (rgb[1] << 8) | rgb[2];
        }

        /**
         * Replaces a specific source color with a target color within a tolerance threshold.
         * @param color 32-bit ARGB pixel to evaluate
         * @param srcColor RGB (0xRRGGBB) source color to match
         * @param tgtColor RGB (0xRRGGBB) replacement color
         * @param tolerance 0 to 100 (percentage)
         * @param preserveShading if true, keeps the pixel's relative shading/brightness
         */
        public static function replacePixelColor(color:uint, srcColor:uint, tgtColor:uint, tolerance:Number, preserveShading:Boolean):uint
        {
            var a:uint = (color >> 24) & 0xFF;
            if (a == 0) return color;

            var r:uint = (color >> 16) & 0xFF;
            var g:uint = (color >> 8) & 0xFF;
            var b:uint = color & 0xFF;

            if (r == 0xFF && g == 0x00 && b == 0xFF) return color;

            var sr:uint = (srcColor >> 16) & 0xFF;
            var sg:uint = (srcColor >> 8) & 0xFF;
            var sb:uint = srcColor & 0xFF;

            var tr:uint = (tgtColor >> 16) & 0xFF;
            var tg:uint = (tgtColor >> 8) & 0xFF;
            var tb:uint = tgtColor & 0xFF;

            var dr:Number = r - sr;
            var dg:Number = g - sg;
            var db:Number = b - sb;
            var dist:Number = Math.sqrt(dr * dr + dg * dg + db * db) / 4.41673;

            if (dist <= tolerance)
            {
                if (!preserveShading)
                {
                    return (a << 24) | (tr << 16) | (tg << 8) | tb;
                }

                var lPix:Number = (0.299 * r + 0.587 * g + 0.114 * b);
                var lSrc:Number = (0.299 * sr + 0.587 * sg + 0.114 * sb);
                var ratio:Number = (lSrc > 1.0) ? (lPix / lSrc) : (lPix / 255.0);

                var nr:uint = Math.round(Math.max(0, Math.min(255, tr * ratio)));
                var ng:uint = Math.round(Math.max(0, Math.min(255, tg * ratio)));
                var nb:uint = Math.round(Math.max(0, Math.min(255, tb * ratio)));

                return (a << 24) | (nr << 16) | (ng << 8) | nb;
            }

            return color;
        }

        /**
         * Recolors a BitmapData in place or returns a recolored clone.
         */
        public static function recolorBitmap(
            bmp:BitmapData,
            useHsl:Boolean,
            hue:Number,
            sat:Number,
            light:Number,
            colorize:Boolean,
            useReplace:Boolean,
            srcColor:uint,
            tgtColor:uint,
            tolerance:Number,
            preserveShading:Boolean):BitmapData
        {
            if (!bmp) return null;
            var result:BitmapData = bmp.clone();
            var w:int = result.width;
            var h:int = result.height;

            for (var y:int = 0; y < h; y++)
            {
                for (var x:int = 0; x < w; x++)
                {
                    var p:uint = result.getPixel32(x, y);
                    if (((p >> 24) & 0xFF) == 0) continue;

                    if (useReplace)
                        p = replacePixelColor(p, srcColor, tgtColor, tolerance, preserveShading);

                    if (useHsl)
                        p = adjustPixelHsl(p, hue, sat, light, colorize);

                    result.setPixel32(x, y, p);
                }
            }
            return result;
        }

        /**
         * Recolors a SpriteData creating a new SpriteData instance with recolored pixels.
         */
        public static function recolorSpriteData(
            sd:SpriteData,
            useHsl:Boolean,
            hue:Number,
            sat:Number,
            light:Number,
            colorize:Boolean,
            useReplace:Boolean,
            srcColor:uint,
            tgtColor:uint,
            tolerance:Number,
            preserveShading:Boolean):SpriteData
        {
            if (!sd || !sd.pixels) return null;

            var origPixels:ByteArray = sd.pixels;
            origPixels.position = 0;

            var newPixels:ByteArray = new ByteArray();
            newPixels.length = origPixels.length;

            var len:uint = origPixels.length;
            for (var i:uint = 0; i < len; i += 4)
            {
                var a:uint = origPixels[i];
                var r:uint = origPixels[i + 1];
                var g:uint = origPixels[i + 2];
                var b:uint = origPixels[i + 3];

                if (a == 0 || (r == 0xFF && g == 0x00 && b == 0xFF))
                {
                    newPixels[i] = a;
                    newPixels[i + 1] = r;
                    newPixels[i + 2] = g;
                    newPixels[i + 3] = b;
                    continue;
                }

                var p:uint = (a << 24) | (r << 16) | (g << 8) | b;

                if (useReplace)
                    p = replacePixelColor(p, srcColor, tgtColor, tolerance, preserveShading);

                if (useHsl)
                    p = adjustPixelHsl(p, hue, sat, light, colorize);

                newPixels[i] = (p >> 24) & 0xFF;
                newPixels[i + 1] = (p >> 16) & 0xFF;
                newPixels[i + 2] = (p >> 8) & 0xFF;
                newPixels[i + 3] = p & 0xFF;
            }

            return SpriteData.createSpriteData(uint.MAX_VALUE, newPixels);
        }

        /**
         * Recolors all sprites in a ThingData, returning an updated cloned ThingData.
         */
        public static function recolorThingData(
            source:ThingData,
            useHsl:Boolean,
            hue:Number,
            sat:Number,
            light:Number,
            colorize:Boolean,
            useReplace:Boolean,
            srcColor:uint,
            tgtColor:uint,
            tolerance:Number,
            preserveShading:Boolean):ThingData
        {
            if (!source) return null;

            var td:ThingData = source.clone();
            td.thing = source.thing.clone();

            for (var groupType:uint = FrameGroupType.DEFAULT; groupType <= FrameGroupType.WALKING; groupType++)
            {
                var fg:FrameGroup = td.thing.getFrameGroup(groupType);
                if (!fg) continue;

                var sprites:Vector.<SpriteData> = td.sprites[groupType];
                if (!sprites) continue;

                var len:uint = sprites.length;
                var newSprites:Vector.<SpriteData> = new Vector.<SpriteData>(len, true);

                for (var i:uint = 0; i < len; i++)
                {
                    var sd:SpriteData = sprites[i];
                    if (sd && !sd.isEmpty())
                    {
                        var recoloredSd:SpriteData = recolorSpriteData(
                            sd, useHsl, hue, sat, light, colorize, useReplace, srcColor, tgtColor, tolerance, preserveShading);
                        newSprites[i] = recoloredSd;
                        fg.spriteIndex[i] = uint.MAX_VALUE;
                    }
                    else
                    {
                        newSprites[i] = sd ? sd.clone() : null;
                    }
                }

                td.sprites[groupType] = newSprites;
            }

            return td;
        }
    }
}
