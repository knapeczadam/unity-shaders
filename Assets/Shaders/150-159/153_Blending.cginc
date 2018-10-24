#ifndef BLENDING
#define BLENDING

// bo - blend operation
// b  - backdrop/destination
// s  - source
// r  - result
// _  - private function

fixed3 bo_add(fixed3 b, fixed3 s)
{
    fixed3 r = b + s;
    return r;
}

fixed3 bo_subtract(fixed3 b, fixed3 s)
{
    fixed3 r = b - s;
    return r;
}

fixed3 bo_reverseSubtract(fixed3 b, fixed3 s)
{
    fixed3 r = s - b;
    return r;
}

fixed3 bo_min(fixed3 b, fixed3 s)
{
    fixed3 r = min(b, s);
    return r;
}

fixed3 bo_max(fixed3 b, fixed3 s)
{
    fixed3 r = max(b, s);
    return r;
}

fixed _multiply(fixed b, fixed s)
{
    return b * s;
}

fixed3 bo_multiply(fixed3 b, fixed3 s)
{
    fixed3 r = b * s;
    return r;
}

fixed _screen(fixed b, fixed s)
{
    return 1.0 - (1.0 - b) * (1.0 - s);
}

fixed3 bo_screen(fixed3 b, fixed3 s)
{
    fixed3 r = 1.0 - (1.0 - b) * (1.0 - s);
    return r;
}

fixed _hardLight(fixed b, fixed s)
{
    if (s <= 0.5)
    {
        return _multiply(b, 2 * s);
    }
    return _screen(b, 2 * s - 1);
}

fixed3 bo_hardLight(fixed3 b, fixed3 s)
{
    fixed3 r;
    r.r = _hardLight(b.r, s.r);
    r.g = _hardLight(b.g, s.g);
    r.b = _hardLight(b.b, s.b);
    return r;
}

fixed3 bo_overlay(fixed3 b, fixed3 s)
{
    return bo_hardLight(s, b);
}

fixed3 bo_darken(fixed3 b, fixed3 s)
{
    return bo_min(b, s);
}

fixed3 bo_lighten(fixed3 b, fixed3 s)
{
    return bo_max(b, s);
}

fixed _colorDodge(fixed b, fixed s)
{
    fixed v;
    if (b == 0)
    {
        v = 0;
    }
    else if (s == 1)
    {
        v = 1;
    }
    else
    {
        v = min(1, b / (1 - s));
    }
    return v;
}

fixed3 bo_colorDodge(fixed3 b, fixed3 s)
{
    fixed3 r;
    r.r = _colorDodge(b.r, s.r);
    r.g = _colorDodge(b.g, s.g);
    r.b = _colorDodge(b.b, s.b);
    return r;
}

fixed _colorBurn(fixed b, fixed s)
{
    fixed v = 0;
    if (b == 1)
    {
        v = 0;
    }
    else if (s == 0)
    {
        v = 0;
    }
    else
    {
        v = 1 - min(1, (1 - b) / s);
    }
    return v;
}

fixed3 bo_colorBurn(fixed3 b, fixed3 s)
{
    fixed3 r;
    r.r = _colorBurn(b.r, s.r);
    r.g = _colorBurn(b.g, s.g);
    r.b = _colorBurn(b.b, s.b);
    return r;
}

fixed _softLight(fixed b, fixed s)
{
    fixed v;
    if (s <= 0.5)
    {
        v = b - (1 - 2 * s) * b * (1 - b);
    }
    else
    {
        float d = b <= 0.25 ? ((16 * b - 12) * b + 4) * b : sqrt(b);
        v = b + (2 * s - 1) * (d - b);
    }
    return v;
}

fixed3 bo_softLight(fixed3 b, fixed3 s)
{
    fixed3 r;
    r.r = _softLight(b.r, s.r);
    r.g = _softLight(b.g, s.g);
    r.b = _softLight(b.b, s.b);
    return r;
}

fixed3 bo_difference(fixed3 b, fixed3 s)
{
    fixed3 r = abs(b - s);
    return r;
}

fixed3 bo_exclusion(fixed3 b, fixed3 s)
{
    fixed3 r = b + s - 2.0 * b * s;
    return r;
}
    
#endif