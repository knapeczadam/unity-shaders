using UnityEngine;

public class MagnetLocator : MonoBehaviour
{
    public Material mat;
    public Transform go;
    
    void Update()
    {
        if (go)
        {
            mat.SetVector("_MagnetDir", (transform.position - go.position).normalized);
        }
        else
        {
            mat.SetVector("_MagnetPos", transform.position);   
        }
    }
}