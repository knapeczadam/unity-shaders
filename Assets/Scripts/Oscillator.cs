using UnityEngine;

public class Oscillator : MonoBehaviour
{
    private float _timeCounter;
    public int speed;
    
    public int width; // 2x
    public int height; // 2x

    private Vector3 posOffset;

    private void Start()
    {
        posOffset = transform.position;
    }

    void Update()
    {
        _timeCounter += Time.deltaTime * speed;
        
        float x = Mathf.Cos(_timeCounter) * width;
        float y = posOffset.y + Mathf.Max(Mathf.Sin(_timeCounter) * height, posOffset.y);
        float z = 0;

        Vector3 pos = new Vector3(x, y, z);
        
        transform.position = pos;
    }
}