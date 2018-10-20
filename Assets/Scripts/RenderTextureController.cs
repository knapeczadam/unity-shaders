using UnityEngine;

public class RenderTextureController : MonoBehaviour
{
    private void OnEnable()
    {
        if (!SystemInfo.supportsImageEffects)
        {
            enabled = false;
        }

        if (!CameraController.s_EnablePostProcessingEffects)
        {
            enabled = false;
        }

        if (!CameraController.s_Mat || !CameraController.s_Mat.shader.isSupported)
        {
            enabled = false;
        }
    }

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        Graphics.Blit(src, dest, CameraController.s_Mat);
    }
}