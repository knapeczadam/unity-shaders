using UnityEngine;
using UnityStandardAssets.SceneUtils;

public class CameraController : MonoBehaviour
{

    public bool smoothShift;

    public int maxCamOffset;

    public int speed;
    
    private float _timeCounter;
    
    public Shader replacementShader;
    public string replacementTag;

    void Update()
    {
        if (smoothShift)
        {
            _timeCounter += Time.deltaTime * speed;
            ModelSceneControl.s_Selected.camOffset = (int) Mathf.PingPong(_timeCounter, maxCamOffset);
        }        
    }

    private void OnEnable()
    {
        if (replacementShader)
        {
            Camera.main.SetReplacementShader(replacementShader, replacementTag);
            
        }
    }

    private void OnDisable()
    {
        if (replacementShader && Camera.main)
        {
            Camera.main.ResetReplacementShader();
        }
    }
}