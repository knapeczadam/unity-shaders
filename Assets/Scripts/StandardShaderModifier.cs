using UnityEngine;

public class StandardShaderModifier : MonoBehaviour
{
    public GameObject go;
    
    public Material mat;
    private Material _mat;
    
    public Keyword keyword;
    public Texture tex; // suppose that tex always has a reference that's why we don't use null check
    public Color col;
    
    private string enableButton;
    private const string enableLabel = "Enable selected keyword";

    void Start()
    {
        if (!mat || !go)
        {
            enabled = false;
        }

        enableButton = enableLabel;
    }

    public string GetEnableButtonLabel()
    {
        return enableButton;
    }

    public void EnableKeyword()
    {
        _mat = null;
        _mat = new Material(mat);
        _mat.EnableKeyword(keyword.ToString("F"));

        go.GetComponent<Renderer>().material = _mat;
        
        switch (keyword)
        {
            case Keyword._NORMALMAP:
                _mat.SetTexture("_BumpMap", tex);
                //_mat.SetTexture("_DetailNormalMap", tex);
                break;
            case Keyword._ALPHATEST_ON:
                _mat.SetOverrideTag("RenderType", "TransparentCutout");
                _mat.SetInt("_SrcBlend", (int) UnityEngine.Rendering.BlendMode.One);
                _mat.SetInt("_DstBlend", (int) UnityEngine.Rendering.BlendMode.Zero);
                _mat.SetInt("_ZWrite", 1);
                _mat.DisableKeyword("_ALPHABLEND_ON");
                _mat.DisableKeyword("_ALPHAPREMULTIPLY_ON");
                _mat.renderQueue = (int) UnityEngine.Rendering.RenderQueue.AlphaTest;
                break;
            case Keyword._ALPHABLEND_ON:
                _mat.SetOverrideTag("RenderType", "Transparent");
                _mat.SetInt("_SrcBlend", (int) UnityEngine.Rendering.BlendMode.SrcAlpha);
                _mat.SetInt("_DstBlend", (int) UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
                _mat.SetInt("_ZWrite", 0);
                _mat.DisableKeyword("_ALPHATEST_ON");
                _mat.DisableKeyword("_ALPHAPREMULTIPLY_ON");
                _mat.renderQueue = (int) UnityEngine.Rendering.RenderQueue.Transparent;
                break;
            case Keyword._ALPHAPREMULTIPLY_ON:
                _mat.SetOverrideTag("RenderType", "Transparent");
                _mat.SetInt("_SrcBlend", (int) UnityEngine.Rendering.BlendMode.One);
                _mat.SetInt("_DstBlend", (int) UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
                _mat.SetInt("_ZWrite", 0);
                _mat.DisableKeyword("_ALPHATEST_ON");
                _mat.DisableKeyword("_ALPHABLEND_ON");
                _mat.renderQueue = (int) UnityEngine.Rendering.RenderQueue.Transparent;
                break;
            case Keyword._EMISSION:
                _mat.SetColor("_EmissionColor", col);
                _mat.SetTexture("_EmissionMap", tex);
                break;
            case Keyword._PARALLAXMAP:
                _mat.SetTexture("_ParallaxMap", tex);
                break;
            case Keyword._DETAIL_MULX2: // _DetailMask?
                _mat.SetTexture("_DetailAlbedoMap", tex);
                //mat.SetTexture("_DetailNormalMap", tex);
                break;
            case Keyword._METALLICGLOSSMAP:
                _mat.SetTexture("_MetallicGlossMap", tex);
                break;
            case Keyword._SPECGLOSSMAP:
                _mat.SetTexture("_SpecGlossMap", tex);
                break;
        }
    }

    public enum Keyword
    {
        _NORMALMAP,
        _ALPHATEST_ON,
        _ALPHABLEND_ON,
        _ALPHAPREMULTIPLY_ON,
        _EMISSION,
        _PARALLAXMAP,
        _DETAIL_MULX2,
        _METALLICGLOSSMAP,
        _SPECGLOSSMAP
    }
}