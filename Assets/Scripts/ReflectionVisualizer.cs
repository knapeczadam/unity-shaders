using UnityEngine;

public class ReflectionVisualizer : MonoBehaviour
{
    void Update()
    {
        RaycastHit hit;
        DrawingHelper.DrawLine(transform.position, transform.position + transform.forward * 5, Color.red, 0.01f, true, 0.1f);
        if (Physics.Raycast(transform.position, transform.forward, out hit))
        {
            Vector3 surfaceNormalAtHit = hit.normal;
            Vector3 fromCamera = hit.point - transform.position;
            Vector3 worldReflection = Reflect(fromCamera, surfaceNormalAtHit);
            DrawingHelper.DrawLine(hit.point, hit.point +worldReflection, Color.green, 0.01f, true, 0.1f);
            DrawingHelper.DrawLine(hit.point, hit.point + hit.normal, Color.blue, 0.01f, true, 0.1f);
            
            transform.GetComponent<Renderer>().material.color = new Color(worldReflection.x,worldReflection.y,worldReflection.z);
        }
    }
    
    Vector3 Reflect(Vector3 inDirection, Vector3 inNormal)
    {
        return -2f * Vector3.Dot(inNormal, inDirection) * inNormal + inDirection;
    }
}