using UnityEngine;

public class Metronome : MonoBehaviour
{
    public float speed = 1f;
    private float _timeCount = 0.0f;
    
    private void Update()
    {
        _timeCount += Time.deltaTime * speed;
        float t = Mathf.PingPong(_timeCount, 1.0f);
        transform.localRotation = Quaternion.LookRotation(Vector3.Slerp(Vector3.left, Vector3.right, t));
    }
}