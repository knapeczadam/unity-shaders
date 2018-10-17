using UnityEngine;

public class RefractionVisualizer : MonoBehaviour
{    
    [Header("MEDIUM 1")]
    [Range(0.18f, 4.24f)]
    public float fromIOR = 1f;
    
    [Header("MEDIUM 2")]
    [Range(0.18f, 4.24f)]
    public float toIOR = 1f;
    
    void Update()
    {
        RaycastHit hit;
        DrawingHelper.DrawLine(transform.position, transform.position + transform.forward * 5, Color.red, 0.01f, true, 0.02f);
        if (Physics.Raycast(transform.position, transform.forward, out hit))
        {
            Vector3 surfaceNormalAtHit = hit.normal;
            Vector3 fromCamera = (hit.point - transform.position).normalized;
            float eta = fromIOR / toIOR;
            Vector3 worldRefraction = Refract(fromCamera, surfaceNormalAtHit, eta);
            DrawingHelper.DrawLine(hit.point, hit.point + worldRefraction, Color.green, 0.01f, true, 0.02f);
            DrawingHelper.DrawLine(hit.point, hit.point + hit.normal, Color.blue, 0.01f, true, 0.02f);

            transform.GetComponent<Renderer>().material.color = new Color(worldRefraction.x, worldRefraction.y, worldRefraction.z);
        }    
    }

    Vector3 Refract(Vector3 inDirection, Vector3 inNormal)
    {
        float cosi  = Vector3.Dot(-inDirection, inNormal);
        float cost2 = 1.0f * (1.0f - cosi   * cosi);
        Vector3 t = inDirection + ((cosi - Mathf.Sqrt(Mathf.Abs(cost2))) * inNormal);
        return cost2 > 0 ? t : Vector3.zero;
    }
    
    Vector3 Refract(Vector3 inDirection, Vector3 inNormal, float eta)
    {
        float cosi  = Vector3.Dot(-inDirection, inNormal);
        float cost2 = 1.0f - eta * eta * (1.0f - cosi * cosi);
        Vector3 t = eta * inDirection + ((eta * cosi - Mathf.Sqrt(Mathf.Abs(cost2))) * inNormal);
        return cost2 > 0 ? t : Vector3.zero;
    }
}