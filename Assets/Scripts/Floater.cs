using UnityEngine;
using UnityEngine.Animations;

public class Floater : MonoBehaviour
{
    public Axis axis = Axis.Y;
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

        switch (axis)
        {
            case Axis.X:
                tempPos.x += Mathf.Sin (Time.fixedTime * Mathf.PI * frequency) * amplitude;
                break;
            case Axis.Y:
                tempPos.y += Mathf.Sin (Time.fixedTime * Mathf.PI * frequency) * amplitude;
                break;
            case Axis.Z:
                tempPos.z += Mathf.Sin (Time.fixedTime * Mathf.PI * frequency) * amplitude;
                break;
        }
        
        transform.localPosition = tempPos;
    }
}