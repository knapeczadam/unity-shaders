using UnityEngine;

public class CalcRefVect : MonoBehaviour
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
        
        RaycastHit hit;
//        Debug.DrawRay(transform.position, transform.forward * 5, Color.red);
        DrawingHelper.DrawLine(transform.position, transform.position + transform.forward * 5, Color.red, true, 0.1f);
        if (Physics.Raycast(transform.position, transform.forward, out hit))
        {
            Vector3 surfaceNormalAtHit = hit.normal;
            Vector3 fromCamera = hit.point - transform.position;
            Vector3 worldReflection = fromCamera - 2 *
                                      Vector3.Dot(fromCamera, surfaceNormalAtHit) * surfaceNormalAtHit;
//            Debug.DrawRay(hit.point, worldReflection, Color.green);
            DrawingHelper.DrawLine(hit.point, hit.point +worldReflection, Color.green, true, 0.1f);
//            Debug.DrawRay(hit.point, hit.normal, Color.blue);
            DrawingHelper.DrawLine(hit.point, hit.point + hit.normal, Color.blue, true, 0.1f);
            
            transform.GetComponent<Renderer>().material.color = new Color(worldReflection.x,worldReflection.y,worldReflection.z,.5f);
        }
    }
}