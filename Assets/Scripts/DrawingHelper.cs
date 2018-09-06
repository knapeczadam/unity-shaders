using UnityEngine;
using UnityEngine.Rendering;

public static class DrawingHelper {
    
    public static GameObject DrawLine(Vector3 start, Vector3 end, Color color, bool destory = false, float delay = 0)
    {
        GameObject line = new GameObject();
        line.transform.position = start;
        line.AddComponent<LineRenderer>();
        LineRenderer lr = line.GetComponent<LineRenderer>();
        lr.material = new Material(Shader.Find("Particles/Alpha Blended Premultiply"));
        lr.startColor = color;
        lr.endColor = color;
        lr.startWidth = 0.01f;
        lr.endWidth = 0.01f;
        lr.SetPosition(0, start);
        lr.SetPosition(1, end);
        lr.shadowCastingMode = ShadowCastingMode.Off;
        lr.receiveShadows = false;
        if (destory)
        {
            GameObject.Destroy(line, delay);
        }
        return line;
    }
}