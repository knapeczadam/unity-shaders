using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.Rendering;

public class BlendingDebugger : MonoBehaviour
{
    [Header("Blending settings")]
    public BlendOp Op = BlendOp.Add;
    public BlendMode SrcFactor;
    public BlendMode DstFactor;

    [Header("Source")]
    public MeshRenderer[] SrcRenderers;
    public Color Src;
    
    [Header("Destination")]
    public MeshRenderer[] DstRenderers;
    private Material _matDst;
    public Color Dst;

    [Header("Result")]
    public MeshRenderer[] ResRenderers;
    public Color blendedColor;

    void Update()
    {
        foreach (MeshRenderer srcRenderer in SrcRenderers)
        {
            Material matSrc = srcRenderer.material;
            matSrc.SetColor("_Color", Src);
            matSrc.SetInt("_Op", (int) Op);
            matSrc.SetInt("_SrcFactor", (int) SrcFactor);
            matSrc.SetInt("_DstFactor", (int) DstFactor);
        }

        foreach (MeshRenderer dstRenderer in DstRenderers)
        {
            Material matDst = dstRenderer.material;
            matDst.SetColor("_Color", Dst);
        }
        
        Color newSrc = SetColor(Src, SrcFactor);
        Color newDst = SetColor(Dst, DstFactor);

        blendedColor = Calculate(newSrc, newDst);
        foreach (MeshRenderer resultRenderer in ResRenderers)
        {
            Material matRes = resultRenderer.material;
            matRes.SetColor("_Color", blendedColor);
        }

    }

    private Color SetColor(Color oldColor, BlendMode factor)
    {
        Color newColor = oldColor;
        
        switch (factor)
        {
            case BlendMode.Zero:
                newColor *= new Color(0, 0, 0, 0);
                break;
            case BlendMode.One:
                newColor *= new Color(1, 1, 1, 1);
                break;
            case BlendMode.DstColor:
                newColor *= Dst;
                break;
            case BlendMode.SrcColor:
                newColor *= Src;
                break;
            case BlendMode.OneMinusDstColor:
                newColor *= new Color(1 - Dst.r, 1.0f - Dst.g, 1.0f - Dst.b, 1.0f - Dst.a);
                break;
            case BlendMode.SrcAlpha:
                newColor *= Src.a;
                break;
            case BlendMode.OneMinusSrcColor:
                newColor *= new Color(1 - Src.r, 1.0f - Src.g, 1.0f - Src.b, 1.0f - Src.a);
                break;
            case BlendMode.DstAlpha:
                newColor *= Dst.a;
                break;
            case BlendMode.OneMinusDstAlpha:
                newColor *= new Color(1 - Dst.a, 1.0f - Dst.a, 1.0f - Dst.a, 1.0f - Dst.a);
                break;
            case BlendMode.SrcAlphaSaturate:
                float f = Mathf.Min(Src.a, 1.0f - Dst.a);
                newColor *= new Color(f, f, f, 1);
                break;
            case BlendMode.OneMinusSrcAlpha:
                newColor *= new Color(1 - Src.a, 1.0f - Src.a, 1.0f - Src.a, 1.0f - Src.a);
                break;
        }
        return newColor;
    }

    private Color Calculate(Color srcColor, Color dstColor)
    {
        Color result = new Color();
        switch (Op)
        {
            case BlendOp.Add:
                result = Add(dstColor, srcColor);
                break;
            case BlendOp.Subtract:
                result = Subtract(dstColor, srcColor); // Is it possible that Subtract and ReverseSubtract are implemented wrongly by Unity? o_O
                break;
            case BlendOp.ReverseSubtract:
                result = ReverseSubtract(dstColor, srcColor);
                break;
            case BlendOp.Min:
                result = Min(Dst, Src); // from here and below factors are acting like Blend One One
                break;
            case BlendOp.Max:
                result = Max(Dst, Src);
                break;
            case BlendOp.Multiply:
                result = Multiply(Dst, Src);
                break;
            case BlendOp.Screen:
                result = Screen(Dst, Src);
                break;
            case BlendOp.Overlay:
                result = Overlay(Dst, Src);
                break;
            case BlendOp.Darken:
                result = Darken(Dst, Src);
                break;
            case BlendOp.Lighten:
                result = Lighten(Dst, Src);
                break;
            case BlendOp.ColorDodge:
                result = ColorDodge(Dst, Src);
                break;
            case BlendOp.ColorBurn:
                result = ColorBurn(Dst, Src);
                break;
            case BlendOp.HardLight:
                result = HardLight(Dst, Src);
                break;
            case BlendOp.SoftLight:
                result = SoftLight(Dst, Src);
                break;
            case BlendOp.Difference:
                result = Difference(Dst, Src);
                break;
            case BlendOp.Exclusion:
                result = Exclusion(Dst, Src);
                break;
            case BlendOp.HSLHue:
                result = HSLHue(Dst, Src);
                break;;
            case BlendOp.HSLSaturation:
                result = HSLSaturation(Dst, Src);
                break;
            case BlendOp.HSLColor:
                result = HSLColor(Dst, Src);
                break;
            case BlendOp.HSLLuminosity:
                result = HSLLuminosity(Dst, Src);
                break;
        }
        return result;
    }
    
