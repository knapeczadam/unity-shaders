using UnityEngine;

public class MagnetLocator : MonoBehaviour
{
    public Material mat;
    public Transform go;
    
    void Update()
    {
        mat.SetVector("_MagnetDir", (transform.position - go.position).normalized);
    }
}