using UnityEngine;

public class Floater : MonoBehaviour
{
    public float amplitude = 0.5f;
    public float frequency = 1f;
    
    Vector3 posOffset;
    Vector3 tempPos;
    
    private void Start()
    {
        posOffset = transform.localPosition;
    }

    void Update()
    {
        tempPos = posOffset;
        tempPos.y += Mathf.Sin (Time.fixedTime * Mathf.PI * frequency) * amplitude;
        
        transform.localPosition = tempPos;
    }
}