    /// <summary>
    /// Default blend operation if BlendOp Op is not defined.
    /// Add source and destination color together.
    /// Note: Destination is synonymous with backdrop.
    /// </summary>
    /// <param name="b - backdrop color"></param>
    /// <param name="s - source color"></param>
    /// <returns>The result color</returns>
    private Color Add(Color b, Color s)
    {
        Color r = b + s;
        return r;
    }

    private Color Subtract(Color b, Color s)
    {
        Color r = b - s;
        return r;
    }

    private Color ReverseSubtract(Color b, Color s)
    {
        Color r = s - b;
        return r;
    }

    private Color Min(Color b, Color s)
    {
        Color r = new Color();
        r.r = _Min(b.r, s.r);
        r.g = _Min(b.g, s.g);
        r.b = _Min(b.b, s.b);
        // and what about the alphas?
        //r.a = _Min(b.a, s.a); ???
        return r;
    }

    private float _Min(float b, float s)
    {
        return Mathf.Min(b, s);
    }
    
    private Color Max(Color b, Color s)
    {
        Color r = new Color();
        r.r = _Max(b.r, s.r);
        r.g = _Max(b.g, s.g);
        r.b = _Max(b.b, s.b);
        return r;
    }

    private float _Max(float b, float s)
    {
        return Mathf.Max(b, s);
    }

    private Color Multiply(Color b, Color s) // B(Cb, Cs) = Cb x Cs
    {
        Color r = new Color();
        r.r = _Multiply(b.r, s.r);
        r.g = _Multiply(b.g, s.g);
        r.b = _Multiply(b.b, s.b);
        return r;
    }

    private float _Multiply(float b, float s)
    {
        return b * s;
    }

    private Color Screen(Color b, Color s) // B(Cb, Cs) = 1 - [(1 - Cb) x (1 - Cs)]
    {
        Color r =  new Color();
        r.r = _Screen(b.r, s.r);
        r.g = _Screen(b.g, s.g);
        r.b = _Screen(b.b, s.b);
        return r;
    }

    private float _Screen(float b, float s)
    {
        return 1.0f - (1.0f - b) * (1.0f - s);;
    }

    private Color Overlay(Color b, Color s) // B(Cb, Cs) = HardLight(Cs, Cb)
    {
        return HardLight(s, b);
    }

    private Color Darken(Color b, Color s) // B(Cb, Cs) = min(Cb, Cs)
    {
        return Min(b, s);
    }

    private Color Lighten(Color b, Color s) // B(Cb, Cs) = max(Cb, Cs)
    {
        return Max(b, s);
    }

    private Color ColorDodge(Color b, Color s)
    {
        Color r =  new Color();
        r.r = _ColorDodge(b.r, s.r);
        r.g = _ColorDodge(b.g, s.g);
        r.b = _ColorDodge(b.b, s.b);
        return r;
    }
    
    private float _ColorDodge(float b, float s)
    {
        float v = 0f;
        if (b == 0f)
        {
            v = 0f;
        }
        else if (s == 1f)
        {
            v = 1f;
        }
        else
        {
            v = Mathf.Min(1f, b / (1f - s));
        }
        return v;
    }

    private Color ColorBurn(Color b, Color s)
    {
        Color r = new Color();
        r.r = _ColorBurn(b.r, s.r);
        r.g = _ColorBurn(b.g, s.g);
        r.b = _ColorBurn(b.b, s.b);
        return r;
    }
    
    private float _ColorBurn(float b, float s)
    {
        float v = 0f;
        if (b == 1f)
        {
            v = 0f;
        }
        else if (s == 0f)
        {
            v = 0f;
        }
        else
        {
            v = 1f - Mathf.Min(1f, (1f - b) / s);
        }
        return v;
    }

    private Color HardLight(Color b, Color s)
    {
        Color r = new Color();
        r.r = _HardLight(b.r, s.r);
        r.g = _HardLight(b.g, s.g);
        r.b = _HardLight(b.b, s.b);
        return r; 
    }

    private float _HardLight(float b, float s)
    {
        if (s <= 0.5f)
        {
            return _Multiply(b, 2 * s);
        }
        return _Screen(b, 2 * s - 1);
    }

