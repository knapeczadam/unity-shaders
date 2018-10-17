using UnityEngine;
using UnityStandardAssets.SceneUtils;

public class CameraController : MonoBehaviour
{
    [Header("SHIFTING")]
    public bool enableSmoothShift;
    public int maxCamOffset;
    public int speed;
    private float _timeCounter;

    [Header("REPLACEMENT SHADER")] 
    public bool enableReplacementShader;
    public Shader replacementShader;
    public string replacementTag;
    
    [Header("POST-PROCESSING EFFECTS")]
    public bool enablePostProcessingEffects;
    public static bool s_EnablePostProcessingEffects;
    public Material mat;
    public static Material s_Mat;

    void Update()
    {
        if (enableSmoothShift)
        {
            _timeCounter += Time.deltaTime * speed;
            ModelSceneControl.s_Selected.camOffset = (int) Mathf.PingPong(_timeCounter, maxCamOffset);
        }        
    }

    private void OnEnable()
    {
        if (enableReplacementShader && replacementShader)
        {
            Camera.main.SetReplacementShader(replacementShader, replacementTag);
        }

        if (enablePostProcessingEffects)
        {
            s_Mat = mat;
            s_EnablePostProcessingEffects = true;
            RenderTextureController textureController = Camera.main.GetComponent<RenderTextureController>();
            textureController.enabled = true;
        }
    }

    private void OnDisable()
    {
        if (Camera.main)
        {
            if (enableReplacementShader)
            {
                Camera.main.ResetReplacementShader();
            }
    
            if (enablePostProcessingEffects)
            {
                RenderTextureController textureController = Camera.main.GetComponent<RenderTextureController>();
                textureController.enabled = false;
            }
        }
    }
}