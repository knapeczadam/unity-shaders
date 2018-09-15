using UnityEngine;
using UnityStandardAssets.SceneUtils;

public class CameraController : MonoBehaviour
{

    public bool smoothShift;

    public int maxCamOffset;

    public int speed;
    
    private float _timeCounter;
    
    void Update()
    {
        if (smoothShift)
        {
            _timeCounter += Time.deltaTime * speed;
            ModelSceneControl.s_Selected.camOffset = (int) Mathf.PingPong(_timeCounter, maxCamOffset);
        }        
    }
}