using UnityEngine;

public class TextureArrayTester : MonoBehaviour
{
    void OnEnable()
    {
        if (!SystemInfo.supports2DArrayTextures)
        {
            Debug.Log("Texture arrays are not supported!");
            gameObject.SetActive(false);
        }
    }
}