using UnityEngine;

public class CalcRefVect : MonoBehaviour
{
    void Update()
    {
        RaycastHit hit;
//        Debug.DrawRay(transform.position, transform.forward * 5, Color.red);
        DrawingHelper.DrawLine(transform.position, transform.position + transform.forward * 5, Color.red, 0.01f, true, 0.1f);
        if (Physics.Raycast(transform.position, transform.forward, out hit))
        {
            Vector3 surfaceNormalAtHit = hit.normal;
            Vector3 fromCamera = hit.point - transform.position;
            Vector3 worldReflection = fromCamera - 2 *
                                      Vector3.Dot(fromCamera, surfaceNormalAtHit) * surfaceNormalAtHit;
//            Debug.DrawRay(hit.point, worldReflection, Color.green);
            DrawingHelper.DrawLine(hit.point, hit.point +worldReflection, Color.green, 0.01f, true, 0.1f);
//            Debug.DrawRay(hit.point, hit.normal, Color.blue);
            DrawingHelper.DrawLine(hit.point, hit.point + hit.normal, Color.blue, 0.01f, true, 0.1f);
            
            transform.GetComponent<Renderer>().material.color = new Color(worldReflection.x,worldReflection.y,worldReflection.z,.5f);
        }
    }
}