    private Color SoftLight(Color b, Color s)
    {
        Color r = new Color();
        r.r = _SoftLight(b.r, s.r);
        r.g = _SoftLight(b.g, s.g);
        r.b = _SoftLight(b.b, s.b);
        return r;
    }

    private float _SoftLight(float b, float s)
    {
        float v = 0f;
        if (s <= 0.5f)
        {
            v = b - (1f - 2f * s) * b * (1f - b);
        }
        else
        {
            float d = b <= 0.25f ? ((16f * b - 12f) * b + 4) * b : Mathf.Sqrt(b);
            v = b + (2f * s - 1f) * (d - b);
        }
        return v;
    }
    
    private Color Difference(Color b, Color s) // B(Cb, Cs) = | Cb - Cs |

    {
        Color r = new Color();
        r.r = _Difference(b.r, s.r);
        r.g = _Difference(b.g, s.g);
        r.b = _Difference(b.b, s.b);
        return r;
    }

    private float _Difference(float b, float s)
    {
        return Mathf.Abs(b - s);
    }

    private Color Exclusion(Color b, Color s) // B(Cb, Cs) = Cb + Cs - 2 x Cb x Cs
    {
        Color r = new Color();
        r.r = _Exclusion(b.r, s.r);
        r.g = _Exclusion(b.g, s.g);
        r.b = _Exclusion(b.b, s.b);
        return r;
    }

    private float _Exclusion(float b, float s)
    {
        return b + s - 2.0f * b * s;
    }

    private Color HSLHue(Color b, Color s) // B(Cb, Cs) = SetLum(SetSat(Cs, Sat(Cb)), Lum(Cb))
    {
        return SetLum(SetSat(s, Sat(b)), Lum(b));
    }

    private Color HSLSaturation(Color b, Color s) // B(Cb, Cs) = SetLum(SetSat(Cb, Sat(Cs)), Lum(Cb))
    {
        return SetLum(SetSat(b, Sat(s)), Lum(b));
    }

    private Color HSLColor(Color b, Color s) // B(Cb, Cs) = SetLum(Cs, Lum(Cb))
    {
        return SetLum(s, Lum(b));
    }

    private Color HSLLuminosity(Color b, Color s) // B(Cb, Cs) = SetLum(Cb, Lum(Cs))
    {
        return SetLum(b, Lum(s));
    }

    // Calculate luminance / visually perceived brightness
    private float Lum(Color c)
    {
        return 0.299f * c.r + 0.587f * c.g + 0.114f * c.b;
    }
    
    private Color SetLum(Color c, float l)
    {
        float d = l - Lum(c);
        c.r += d;
        c.g += d;
        c.b += d;
        return ClipColor(c);
    }
    
    private Color ClipColor(Color c)
    {
        float l = Lum(c);
        float n = Mathf.Min(c.r, c.g, c.b);
        float x = Mathf.Max(c.r, c.g, c.b);

        if (n < 0.0)
        {
            c.r = l + (((c.r - l) * l) / (l - n));
            c.g = l + (((c.g - l) * l) / (l - n));
            c.b = l + (((c.b - l) * l) / (l - n));
        }

        if (x > 1.0)
        {
            c.r = l + (((c.r - l) * (1 - l)) / (x - l));
            c.g = l + (((c.g - l) * (1 - l)) / (x - l));
            c.b = l + (((c.b - l) * (1 - l)) / (x - l));
        }
        return c;
    }

    private float Sat(Color c)
    {
        return Mathf.Max(c.r, c.g, c.b) - Mathf.Min(c.r, c.g, c.b);;
    }

    private Color SetSat(Color c, float s)
    {
        Dictionary<ColorChannel, float> dict = new Dictionary<ColorChannel, float>();
        dict.Add(ColorChannel.R, c.r);
        dict.Add(ColorChannel.G, c.g);
        dict.Add(ColorChannel.B, c.b);
        List<KeyValuePair<ColorChannel, float>> l = dict.ToList();
        l.Sort((pair1,pair2) => pair1.Value.CompareTo(pair2.Value));

        if (l[2].Value > l[0].Value)
        {
            dict[l[1].Key]  = (((l[1].Value - l[0].Value) * s) / (l[2].Value - l[0].Value));
            dict[l[2].Key] = s;
        }
        else
        {
            dict[l[1].Key] = dict[l[2].Key] = 0f;
        }

        dict[l[0].Key] = 0f;

        c.r = dict[ColorChannel.R];
        c.g = dict[ColorChannel.G];
        c.b = dict[ColorChannel.B];
        
        return c;
    }

    public enum ColorChannel
    {
        R,
        G,
        B
    }
}