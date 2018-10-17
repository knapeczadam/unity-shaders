using UnityEngine;

public class RenderTextureController : MonoBehaviour
{
    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (CameraController.s_EnablePostProcessingEffects && CameraController.s_Mat)
        {
            Graphics.Blit(src, dest, CameraController.s_Mat);
        }
    }
}