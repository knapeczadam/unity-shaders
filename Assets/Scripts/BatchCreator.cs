using UnityEngine;

public class BatchCreator : MonoBehaviour
{
    public GameObject staticBatchRoot;
    
    private void Start()
    {
        StaticBatchingUtility.Combine(staticBatchRoot);
    }
}