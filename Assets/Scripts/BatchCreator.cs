using UnityEngine;

public class BatchCreator : MonoBehaviour
{
    public GameObject staticBatchRoot;
    public GameObject[] gos;
    
    private void Start()
    {
        if (gos != null)
        {
            StaticBatchingUtility.Combine(gos, staticBatchRoot);
        }
        StaticBatchingUtility.Combine(staticBatchRoot);
    }
}