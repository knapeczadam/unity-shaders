using UnityEngine;

public class LightControl : MonoBehaviour
{
    public float amplitude = 1f;
    public float frequency = 1f;
    
    Color colorOffset;
    Color tempColor;

    public Light light;
    
    private void Start()
    {
        
        colorOffset = light.color;
    }

    void Update()
    {
        tempColor = colorOffset;
        tempColor.r += Mathf.Sin(Time.fixedTime * Mathf.PI * frequency) * amplitude;
        tempColor.g += Mathf.Sin(Time.fixedTime * (Mathf.PI / 2) * frequency) * amplitude;
        tempColor.b += Mathf.Sin(Time.fixedTime * (Mathf.PI / 3) * frequency) * amplitude;
        
        light.color = tempColor;
    }

    private void OnDisable()
    {
        if (light != null)
        {
            light.color = colorOffset;
        }
    }
}