using UnityEngine;

public class Rotate : MonoBehaviour
{
    public int speed;

    void Update()
    {
        transform.Rotate(Vector3.down * Time.deltaTime * speed);
    }
}