using System.Collections;
using UnityEngine;

public class Glitcher : MonoBehaviour
{
    public float glitchChance = .1f;

    public bool random;

    [Range(0.0f, 1.0f)] public float Transparency;
    [Range(0.0f, 1.0f)] public float CutoutThresh;
    [Range(1.0f, 10.0f)] public float Speed;
    [Range(1.0f, 100.0f)] public float Amplitude;
    [Range(1.0f, 10.0f)] public float Distance;
    [Range(0, 1)] public int Amount; 
    
    private Renderer _holoRenderer;
    private readonly WaitForSeconds _glitchLoopWait = new WaitForSeconds(0.1f);
    private WaitForSeconds _glitchDuration = new WaitForSeconds(0.1f);

    void Awake()
    {
        _holoRenderer = GetComponent<Renderer>();
    }

    private void OnEnable()
    {
        StartCoroutine(StartGlitch());
    }

    private void OnDisable()
    {
        StopCoroutine(StartGlitch());
    }

    IEnumerator StartGlitch()
    {
        while (true)
        {
            float glitchTest = Random.Range(0f, 1f);

            if (glitchTest <= glitchChance)
            {
                if (random)
                {
                    StartCoroutine(RandomGlitch());
                }
                else
                {
                    StartCoroutine(Glitch());
                }
            }
            yield return _glitchLoopWait;
        }
    }
    
    IEnumerator Glitch()
    {
        _holoRenderer.material.SetFloat("_Transparency", Transparency);
        _holoRenderer.material.SetFloat("_CutoutThresh", CutoutThresh);
        _holoRenderer.material.SetFloat("_Speed", Speed);
        _holoRenderer.material.SetFloat("_Amplitude", Amplitude);
        _holoRenderer.material.SetFloat("_Distance", Distance);
        _holoRenderer.material.SetFloat("_Amount", Amount);
        yield return _glitchDuration;
        _holoRenderer.material.SetFloat("_Amount", 0.0f);
        _holoRenderer.material.SetFloat("_CutoutThresh", 0.0f);
    }
    
    IEnumerator RandomGlitch()
    {
        _glitchDuration = new WaitForSeconds(Random.Range(0.05f, 0.25f));
        _holoRenderer.material.SetFloat("_Transparency", Random.Range(0.0f, 1.0f));
        _holoRenderer.material.SetFloat("_CutoutThresh", 0.25f);
        _holoRenderer.material.SetFloat("_Speed", Random.Range(1, 10));
        _holoRenderer.material.SetFloat("_Amplitude", Random.Range(100, 250));
        _holoRenderer.material.SetFloat("_Distance", Random.Range(0.0f, 2.0f));
        _holoRenderer.material.SetFloat("_Amount", 1.0f);
        yield return _glitchDuration;
        _holoRenderer.material.SetFloat("_Amount", 0.0f);
        _holoRenderer.material.SetFloat("_CutoutThresh", 0.0f);
    }
}